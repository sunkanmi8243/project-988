<?php

namespace App\Traits;

use App\Enums\CartType;
use App\Enums\PaymentGateway;
use App\Enums\TransactionStatus;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Currency;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Transaction;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Str;

trait Buyable
{
    public function cart(string|User $key, CartType $type = CartType::CART): Cart
    {
        return Cart::firstOrCreate([
            'key' => $key,
            'name' => $type,
        ], [
            'key' => $key ?? Str::uuid()->toString(),
            'user_id' => auth('sanctum')?->id(),
        ]);
    }

    public function addItem(string $key, int $quantity, CartType $type = CartType::CART, ?float $tax = null): CartItem|Model
    {

        return $this->cart($key, $type)
            ->items()
            ->updateOrCreate([
                'product_id' => $this->id,
            ], [
                'quantity' => $quantity,
                'tax' => $tax ?? config('harde.tax'),
            ]);

    }

    public function removeItem(string $key, CartType $type = CartType::CART): bool
    {
        return $this->cart($key, $type)
            ->items()
            ->where('product_id', $this->id)
            ->delete();
    }

    public function order(Order $order, CartItem $item)
    {
        return $this->orderItems()
            ->updateOrCreate([
                'order_id' => $order->id,
                'price' => $this->discount_price,

            ], [
                'quantity' => $item->quantity,
                'sub_total' => $item->subtotal,
                'total' => $item->total,
                'amount' => $item->priceTax,
                'tax_rate' => $item->taxRate,
            ]);
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class, 'product_id');
    }

    public function orderTo(Order $order)
    {

        return $this->orderItems()
            ->updateOrCreate([
                'order_id' => $order->id,
            ], [
                'price' => $this->price,
                'quantity' => 1,
                'sub_total' => $this->price,
                'total' => $this->price,
                'amount' => $this->price,
                'tax_rate' => 0,
            ]);
    }

    /**
     * Processes user's cart and checkout same cart
     */
    public function processCartAndCheckout(User $user, string $key): Transaction
    {
        $item = $this->addItem($key, 1);
        $user->takeCart($key);

        return $user->orderNow($item->cart)
            ->addItem($item->cart)
            ->issueInvoice(
                Currency::where('name', 'NGN')->first(),
                TransactionStatus::COMPLETED, null, $user
            )->recordTransaction(
                $user,
                $item->cart->total(2, '.', ''),
                null,
                PaymentGateway::WRITEOFF,
                TransactionStatus::WAIVED
            );
    }
}
