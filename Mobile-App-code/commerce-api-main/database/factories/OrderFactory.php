<?php

namespace Database\Factories;

use App\Enums\OrderStatus;
use App\Models\Address;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Order>
 */
class OrderFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'discount' => $this->faker->numberBetween(5, 20),
            'subtotal' => $this->faker->numberBetween(500, 1000),
            'total' => $this->faker->numberBetween(550, 1100),
            'tax' => $this->faker->numberBetween(10, 50),
            'comment' => $this->faker->sentence,
            'status' => $this->faker->randomElement(OrderStatus::array()),
            'address_id' => Address::factory(),
        ];
    }
}
