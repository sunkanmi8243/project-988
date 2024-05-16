<?php

namespace App\Http\Controllers\Web;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Notifications\OrderCancelled;
use App\Notifications\OrderCompleted;
use App\Notifications\OrderShipped;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index(Request $request)
    {
        $orders = Order::with('user')->paginate(10);

        return view('orders.index', ['orders' => $orders]);
    }

    public function show(int $id)
    {
        $order = Order::with('user', 'orderItems.product')->findOrFail($id);

        return view('orders.show', ['order' => $order]);
    }

    public function markAsShipped(int $id)
    {
        $order = Order::with('user')->findOrFail($id);

        if ($order->status !== OrderStatus::PAID) {
            return redirect()->back()->with('error', 'You can only mark paid orders as shipped');
        }

        $order->update(['status' => OrderStatus::SHIPPED]);

        $order->user->notify(new OrderShipped($order));

        return redirect()->back()->with('success', 'Order marked as shipped');
    }

    public function markAsCompleted(int $id)
    {
        $order = Order::with('user')->findOrFail($id);

        if ($order->status !== OrderStatus::SHIPPED) {
            return redirect()->back()->with('error', 'You can only mark shipped orders as completed');
        }

        $order->update(['status' => OrderStatus::COMPLETED]);

        $order->user->notify(new OrderCompleted($order));

        return redirect()->back()->with('success', 'Order marked as completed');
    }

    public function markAsCancelled(int $id)
    {
        $order = Order::with('user')->findOrFail($id);

        if ($order->status == OrderStatus::CANCELLED) {
            return redirect()->back()->with('error', 'Order already cancelled');
        }

        if (in_array($order->status, [OrderStatus::COMPLETED, OrderStatus::SHIPPED])) {
            return redirect()->back()->with('error', 'You cannot cancel a completed or shipped order');
        }

        if ($order->status == OrderStatus::PAID) {
            $order->user->update(['wallet_balance' => $order->user->wallet_balance + $order->total]);
        }

        $order->update(['status' => OrderStatus::CANCELLED]);
        $order->user->notify(new OrderCancelled($order));

        return redirect()->back()->with('success', 'Order marked as cancelled');
    }
}
