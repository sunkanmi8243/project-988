<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = User::factory()
            ->create([
                'email' => 'test@commerce.com',
                'password' => 'password',
            ]);

        $user->assignRoles('customer');
    }
}
