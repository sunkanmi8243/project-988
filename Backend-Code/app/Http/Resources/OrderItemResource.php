<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="OrderItemResource")
 * {
 *
 *    @OA\Property(
 *      property="id",
 *      type="integer",
 *      description="The resource Id."
 *    ),
 *   @OA\Property(
 *     property="order_id",
 *     type="integer",
 *     description="The order Id."
 *  ),
 *  @OA\Property(
 *     property="product_id",
 *     type="integer",
 *     description="The product Id."
 * ),
 * @OA\Property(
 *     property="quantity",
 *     type="integer",
 *     description="The quantity of the product."
 * ),
 * @OA\Property(
 *     property="price",
 *     type="number",
 *     description="The price of the product."
 * ),
 * @OA\Property(
 *     property="amount",
 *     type="number",
 *     description="The amount of the product."
 * ),
 * @OA\Property(
 *     property="tax_rate",
 *     type="number",
 *     description="The tax rate of the product."
 * ),
 * @OA\Property(
 *     property="sub_total",
 *     type="number",
 *     description="The sub total of the product."
 * ),
 * @OA\Property(
 *     property="total",
 *     type="number",
 *     description="The total of the product."
 * ),
 * @OA\Property(
 *     property="created_at",
 *     type="string",
 *     description="The created date of the product."
 * ),
 * @OA\Property(
 *     property="updated_at",
 *     type="string",
 *     description="The updated date of the product."
 * ),
 * @OA\Property(
 *     property="product",
 *     ref="#/components/schemas/ProductResource",
 *     description="The product details."
 * ),
 *
 * }
 */
class OrderItemResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'order_id' => $this->order_id,
            'product_id' => $this->product_id,
            'quantity' => $this->quantity,
            'price' => $this->price,
            'amount' => $this->amount,
            'tax_rate' => $this->tax_rate,
            'sub_total' => $this->sub_total,
            'total' => $this->total,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'product' => new ProductResource($this->product),
        ];
    }
}
