<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateAddressRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string'],
            'phone' => ['required', 'string'],
            'email' => ['required', 'string'],
            'street' => [
                'required',
                Rule::unique('addresses', 'street')
                    ->where(fn ($query) => $query->where('user_id', $this->user('api')->id))
                    ->ignore($this->route('address')->id),
            ],
            'city' => ['required'],
            'state' => ['required'],
            'country' => ['nullable', 'string'],
        ];
    }

    public function messages(): array
    {
        return [
            'street.unique' => 'You already have an address with this street name.',
        ];
    }
}
