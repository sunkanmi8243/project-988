<?php

namespace App\Traits;

use App\Enums\CartType;
use App\Models\Cart;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

trait InteractWithCart
{
    public function carts(): HasMany
    {

        return $this->hasMany(
            Cart::class,
            'user_id'
        );
    }

    /**
     * @param  CartType  $type
     */
    public function cart(string $key, CartType $name = CartType::CART): Model|Cart
    {

        return (new Cart())
            ->where('key', $key)
            ->where('name', $name)
            ->first();
    }

    public function takeCart(string $key, CartType $type = CartType::CART): Model|Cart
    {

        return tap($this->cart($key, $type))
            ->update([
                'user_id' => $this->id,
            ]);
    }

    public function getCart(CartType $type = CartType::CART): Cart|Model
    {
        return $this->carts()
            ->where('name', $type)
            ->first();
    }

    public function destroyCart(CartType $type = CartType::CART): bool
    {
        return $this->carts()
            ->where('name', $type)
            ->delete();
    }
}
