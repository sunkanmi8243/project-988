<?php

namespace App\Models;

use App\Enums\CartType;
use App\Traits\CartInteractionMath;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Cart extends Model
{
    use CartInteractionMath, HasFactory;

    protected $fillable = [
        'user_id',
        'key',
        'name',
    ];

    protected $casts = [
        'name' => CartType::class,
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function items(): HasMany
    {
        return $this->hasMany(CartItem::class, 'cart_id');
    }
}
