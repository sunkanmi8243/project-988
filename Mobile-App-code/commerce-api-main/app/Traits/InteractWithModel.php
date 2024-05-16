<?php

namespace App\Traits;

use Illuminate\Container\Container;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;

trait InteractWithModel
{
    public function getModels($namespace = 'Models')
    {
        $appNamespace = Container::getInstance()->getNamespace();

        return collect(File::allFiles(app_path($namespace)))->map(function ($item) use ($appNamespace, $namespace) {
            $rel = $item->getRelativePathName();

            $class = sprintf('\%s%s%s', $appNamespace, $namespace ? $namespace.'\\' : '',
                implode('\\', explode('/', substr($rel, 0, strrpos($rel, '.')))));

            return class_exists($class) ? $class : null;
        })->filter();
    }

    public function getModel($model, int $position = 2)
    {
        if (class_exists($model)) {
            return explode('\\', $model)[$position];
        }

        return null;
    }

    public function getModelFullPath($model)
    {
        if (class_exists($model)) {
            return $model;
        }

        return null;
    }

    public function resolveClassRelation(mixed $classname, string $suffix = 's'): string
    {
        return Str::lower($this->getModel($classname)).$suffix;
    }

    public function transalateModel($model, $key = 'id')
    {
        if ($this->getModel($model) != null) {
            return strtolower($this->getModel($model)).'_'.$key;
        }

        return null;
    }

    public function translateModelAction(mixed $model, string $action): string
    {
        if ($model instanceof Model) {
            return $this->transalateModel(get_class($model), $action);
        }

        return $this->transalateModel($model, $action);
    }

    public function getRelationshipModelClass(string $relationship): string
    {
        return $this->relationshipModelClass($relationship);
    }

    public function relationshipModelClass(string $relationship): string
    {
        return $this->getModelFullPath(get_class($this->{$relationship}()->getRelated()));
    }

    public function className(Model $model): string
    {

        return $this->getModel(get_class($model));
    }
}
