<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="ProductResource")
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
 *       property="description",
 *       type="string",
 *       description="The resource description."
 *    ),
 *    @OA\Property(
 *       property="status",
 *       type="string",
 *       description="The resource status."
 *    ),
 *   @OA\Property(
 *       property="category",
 *       type="object",
 *       description="The resource category."
 *   ),
 *   @OA\Property(
 *       property="slug",
 *       type="string",
 *       description="The resource unique slug."
 *   ),
 *   @OA\Property(
 *       property="created_at",
 *       type="date",
 *       description="The resource created date."
 *   ),
 *   @OA\Property(
 *       property="update_at",
 *       type="date",
 *       description="The resource update date."
 *   ),
 * }
 */
class ProductResource extends JsonResource
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
            'name' => $this->name,
            'description' => $this->description,
            'price' => $this->price,
            'slug' => $this->slug,
            'path' => $this->path(true, 'products', 'slug'),
            'status' => $this->status->value,
            'image' => $this->image->url,
            $this->mergeWhen($this->relationLoaded('category'), [
                'category' => new CategoryResource($this->category),
            ]),
        ];
    }
}
