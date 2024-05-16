<?php

namespace Database\Seeders;

use App\Enums\StorageProvider;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $categories = collect(Category::all())->keyBy('slug');

        $products = json_decode(file_get_contents(database_path('stubs/products.json')), true);

        collect($products)->map(function ($product) use ($categories) {

            Product::factory()
                ->hasMedia(1, [
                    'path' => $product['image_url'],
                    'disk' => StorageProvider::CLOUDINARY,
                    'current' => true,
                ])->create([
                    'name' => Str::title($product['name']),
                    'slug' => Str::slug($product['name']),
                    'tags' => $product['tags'],
                    'category_id' => $categories[$product['category']]->id,
                    'description' => $product['description'],
                ]);
        });
    }
}
