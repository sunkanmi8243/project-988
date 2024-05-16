<?php

namespace App\Traits;

use App\Services\FileSystem;
use Illuminate\Http\File;
use Illuminate\Http\UploadedFile;

trait Mediable
{
    public function upload(UploadedFile $file, string $name, string $location = 'images')
    {

        return $this->media()
            ->updateOrCreate([
                'mediable_id' => $this->id,
                'mediable_type' => get_class($this),
            ], [
                'path' => $this->uploadFile($file, $location),
                'size' => $file->getSize(),
                'disk' => app(FileSystem::class)->disk,
                'current' => true,
                'description' => $name,
                'mime_type' => $file->getMimeType(),
            ]);
    }

    public function uploadFile(UploadedFile $file, string $location = 'images')
    {
        return app(FileSystem::class)
            ->store(
                $file,
                $location,
                app(FileSystem::class)->disk
            );
    }

    /**
     * Remove product file
     */
    public function removeFile(): bool
    {
        return ($media = $this->media()
            ->first()) ? $media->remove() : false;
    }
}
