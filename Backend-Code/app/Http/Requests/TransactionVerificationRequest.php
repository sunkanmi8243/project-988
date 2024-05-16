<?php

namespace App\Http\Requests;

use App\Enums\PaymentGateway;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Enum;

/**
 * @OA\Schema(schema="TransactionVerificationRequest")
 * {
 *
 *   @OA\Property(
 *     property="reference",
 *     type="string",
 *     description="The transaction reference code"
 *   ),
 *   @OA\Property(
 *     property="provider",
 *     type="string",
 *     description="The Payment Gateway name. Example: PAYSTACK, FLUTTERWAVE and STRIPE"
 *   )
 * }
 */
class TransactionVerificationRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return auth('api')->check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'reference' => 'required|string',
            'provider' => [new Enum(PaymentGateway::class)],
        ];
    }
}
