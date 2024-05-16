<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
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
            'username' => $this->username,
            'firstname' => $this->firstname,
            'lastname' => $this->lastname,
            'gender' => $this->gender,
            'birthday' => $this->birthday,
            'middlename' => $this->middlename,
            'referral_link' => $this->referral,
            'image' => $this->image->url,
            'email_verified_at' => $this->hasVerifiedEmail(),
            'phone_verified_at' => $this->hasVerifiedPhone(),
            'wallet_balance' => $this->wallet_balance,
            $this->mergeWhen(auth('api')->user()?->is($this), [
                'email' => $this->email,
                'phone' => $this->phone,
            ]),
        ];
    }
}
