<?php

namespace Database\Factories;

use App\Models\Order;
use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\OrderItem>
 */
class OrderItemFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'order_id' => Order::factory(),
            'product_id' => $this->faker->randomElement(Product::all()->pluck('id')->toArray()),
            'quantity' => $this->faker->numberBetween(2, 5),
            'price' => $this->faker->numberBetween(1, 100),
            'tax_rate' => $this->faker->numberBetween(1, 7),
            'amount' => $this->faker->numberBetween(10, 500),
            'sub_total' => $this->faker->numberBetween(10, 500),
            'total' => $this->faker->numberBetween(20, 1000),
        ];
    }
}
