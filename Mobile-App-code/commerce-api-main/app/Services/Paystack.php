<?php

namespace App\Services;

use App\Models\Transaction;
use Yabacon\Paystack as Payment;

class Paystack implements \App\Interfaces\TransactionInterface
{
    /**
     * @var Paystack
     */
    protected Payment $paystack;

    protected TransactionService $transactionService;

    public function __construct(TransactionService $service)
    {
        $this->transactionService = $service;
        $this->paystack = new Payment(env('PAYSTACK_SECRET_KEY'));
    }

    public function verification(Transaction $transaction, string|int $reference): Transaction
    {
        $pay = $this->verify($reference);

        return $this->updateTransaction($transaction, $pay->data);
    }

    public function verify(string $reference): object|array
    {
        return $this->paystack->transaction->verify([
            'reference' => $reference, // unique to transactions
        ]);
    }

    public function updateTransaction(Transaction $transaction, object $pay): Transaction
    {
        return $this->transactionService->update($transaction, $pay);
    }

    public function initialize($reference)
    {
        // TODO: Implement initialize() method.
    }

    public function webHook($reference)
    {
        // TODO: Implement webHook() method.
    }
}
