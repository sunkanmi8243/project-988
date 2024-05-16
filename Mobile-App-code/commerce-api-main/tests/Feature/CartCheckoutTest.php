<?php

namespace Tests\Feature;

use App\Enums\OrderStatus;
use App\Enums\TransactionStatus;
use App\Models\Address;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use App\Notifications\OrderPaid;
use App\Notifications\OrderPlaced;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Notification;
use Illuminate\Testing\Fluent\AssertableJson;
use Tests\TestCase;

class CartCheckoutTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    /** @test */
    public function checkout_should_be_successful_when_user_enough_balance(): void
    {
        Notification::fake();
        $key = $this->faker->md5;
        $product = Product::factory()->create(['price' => 20_0000]);

        $item = $product->addItem($key, 1);
        $product->addItem($item->cart->key, 1);

        Product::factory()
            ->create()
            ->addItem($item->cart->key, 1);

        $cartTotal = $item->cart->fresh()->total(2, '.', '');

        $user = User::factory()->create(['wallet_balance' => 30_0000 + $cartTotal]);
        $address = Address::factory()->for($user)->create();
        $this->actingAs($user, 'api');
        $cart = $user->takeCart($item->cart->key);

        $response = $this->postJson(route('v1.carts.checkout', ['cart' => $item->cart->key]), ['address_id' => $address->id])
            ->assertSuccessful();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->where('data.status', OrderStatus::PAID->value)
            ->etc()
        );

        $order = Order::where('id', $response->json('data.id'))->first();

        $this->assertNotNull($order);
        $this->assertEquals(OrderStatus::PAID, $order->status);
        $this->assertEquals($address->id, $order->address_id);
        $this->assertEquals($user->id, $order->user_id);

        $this->assertEquals(30_0000, $user->fresh()->wallet_balance);
        $this->assertModelMissing($cart);

        Notification::assertSentTo($user, OrderPlaced::class);
        Notification::assertSentTo($user, OrderPaid::class);

    }

    /** @test */
    public function checkout_should_fail_when_user_dose_not_have_enough_balance(): void
    {
        Notification::fake();
        $key = $this->faker->md5;
        $user = User::factory()->create(['wallet_balance' => 10_0000]);
        $address = Address::factory()->for($user)->create();

        $product = Product::factory()->create(['price' => 20_0000]);
        $this->actingAs($user, 'api');

        $item = $product->addItem($key, 1);
        $product->addItem($item->cart->key, 1);

        Product::factory()
            ->create()
            ->addItem($item->cart->key, 1);

        $cart = $user->takeCart($item->cart->key);

        $response = $this->postJson(
            route('v1.carts.checkout', [
                'cart' => $item->cart->key,
            ]), ['address_id' => $address->id]
        )->assertBadRequest();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', false)
            ->where('data.status', TransactionStatus::PENDING->value)
            ->etc()
        );

        $order = Order::where('id', $response->json('data.id'))->first();

        $this->assertNotNull($order);
        $this->assertEquals(OrderStatus::PENDING, $order->status);
        $this->assertEquals($address->id, $order->address_id);
        $this->assertEquals($user->id, $order->user_id);
        $this->assertModelMissing($cart);

        $this->assertEquals(10_0000, $user->fresh()->wallet_balance);
        Notification::assertSentTo($user, OrderPlaced::class);
        Notification::assertNotSentTo($user, OrderPaid::class);
    }
}
