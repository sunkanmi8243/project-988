<?php

namespace App\Services;

use App\Models\User;
use Laravel\Cashier\Subscription;
use Stripe\Exception\ApiErrorException;
use Stripe\StripeClient;
use Stripe\Transfer;

class StripeGateway implements \App\Interfaces\PaymentGatewayInterface
{
    public function subscribe(User $customer, string $plan, string $paymentMethod, bool $isOnTrial = false): Subscription
    {
        $subscription = $customer->newSubscription('Platform', $plan);

        $subscription = $isOnTrial ? $subscription->trialDays(config('services.stripe.trial'))->create($paymentMethod) :
            $subscription->create($paymentMethod);
        $customer->addPaymentMethod($paymentMethod);
        $customer->updateDefaultPaymentMethodFromStripe();

        return $subscription;

    }

    public function createSetupIntent(User $user): \Stripe\SetupIntent
    {
        return $user->createSetupIntent();
    }

    public function cancel(User $customer, string $subscriptionName = 'Platform'): Subscription
    {
        return $customer->subscription($subscriptionName)->cancel();
    }

    public function resume(User $customer, string $subscriptionName = 'Platform'): Subscription
    {
        return $customer->subscription($subscriptionName)->resume();
    }

    public function products(int $limit = 5): mixed
    {
        $stripe = new StripeClient(config('cashier.secret'));

        return $stripe->prices->all(['limit' => $limit]);
    }

    /**
     * @throws ApiErrorException
     */
    public function createAccount(User $user): User
    {
        $stripe = $this->stripeInit();
        $account = $stripe->accounts->create([
            'country' => 'US',
            'type' => 'express',
            'email' => $user->email,
        ]);

        $user->update([
            'stripe_connect_id' => $account->id,
        ]);

        return $user->refresh();
    }

    /**
     * Get account linking url
     *
     * @throws ApiErrorException
     */
    public function AccountLink(User $user, string $refresh_url, string $return_url): string
    {
        $stripe = $this->stripeInit()->accountLinks->create([
            'account' => $user->stripe_connect_id,
            'refresh_url' => $refresh_url,
            'return_url' => $return_url,
            'type' => 'account_onboarding',
        ]);

        return $stripe->url;
    }

    /**
     * Get stripe customer express account login url
     *
     * @throws ApiErrorException
     */
    public function AccountLogin(User $user): string
    {
        return $this->stripeInit()
            ->accounts->createLoginLink(
                $user->stripe_connect_id
            )->url;
    }

    /**
     * Get stripe customer express account balance
     *
     * @throws ApiErrorException
     */
    public function accountBalance(User $user): int
    {

        return $user->completed_stripe_onboarding ? $this->stripeInit()
            ->balance->retrieve(
                [],
                ['stripe_account' => $user->stripe_connect_id]
            )->available[0]->amount : 0;
    }

    /**
     * Transfer fund from parent account to stripe customer express account
     *
     * @throws ApiErrorException
     */
    public function accountTransfer(User $user, string $chargeId, $amount): Transfer
    {
        $this->stripeInit()
            ->transfers->create([
                'amount' => $amount,
                'currency' => 'usd',
                'source_transaction' => $chargeId,
                'destination' => $user->stripe_connect_id,
            ]);
    }

    /**
     * Transfer fund from parent account to stripe customer express account
     *
     * @throws ApiErrorException
     */
    public function accountTransferTo(User $user, string $amount): Transfer
    {
        $this->stripeInit()
            ->transfers->create([
                'amount' => (int) $amount,
                'currency' => 'usd',
                'destination' => $user->stripe_connect_id,
            ]);
    }

    /**
     * Initialize stripe
     */
    public function stripeInit(): StripeClient
    {
        return new StripeClient(config('cashier.secret'));
    }
}
