<?php

namespace App\Models;

use App\Enums\DocumentStatus;
use App\Traits\Buyable;
use App\Traits\Mediable;
use App\Traits\Reviews;
use App\Traits\Searchable;
use App\Traits\Sluggable;
use App\Traits\Thumbnail;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    use Buyable, HasFactory, Mediable,
        Reviews, Searchable, Sluggable, Thumbnail;

    protected $fillable = [
        'description',
        'name',
        'status',
        'category_id',
        'price',
        'slug',
    ];

    protected $casts = [
        'status' => DocumentStatus::class,
        'tags' => 'json',
    ];

    /**
     * Get product category
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    /**
     * Get the route key for the model.
     */
    public function getRouteKeyName(): string
    {
        return 'slug';
    }

    public function carts(): HasMany
    {

        return $this->hasMany(CartItem::class, 'product_id');
    }

    public function scopeByTags(Builder $builder, array $tags = [])
    {
        return $builder->when($tags, function ($query, $tags) {
            $query->where(function ($query) use ($tags) {
                foreach ($tags as $tag) {
                    $query = $query->orwhereJsonContains('tags', $tag);
                }
            });

            return $query;
        });
    }

    public function scopeByClassifications(Builder $builder, array $classifications = [])
    {
        return $builder->when($classifications, function ($query, $classifications) {
            $query->where(function ($query) use ($classifications) {
                foreach ($classifications as $classification) {
                    $query = $query->orWhere('name', 'like', '%'.$classification.'%');
                }
            });

            return $query;
        });
    }
}
