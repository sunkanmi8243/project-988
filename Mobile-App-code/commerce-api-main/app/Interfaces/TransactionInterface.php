<?php

namespace App\Interfaces;

use App\Models\Transaction;

interface TransactionInterface
{
    public function verification(Transaction $transaction, string|int $reference);

    public function initialize($reference);

    public function webHook($reference);

    public function verify(string $reference): object|array;

    public function updateTransaction(Transaction $transaction, object $pay): Transaction;
}
