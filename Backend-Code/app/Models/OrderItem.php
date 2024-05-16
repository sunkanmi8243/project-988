<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * @OA\Schema(schema="OrderItem")
 * {
 *
 *   @OA\Property(
 *    property="order_id",
 *    type="integer",
 *    description="The reference Order resource ID."
 *   ),
 *   @OA\Property(
 *    property="course_id",
 *    type="integer",
 *    description="The resource Course reference Id."
 *   ),
 *   @OA\Property(
 *    property="quantity",
 *    type="integer",
 *    description="The resource quantity."
 *   ),
 *   @OA\Property(
 *    property="price",
 *    type="integer",
 *    description="The resource product price."
 *   )
 * }
 */
class OrderItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'order_id',
        'quantity',
        'price',
        'amount',
        'sub_total',
        'total',
        'tax_rate',
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class, 'order_id', 'id');
    }
}
