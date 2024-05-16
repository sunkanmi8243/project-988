<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @OA\Schema(schema="AddressResource")
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
 *  @OA\Property(
 *     property="name",
 *     type="string",
 *     description="The name of the user."
 * ),
 * @OA\Property(
 *     property="phone",
 *     type="string",
 *     description="The phone number of the user."
 * ),
 * @OA\Property(
 *     property="email",
 *     type="string",
 *     description="The email of the user."
 * ),
 * @OA\Property(
 *     property="street",
 *     type="string",
 *     description="The street of the user."
 * ),
 * @OA\Property(
 *     property="city",
 *     type="string",
 *     description="The city of the user."
 * ),
 * @OA\Property(
 *     property="state",
 *     type="string",
 *     description="The state of the user."
 * ),
 * @OA\Property(
 *     property="country",
 *     type="string",
 *     description="The country of the user."
 * ),
 * @OA\Property(
 *     property="created_at",
 *     type="string",
 *     description="The date the resource was created."
 * ),
 * @OA\Property(
 *     property="updated_at",
 *     type="string",
 *     description="The date the resource was updated."
 * )
 * @OA\Property(
 *     property="full_address",
 *     type="string",
 *     description="The full address of the user."
 * )
 * }
 */
class AddressResource extends JsonResource
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
            'phone' => $this->phone,
            'email' => $this->email,
            'street' => $this->street,
            'city' => $this->city,
            'state' => $this->state,
            'country' => $this->country,
            'user_id' => $this->user_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'full_address' => $this->full_address,
        ];
    }
}
