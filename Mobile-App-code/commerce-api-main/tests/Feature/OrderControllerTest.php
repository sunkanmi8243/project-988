<?php

namespace Tests\Feature;

use App\Enums\OrderStatus;
use App\Models\Address;
use App\Models\Order;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class OrderControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_get_list_of_orders()
    {
        $user = User::factory()->create();
        $address = Address::factory()->for($user)->create();
        $orders = Order::factory()->count(3)
            ->for($user)
            ->for($address)
            ->create();

        $response = $this->actingAs($user, 'api')->getJson(route('v1.orders.index'));

        $response->assertStatus(200);
        $response->assertJsonCount(3, 'data');
        $this->assertEquals($orders->pluck('id'), collect($response->json('data'))->pluck('id'));
    }

    public function test_can_get_the_details_of_single_order()
    {
        $user = User::factory()->create();
        $address = Address::factory()->for($user)->create();
        $order = Order::factory()->for($user)->for($address)->create();

        $response = $this->actingAs($user, 'api')->getJson(route('v1.orders.show', $order->id));

        $response->assertStatus(200);
        $response->assertJsonPath('data.id', $order->id);
        $response->assertJsonPath('data.user_id', $user->id);
    }

    public function test_can_pay_for_a_pending_order()
    {
        $user = User::factory()->create(['wallet_balance' => 500]);
        $address = Address::factory()->for($user)->create();
        $order = Order::factory()->for($user)->for($address)->create(['total' => 200, 'status' => OrderStatus::PENDING]);

        $response = $this->actingAs($user, 'api')->postJson(route('v1.orders.pay', $order->id));

        $response->assertStatus(200);
        $this->assertDatabaseHas('orders', [
            'id' => $order->id,
            'status' => OrderStatus::PAID,
        ]);

        $this->assertEquals(300, $user->fresh()->wallet_balance);
    }

    public function test_can_not_pay_with_insufficient_balance()
    {
        $user = User::factory()->create(['wallet_balance' => 100]);
        $address = Address::factory()->for($user)->create();
        $order = Order::factory()->for($user)->for($address)->create(['total' => 200, 'status' => OrderStatus::PENDING]);

        $this->actingAs($user, 'api')->postJson(route('v1.orders.pay', $order->id))->assertBadRequest();

        $this->assertEquals(100, $user->fresh()->wallet_balance);
        $this->assertDatabaseHas('orders', [
            'id' => $order->id,
            'status' => OrderStatus::PENDING,
        ]);
    }

    public function test_can_not_pay_paid_order()
    {
        $user = User::factory()->create(['wallet_balance' => 500]);
        $address = Address::factory()->for($user)->create();
        $order = Order::factory()->for($user)->for($address)->create(['total' => 200, 'status' => OrderStatus::PAID]);

        $this->actingAs($user, 'api')->postJson(route('v1.orders.pay', $order->id))->assertBadRequest();

        $this->assertEquals(500, $user->fresh()->wallet_balance);
        $this->assertDatabaseHas('orders', [
            'id' => $order->id,
            'status' => OrderStatus::PAID,
        ]);
    }
}
