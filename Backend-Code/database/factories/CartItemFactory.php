<?php

namespace Database\Factories;

use App\Models\Cart;
use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\CartItem>
 */
class CartItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'product_id' => $this->faker->randomElement(Product::all()->pluck('id')->toArray()),
            'cart_id' => Cart::factory(),
            'quantity' => $this->faker->numberBetween(1, 5),
            'tax' => $this->faker->numberBetween(1, 5),
        ];
    }
}
