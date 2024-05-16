<?php

namespace App\Console\Commands;

use App\Enums\OrderStatus;
use App\Models\Order;
use App\Notifications\OrderCancelled;
use Illuminate\Console\Command;

class CancelOverDueOrders extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'order:cancel-overdue
        {--days= : The number of days after which the order is considered overdue}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Cancel overdue orders after a certain number of days';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $this->info('Cancelling overdue orders...');

        Order::where('status', OrderStatus::PENDING)
            ->where('created_at', '<=', now()->subDays($this->option('days')))
            ->with('user')
            ->cursor()
            ->each(function (Order $order) {
                $order->update(['status' => OrderStatus::CANCELLED]);
                $order->user->notify(new OrderCancelled($order));
            });
    }
}
