<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="OrderResource")
 * {
 *
 *    @OA\Property(
 *      property="id",
 *      type="integer",
 *      description="The resource Id."
 *    ),
 *   @OA\Property(
 *     property="user_id",
 *     type="integer",
 *     description="The user Id."
 *  ),
 * @OA\Property(
 *     property="discount",
 *     type="integer",
 *     description="The discount of the order."
 * ),
 * @OA\Property(
 *     property="subtotal",
 *     type="integer",
 *     description="The subtotal of the order."
 * ),
 * @OA\Property(
 *     property="total",
 *     type="integer",
 *     description="The total amount of the order."
 * ),
 * @OA\Property(
 *     property="tax",
 *     type="integer",
 *     description="The tax amount of the order."
 * ),
 * @OA\Property(
 *     property="status",
 *     type="string",
 *     description="The status of the order."
 * ),
 * @OA\Property(
 *     property="comment",
 *     type="string",
 *     description="The comment of the order."
 * ),
 *  @OA\Property(
 *     property="created_at",
 *     type="string",
 *
 *     description="The created date of the order."
 * ),
 * @OA\Property(
 *     property="updated_at",
 *     type="string",
 *     description="The updated date of the order."
 *
 *     )
 * }
 */
class OrderResource extends JsonResource
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
            'user_id' => $this->user_id,
            'discount' => $this->discount,
            'subtotal' => $this->subtotal,
            'total' => $this->total,
            'tax' => $this->tax,
            'status' => $this->status,
            'comment' => $this->comment,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'order_items' => OrderItemResource::collection($this->whenLoaded('orderItems')),
        ];
    }
}
