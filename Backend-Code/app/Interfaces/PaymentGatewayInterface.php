<?php

namespace App\Interfaces;

use App\Models\User;
use Laravel\Cashier\Subscription;
use Stripe\Exception\ApiErrorException;
use Stripe\SetupIntent;
use Stripe\StripeClient;
use Stripe\Transfer;

interface PaymentGatewayInterface
{
    /**
     * @return SetupIntent
     */
    public function createSetupIntent(User $user);

    public function cancel(User $customer, string $subscriptionName = 'Platform'): Subscription;

    public function subscribe(User $customer, string $plan, string $paymentMethod, bool $isOnTrial = false): Subscription;

    /**
     * @return mixed
     */
    public function resume(User $customer, string $subscriptionName = 'Platform'): Subscription;

    public function products(int $limit = 5): mixed;

    /**
     * @throws ApiErrorException
     */
    public function createAccount(User $user): User;

    /**
     * Get account linking url
     *
     * @throws ApiErrorException
     */
    public function AccountLink(User $user, string $refresh_url, string $return_url): string;

    /**
     * Get stripe customer express account login url
     *
     * @throws ApiErrorException
     */
    public function AccountLogin(User $user): string;

    /**
     * Get stripe customer express account balance
     *
     * @throws ApiErrorException
     */
    public function accountBalance(User $user): int;

    /**
     * Transfer fund from parent account to stripe customer express account
     *
     * @throws ApiErrorException
     */
    public function accountTransfer(User $user, string $chargeId, $amount): Transfer;

    /**
     * Transfer fund from parent account to stripe customer express account
     *
     * @throws ApiErrorException
     */
    public function accountTransferTo(User $user, string $amount): Transfer;

    /**
     * Initialize stripe
     */
    public function stripeInit(): StripeClient;
}
