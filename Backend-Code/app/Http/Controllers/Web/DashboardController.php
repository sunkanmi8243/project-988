<?php

namespace App\Http\Controllers\Web;

use App\Enums\OrderStatus;
use App\Enums\UserStatus;
use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $users = User::all(['id', 'status']);
        $userCollection = collect($users);
        $totalUsers = $userCollection->count();
        $totalActiveUsers = $userCollection->where('status', UserStatus::ACTIVE)->count();
        $totalSuspendedUsers = $userCollection->where('status', UserStatus::SUSPENDED)->count();
        $totalProducts = Product::count();
        $orders = Order::all(['id', 'status']);
        $orderCollection = collect($orders);
        $totalOrders = $orderCollection->count();
        $totalPendingOrders = $orderCollection->where('status', OrderStatus::PENDING)->count();
        $totalCompletedOrders = $orderCollection->where('status', OrderStatus::COMPLETED)->count();
        $totalCancelledOrders = $orderCollection->where('status', OrderStatus::CANCELLED)->count();

        return view('dashboard.index', [
            'total_users' => $totalUsers,
            'total_active_users' => $totalActiveUsers,
            'total_suspended_users' => $totalSuspendedUsers,
            'total_products' => $totalProducts,
            'total_orders' => $totalOrders,
            'total_pending_orders' => $totalPendingOrders,
            'total_completed_orders' => $totalCompletedOrders,
            'total_cancelled_orders' => $totalCancelledOrders,
        ]);
    }
}
