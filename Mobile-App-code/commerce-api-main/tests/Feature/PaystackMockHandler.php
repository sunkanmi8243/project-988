<?php

namespace Tests\Feature;

use App\Interfaces\TransactionInterface;
use App\Models\Transaction;
use App\Services\Paystack;
use App\Services\TransactionService;
use Tests\Supports\PaystackStub;
use Yabacon\Paystack as Payment;

class PaystackMockHandler implements TransactionInterface
{
    use PaystackStub;

    /**
     * @var Paystack
     */
    protected Payment $paystack;

    protected TransactionService $transactionService;

    public function __construct(TransactionService $service)
    {
        $this->transactionService = $service;
    }

    public function verification(Transaction $transaction, int|string $reference)
    {
        $pay = $this->verify($reference);

        return $this->updateTransaction($transaction, $pay->data);
    }

    public function initialize($reference)
    {
        // TODO: Implement initialize() method.
    }

    public function webHook($reference)
    {
        // TODO: Implement webHook() method.
    }

    public function verify(string $reference): object|array
    {
        return $this->verificationData();
    }

    public function updateTransaction(Transaction $transaction, object $pay): Transaction
    {

        return $this->transactionService->update($transaction, $pay);
    }
}
