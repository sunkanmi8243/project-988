<?php

namespace App\Interfaces;

use App\Enums\StorageProvider;

interface FileSystemInterface
{
    public function index(string $fullUrl, StorageProvider $provider = StorageProvider::LOCAL);

    public function show(string $fullUrl, StorageProvider $provider = StorageProvider::LOCAL);

    public function store(string $fullUrl, string $location = 'images/', StorageProvider $provider = StorageProvider::LOCAL);

    public function storeAs(string $fullUrl, string $name, string $location = 'images/', StorageProvider $provider = StorageProvider::LOCAL);

    public function patch(string $fullUrl, string $oldFilePath, ?string $name = null, StorageProvider $provider = StorageProvider::LOCAL);

    public function delete(string $fullUrl);
}
