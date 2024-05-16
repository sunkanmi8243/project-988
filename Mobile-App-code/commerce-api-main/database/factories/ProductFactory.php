<?php

namespace Database\Factories;

use App\Enums\DocumentStatus;
use App\Models\Category;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->sentence,
            'slug' => $this->faker->unique()->slug,
            'description' => $this->faker->sentence,
            'price' => $this->faker->numberBetween(1, 100),
            'status' => DocumentStatus::PUBLISHED->value,
            'category_id' => Category::factory(),
        ];
    }
}
