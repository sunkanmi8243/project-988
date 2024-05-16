<?php

namespace App\Traits;

use App\Enums\PaymentGateway;
use App\Enums\TransactionStatus;
use App\Models\Currency;
use App\Models\Invoice;
use App\Models\Transaction;
use Illuminate\Database\Eloquent\Model;

trait Transactions
{
    /**
     * @param  string  $provider
     * @return Invoice
     */
    public function processTransaction(Currency $currency, int $amount, string $reference,
        PaymentGateway $provider = PaymentGateway::PAYSTACK,
        TransactionStatus $invoice = TransactionStatus::PENDING,
        TransactionStatus $status = TransactionStatus::PENDING, string $remark = ''): Transaction
    {
        $order = $this->placeOrder($amount);
        $this->addItemOrder($order);
        $order->issueInvoice(
            $currency, $invoice
        )->recordTransaction(
            $reference,
            $amount,
            $provider,
            $status,
            $remark,
        );

        if ($status === TransactionStatus::COMPLETED || $status === TransactionStatus::PAID) {
            $order->enrollPayee();
            $this->shoppingSession()->delete();
        }
        $order->invoice->send();

        return $order->invoice->transaction();
    }

    public function placeOrder(int $amount, TransactionStatus $status = TransactionStatus::PENDING)
    {
        return $this->orders()
            ->updateOrCreate([
                'total' => $amount,
                'paid_amount' => $amount,
            ],
                [
                    'status' => $status,
                ]);
    }

    public function addItemOrder(Model $order)
    {
        return $this->cart->items->map(fn ($item) => $item->courseable->processOrder($order)
        );
    }
}
