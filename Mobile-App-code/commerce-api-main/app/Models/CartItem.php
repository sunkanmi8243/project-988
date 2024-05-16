<?php

namespace App\Models;

use App\Traits\CartItemAttribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CartItem extends Model
{
    use CartItemAttribute, HasFactory;

    protected $fillable = [
        'quantity',
        'cart_id',
        'product_id',
        'tax',
    ];

    public function cart(): BelongsTo
    {

        return $this->belongsTo(Cart::class, 'cart_id');
    }

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}
