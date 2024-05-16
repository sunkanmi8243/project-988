<?php

namespace App\Traits;

use App\Enums\DocumentStatus;
use Illuminate\Database\Eloquent\Builder;

trait Searchable
{
    public function scopeSearchName(Builder $builder, ?string $terms = null)
    {
        $builder->where(function ($builder) use ($terms) {
            collect(explode(' ', $terms))->filter()->each(function ($term) use ($builder) {
                $term = '%'.$term.'%';
                $builder->orWhere('name', 'like', $term);

            });
        });
    }

    public function scopeStatus($query, DocumentStatus $status = DocumentStatus::PUBLISHED)
    {
        $query->where('status', $status);
    }

    public function scopeFilterByCategory(Builder $builder, ?string $terms = null)
    {
        $builder->when($terms ?? false, function ($builder, $terms) {
            $builder->orWhereHas('category', function ($builder) use ($terms) {
                $builder->where('name', $terms);
            });
        });

    }
}
