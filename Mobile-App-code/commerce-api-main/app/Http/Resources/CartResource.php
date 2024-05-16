<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="CartResource")
 * {
 *
 *   @OA\Property(
 *       property="id",
 *       type="integer",
 *       description="The user id"
 *    ),
 *   @OA\Property(
 *       property="name",
 *       type="string",
 *       description="The resource name"
 *    ),
 *   @OA\Property(
 *       property="key",
 *       type="string",
 *       description="The resource key"
 *    ),
 * }
 */
class CartResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->type->value,
            'key' => $this->key,
            'subtotal' => $this->subtotal(),
            'tax' => $this->tax(),
            'total' => $this->total(),
            $this->mergeWhen($this->relationLoaded('items'), [
                'items' => CartItemResource::collection($this->items),
            ]),
        ];
    }
}
