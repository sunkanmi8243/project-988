<?php

namespace App\Interfaces;

use App\Models\User;

interface SendBird
{
    public function createUser(User $user, string $method = 'POST', string $uri = 'v3/users');

    public function updateUser(User $user, string $method = 'PUT', string $uri = 'v3/users');

    public function deleteUser(int $userId, string $method = 'DELETE', string $uri = 'v3/users');
}
