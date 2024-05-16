<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Address extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'email', 'phone', 'street', 'city', 'state', 'country', 'user_id',
    ];

    protected $appends = ['full_address'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function fullAddress(): Attribute
    {
        return Attribute::get(
            fn ($value, $attributes) => "{$attributes['street']}, {$attributes['city']}, {$attributes['state']}, {$attributes['country']}"
        );
    }
}
