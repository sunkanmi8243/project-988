<?php

namespace Database\Factories;

use App\Enums\CartType;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Cart>
 */
class CartFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => CartType::CART->value,
            'key' => $this->faker->md5,
            'user_id' => User::factory(),
        ];
    }
}
