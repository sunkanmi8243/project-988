<?php

namespace App\Traits;

use App\Enums\StorageProvider;
use App\Models\Media;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphMany;

trait Thumbnail
{
    public function media(): MorphMany
    {
        return $this->morphMany(Media::class, 'mediable');
    }

    public function thumbnail(): string
    {
        return $this->media()
            ->where('current', true)
            ->first()?->path() ?? $this->default();
    }

    /**
     * Create new media instance on the fly when one does not exist
     */
    protected function default(): Model
    {
        return ($this instanceof User) ?
            new Media([
                'path' => config('harde.placeholder.profile.path'),
                'disk' => StorageProvider::PUBLIC,
            ]) :

            new Media([
                'path' => config('harde.placeholder.image.path'),
                'disk' => StorageProvider::PUBLIC,
            ]);
    }

    public function getImageAttribute(): Media|Model
    {
        return $this->media()
            ->where('current', true)
            ->first() ?? $this->default();
    }
}
