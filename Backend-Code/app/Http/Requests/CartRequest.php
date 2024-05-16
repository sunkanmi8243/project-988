<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

/**
 * @OA\Schema(schema="CartRequest")
 * {
 *
 *   @OA\Property(
 *     property="course_id",
 *     type="integer",
 *     description="The Course resource Id"
 *   ),
 *   @OA\Property(
 *     property="key",
 *     type="integer",
 *     description="The Session Identifier UUid."
 *   )
 * }
 */
class CartRequest extends FormRequest
{
    protected function passedValidation()
    {
        if (! $this->quantity) {
            $this->merge(['quantity' => 1]);
        }
    }

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
            'product' => $this->is('v1.carts.store') ? 'required|numeric' : 'nullable|numeric',
            'key' => 'nullable|string',
            'quantity' => 'nullable|numeric',
        ];
    }
}
