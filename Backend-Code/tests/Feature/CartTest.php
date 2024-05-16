<?php

namespace Tests\Feature;

use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Testing\Fluent\AssertableJson;
use Tests\TestCase;

class CartTest extends TestCase
{
    use RefreshDatabase;

    /** @test */
    public function a_product_can_be_added_to_cart(): void
    {

        $product = Product::factory()->create();

        $response = $this->postJson(route('v1.carts.store'), [
            'product' => $product->id,
        ])->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->has('data')
            ->where('message', 'Added to cart successfully.')
            ->where('data.key', $product->carts()->first()->cart->key)
            ->etc()
        );

    }

    /** @test */
    public function a_product_can_be_remove_from_cart(): void
    {

        $item = Product::factory()->create()
            ->addItem('wehguyedje', 1);

        $response = $this->deleteJson(route('v1.carts.destroy', [
            'product' => $item->product->id,
            'key' => $item->cart->key,
        ]), [

        ])->assertStatus(204);
    }

    /** @test */
    public function multiple_products_can_be_added_to_cart_with_same_key(): void
    {

        $product = Product::factory()->create();

        $item = Product::factory()->create()
            ->addItem('wehguyedje', 1);

        $response = $this->postJson(route('v1.carts.store'), [
            'product' => $product->id,
            'key' => $item->cart->key,
        ])->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->has('data')
            ->where('message', 'Added to cart successfully.')
            ->where('data.key', $product->carts()->first()->cart->key)
            ->etc()
        );

        $this->assertCount(2, $item->cart->items);
        $this->assertDatabaseCount('carts', 1);

    }

    /** @test */
    public function authenticated_user_owns_the_cart(): void
    {

        $user = User::factory()->create();

        $this->actingAs($user, 'sanctum');

        $product = Product::factory()->create();

        $item = Product::factory()->create()
            ->addItem('wehguyedje', 1);

        $response = $this
            ->postJson(route('v1.carts.store'), [
                'product' => $product->id,
                'key' => $item->cart->key,
            ])->assertOk();

        $this->assertCount(2, $item->cart->items);
        $this->assertDatabaseCount('carts', 1);
        $this->assertDatabaseHas('carts', [
            'user_id' => $user->id,
            'key' => $item->cart->key,
        ]);

    }

    /** @test */
    public function an_unauthenticated_user_may_get_owns_cart_items(): void
    {

        $user = User::factory()->create();

        $item = Product::factory()->create()
            ->addItem('njbjbghjnsjujs', 1);

        Product::factory(10)->create()
            ->map(fn ($product) => $product->addItem($item->cart->key, 1));

        $response = $this
            ->getJson(route('v1.carts.index', [
                'key' => $item->cart->key,
            ]))
            ->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->has('data', 10)
            ->has('subtotal')
            ->has('total')
            ->has('tax')
            ->where('message', 'success')
            ->etc()
        );

    }

    /** @test */
    public function a_user_can_view_paginated_carts_items_list(): void
    {
        $item = Product::factory()->create()
            ->addItem('njbjbghjnsjujs', 1);
        Product::factory(20)->create()
            ->map(fn ($product) => $product->addItem($item->cart->key, 1));

        $response = $this->getJson(route('v1.carts.index', ['key' => 'njbjbghjnsjujs']))->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->has('data', 10)
            ->where('message', 'success')
            ->etc()
        );

    }

    /** @test */
    public function a_user_can_update_cart(): void
    {
        $item = Product::factory()->create()
            ->addItem('njbjbghjnsjujs', 1);

        $response = $this->patchJson(route('v1.carts.update', [
            'product' => $item->product->id,
            'quantity' => 2,
            'key' => $item->cart->key,
        ]))->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->where('data.quantity', 2)
            ->where('message', 'success')
            ->etc()
        );

    }

    /** @test */
    public function one_product_can_be_removed_from_multiple_products_can_be_added_to_cart_with_same_key(): void
    {

        $product = Product::factory()->create();

        $item = Product::factory()->create()
            ->addItem('wehguyedje', 1);

        $response = $this->postJson(route('v1.carts.store'), [
            'product' => $product->refresh()->id,
            'key' => $item->cart->key,
        ])->assertOk();

        $response->assertJson(fn (AssertableJson $json) => $json
            ->where('status', true)
            ->has('data')
            ->where('message', 'Added to cart successfully.')
            ->where('data.key', $product->carts()->first()->cart->key)
            ->etc()
        );

        $this->assertCount(2, $item->cart->items);
        $this->assertDatabaseCount('carts', 1);

        $response = $this->deleteJson(route('v1.carts.destroy', [
            'product' => $item->product->id,
            'key' => $item->cart->key,
        ]), [

        ])->assertStatus(204);

        $this->assertDatabaseHas('cart_items', [
            'product_id' => $product->id,
        ]);
        $this->assertDatabaseCount('cart_items', 1);

    }
}
