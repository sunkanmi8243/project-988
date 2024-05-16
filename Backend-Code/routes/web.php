<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Web\CategoryController;
use App\Http\Controllers\Web\DashboardController;
use App\Http\Controllers\Web\OrderController;
use App\Http\Controllers\Web\ProductController;
use App\Http\Controllers\Web\UserManagementController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::prefix('dashboard')->middleware(['auth', 'verified'])->group(function () {
    Route::get('/', [DashboardController::class, 'index'])->name('dashboard');

    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::resource('products', ProductController::class);
    Route::resource('categories', CategoryController::class);
    Route::resource('users', UserManagementController::class);

    Route::resource('orders', OrderController::class)->only(['index', 'show']);
    Route::post('orders/{order}/mark-as-shipped', [OrderController::class, 'markAsShipped'])->name('orders.mark-as-shipped');
    Route::post('orders/{order}/mark-as-completed', [OrderController::class, 'markAsCompleted'])->name('orders.mark-as-completed');
    Route::post('orders/{order}/mark-as-cancelled', [OrderController::class, 'markAsCancelled'])->name('orders.mark-as-cancelled');

});

require __DIR__.'/auth.php';
