<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use App\Enums\UserStatus;
use App\Http\Resources\UserResource;
use App\Traits\ApiMustVerify;
use App\Traits\HasRoles;
use App\Traits\InteractWithCart;
use App\Traits\InteractWithInvoice;
use App\Traits\InteractWithOrder;
use App\Traits\Thumbnail;
use App\Traits\WithAttribute;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject, MustVerifyEmail
{
    use ApiMustVerify, HasApiTokens, HasFactory, HasRoles,
        InteractWithCart, InteractWithInvoice, InteractWithOrder,
        Notifiable, SoftDeletes, Thumbnail, WithAttribute;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'lastname',
        'middlename',
        'firstname',
        'phone',
        'email',
        'password',
        'status',
        'username',
        'referrer_id',
        'birthday',
        'gender',
        'wallet_balance',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'birthday' => 'date',
        'phone_verified_at' => 'datetime',
        'password' => 'hashed',
        'status' => UserStatus::class,
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return (new UserResource($this->load('roles')))
            ->toResponse(app('request'))->getData(true);
    }

    public function addresses(): HasMany
    {
        return $this->hasMany(Address::class);
    }
}
