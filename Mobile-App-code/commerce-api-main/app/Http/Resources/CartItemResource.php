<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="CartItemResource")
 * {
 *
 *    @OA\Property(
 *      property="id",
 *      type="integer",
 *      description="The resource Id."
 *    ),
 *    @OA\Property(
 *      property="name",
 *      type="string",
 *      description="The resource name."
 *    ),
 *    @OA\Property(
 *      property="image",
 *      type="string",
 *      description="The resource image."
 *    ),
 *   @OA\Property(
 *       property="created_at",
 *       type="date",
 *       description="The resource created date."
 *   ),
 * }
 */
class CartItemResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->product->id,
            'key' => $this->cart?->key,
            'price' => $this->product->price,
            'image' => $this->product->image?->url,
            'quantity' => $this->quantity,
            'name' => $this->product->name,
            'slug' => $this->product->slug,
            'description' => $this->product->description,
            'path' => $this->product->path(true, 'products', 'slug'),
            'created_at' => $this->created_at,
            'total' => $this->total,
            'subtotal' => $this->subTotal,
            'taxRate' => $this->taxRate,
        ];
    }
}
