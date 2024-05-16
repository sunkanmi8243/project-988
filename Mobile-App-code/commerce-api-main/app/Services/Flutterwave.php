<?php

namespace App\Services;

use App\Models\Transaction;

class Flutterwave implements \App\Interfaces\TransactionInterface
{
    public function verification(Transaction $transaction, int|string $reference)
    {
        // TODO: Implement verification() method.
    }

    public function initialize($reference)
    {
        // TODO: Implement initialize() method.
    }

    public function webHook($reference)
    {
        // TODO: Implement webHook() method.
    }

    /**
     * {@inheritDoc}
     */
    public function verify(string $reference): object|array
    {
        // TODO: Implement verify() method.
    }

    /**
     * {@inheritDoc}
     */
    public function updateTransaction(Transaction $transaction, object $pay): Transaction
    {
        // TODO: Implement updateTransaction() method.
    }
}
