<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

/**
 * @OA\Schema(schema="CheckoutRequest")
 * {
 *
    @OA\Property(
 *     property="address_id",
 *     type="string",
 *     description="The id of the address"
 * ),
 * }
 */
class CheckoutRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'address_id' => [
                'required',
                Rule::exists('addresses', 'id')->where(fn ($query) => $query->where('user_id', $this->user('api')->id)),
            ],
        ];
    }

    public function attributes(): array
    {
        return [
            'address_id' => 'address',
        ];
    }

    public function messages(): array
    {
        return [
            'address_id.exists' => 'The selected address does not exist.',
        ];
    }
}
