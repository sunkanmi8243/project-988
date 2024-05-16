<?php

namespace App\Traits;

use App\Enums\TransactionStatus;
use App\Models\Cart;
use App\Models\Order;
use Illuminate\Database\Eloquent\Relations\HasMany;

trait InteractWithOrder
{
    public function orders(): HasMany
    {

        return $this->hasMany(
            Order::class,
            'user_id'
        );
    }

    public function orderNow(Cart $cart, array $orderData = [], ?int $paid = null)
    {
        $total = $cart->total(2, '.', '');

        return $this->orders()
            ->updateOrCreate([
                'status' => TransactionStatus::PENDING,
                'total' => $total,
                'subtotal' => $cart->subtotal(2, '.', ''),
            ], array_merge([
                'paid' => $paid ?? $total,
                'tax' => $cart->tax(2, '.', ''),
                'email' => $this->email,
            ], $orderData));
    }
}
