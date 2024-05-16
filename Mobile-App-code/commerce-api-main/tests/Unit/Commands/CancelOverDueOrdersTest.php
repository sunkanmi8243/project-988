<?php

namespace Tests\Unit\Commands;

use App\Console\Commands\CancelOverDueOrders;
use App\Enums\OrderStatus;
use App\Models\Order;
use App\Notifications\OrderCancelled;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Notification;
use Tests\TestCase;

class CancelOverDueOrdersTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    public function test_it_cancels_overdue_orders()
    {
        Notification::fake();

        // Create a new order that is overdue
        $overdueOrder = Order::factory()->create([
            'status' => OrderStatus::PENDING,
            'created_at' => now()->subDays(5),
        ]);

        // Create a new order that is not overdue
        $notOverdueOrder = Order::factory()->create([
            'status' => OrderStatus::PENDING,
            'created_at' => now()->subDays(2),
        ]);

        // Run the artisan command
        $this->artisan(CancelOverDueOrders::class, ['--days' => 3]);

        $this->assertEquals(OrderStatus::CANCELLED, $overdueOrder->refresh()->status);
        $this->assertEquals(OrderStatus::PENDING, $notOverdueOrder->refresh()->status);

        Notification::assertSentTo($overdueOrder->user, OrderCancelled::class);
        Notification::assertNotSentTo($notOverdueOrder->user, OrderCancelled::class);

    }
}
