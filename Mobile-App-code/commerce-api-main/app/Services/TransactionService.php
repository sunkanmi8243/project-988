<?php

namespace App\Services;

use App\Enums\InvoiceStatus;
use App\Enums\OrderStatus;
use App\Enums\PaymentGateway;
use App\Enums\TransactionStatus;
use App\Models\Currency;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class TransactionService
{
    public function create($record, $provider = 'Paystack')
    {
        return DB::transaction(function () use ($record, $provider) {
            $customer = $this->customer($record->customer->email);

            return $customer->processTransaction(
                Currency::where('currency', $record->currency)->first(),
                $record->amount,
                $record->reference,
                $provider == 'paystack' ? PaymentGateway::PAYSTACK : PaymentGateway::FLUTTERWAVE,
                $record->status == 'success' ? InvoiceStatus::PAID : InvoiceStatus::NOTPAID,
                $record->status == 'success' ? TransactionStatus::PAID : TransactionStatus::PENDING,
                $record->status
            );
        });
    }

    public function paid(User $user, Currency $currency, $amount, $reference, $provider)
    {
        DB::transaction(function () use ($user, $currency, $amount, $reference, $provider) {
            $order = $user->order($amount);
            $order->issueInvoice(
                $currency, TransactionStatus::PAID
            )->recordTransaction(
                $reference,
                $provider,
                $amount,
                TransactionStatus::COMPLETED
            );
            $order->enrollPayee();
        });
    }

    protected function customer(string $email)
    {
        return User::where('email', $email)->firstOrFail();
    }

    public function update(Transaction $transaction, $payment): Transaction
    {

        return tap($transaction, function ($transaction) use ($payment) {
            $transaction
                ->update([
                    'status' => $payment->status == 'success' ? TransactionStatus::PAID : TransactionStatus::PENDING,
                    'email' => $payment->customer->email,
                    'amount' => $payment->amount,

                    'account_name' => $payment->authorization->account_name,
                    'ip_address' => $payment->ip_address,
                    'reusable' => $payment->authorization->reusable,
                    'authorization_code' => $payment->authorization->authorization_code,
                    'currency' => $payment->currency,
                    'card_type' => $payment->authorization->card_type,
                    'last4' => $payment->authorization->last4,
                    'exp_month' => $payment->authorization->exp_month,
                    'exp_year' => $payment->authorization->exp_year,
                    'bank' => $payment->authorization->bank,
                    'channel' => $payment->channel,
                    'remark' => $payment->message,
                ]);

            $order = $transaction->updateInvoice(
                Currency::where('name', $payment->currency)->first(),
                $payment->status == 'success' ? TransactionStatus::PAID : TransactionStatus::PENDING,
            )
                ->updateOrder()
                ->setStatus($payment->status == 'success' ? OrderStatus::PAID : OrderStatus::PENDING);
            $transaction->syncInvoiceOwner();
            $transaction->invoice->send();
            $transaction->user->destroyCart();
        });

    }
}
