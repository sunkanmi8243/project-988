<?php

namespace App\Traits;

use App\Services\FileSystem;
use Illuminate\Support\Str;
use RecursiveDirectoryIterator;
use RecursiveIteratorIterator;

trait FileSystemTrait
{
    public function createMediaName(string $name): string
    {
        return Str::uuid()->toString();
    }

    /**
     * @return string|bool - The full url of the file. for example:
     *                     /Users/apple/Documents/projects/harde-server/storage/app/uploads/images/creativity-innovation.jpg
     */
    public function getLocalFilePath(mixed $filename, string $path = 'uploads'): string|bool
    {
        $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator(storage_path($path)));

        foreach ($iterator as $file) {
            if ($file->getFilename() === $filename) {
                return $file->getPathname();
            }
        }

        return false;
    }

    public function name(string $filename): string
    {
        return $this->getName($filename);
    }

    public function remove(): bool
    {
        return (new FileSystem())->destroy(
            $this->path,
            $this->disk
        );
    }
}
