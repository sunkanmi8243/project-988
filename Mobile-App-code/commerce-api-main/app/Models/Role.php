<?php

namespace App\Models;

use App\Traits\HasRoles;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * @OA\Schema(schema="Role")
 * {
 *
 *   @OA\Property(
 *    property="name",
 *    type="string",
 *    description="The resource name."
 *    ),
 *    @OA\Property(
 *       property="label",
 *       type="string",
 *       description="The resource label."
 *    ),
 *    @OA\Property(
 *       property="is_system",
 *       type="boolean",
 *       description="The resource role is system."
 *    )
 * }
 */
class Role extends Model
{
    use HasFactory, HasRoles;

    /**
     * @var string[]
     */
    protected $fillable = [
        'name',
        'label',
        'description',
    ];

    /**
     * @var string[]
     */
    protected $casts = ['is_system' => 'boolean'];

    public function permissions()
    {
        return $this->belongsToMany(Permission::class)->withTimestamps();
    }

    public function givePermissionTo(Permission $permission)
    {
        return $this->permissions()->sync($permission, false);
    }

    public function scopeSearch(Builder $builder, string $terms)
    {
        collect(explode(' ', $terms))->filter()->each(function ($term, $index) use ($builder) {
            $term = '%'.$term.'%';
            $builder->orWhere(function ($builder) use ($term) {
                $builder->where('name', 'like', $term);
            });
        });
    }
}
