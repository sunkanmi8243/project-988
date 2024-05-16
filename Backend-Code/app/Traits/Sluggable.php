<?php

namespace App\Traits;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

trait Sluggable
{
    public static function bootSluggable()
    {
        // Start a new synchronization once created.
        static::created(function ($model) {
            static::sluggable($model);
        });
    }

    protected static function sluggable(Model $model)
    {
        if ($model instanceof User) {
            $slug = $model->username;
            if (self::whereUsername($model->username)->exists()) {
                $firstname = Str::slug($model->firstname);
                $lastname = Str::slug($model->lastname);

                $slug = $firstname.'.'.$lastname;

                $i = 0;
                while (self::whereUsername($slug)->exists()) {
                    $i++;
                    $slug = $firstname.'.'.$lastname.$i;
                }
            }
            $model->update(['username' => $slug]);
        } else {
            if (collect($model->fillable)->contains('slug')) {
                if (self::whereSlug($model->slug)->exists() && empty($model->slug)) {

                    $slug = Str::slug($model->name);

                    $i = 0;
                    while (self::whereSlug($slug)->exists()) {
                        $i++;
                        $slug = $slug.$i;
                    }
                    $model->update(['slug' => $slug]);
                }

            }
        }

    }

    public function path(bool $fullPath = false, string $route = 'products', string $key = 'slug')
    {
        return $fullPath === false ? "api/v1/{$route}/{$this->$key}" :
            url("/api/v1/{$route}/{$this->$key}");
    }
}
