<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        $categories = [
            [
                'name' => 'Alcohols',
                'slug' => 'alcohols',
            ],
            [
                'name' => 'Beverages',
                'slug' => 'beverages',
            ],
            [
                'name' => 'Fruits',
                'slug' => 'fruits',
            ],
            [
                'name' => 'Grains',
                'slug' => 'grains',
            ],
            [
                'name' => 'Vegetables',
                'slug' => 'vegetables',
            ],
            [
                'name' => 'Others',
                'slug' => 'others',
            ],
        ];

        Category::insert($categories);
    }
}
