<?php

use App\Http\Controllers\Api\AddressController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\SocialiteController;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::name('v1.')->prefix('v1')->group(function () {

    Route::post('signup', \App\Http\Controllers\RegistrationController::class)
        ->name('signup')
        ->middleware('guest:api');
    Route::get('/verify-email/{user:email}/{code}', App\Http\Controllers\Api\VerifyEmailController::class)
        ->middleware(['throttle:6,1'])
        ->name('verification.verify');
    Route::post('/login', \App\Http\Controllers\Api\AuthenticationController::class)
        ->middleware('guest')
        ->name('login');
    Route::post('/forgot-password', \App\Http\Controllers\Api\ResetPasswordCodeController::class)
        ->middleware('guest')
        ->name('forgot.password');
    Route::post('/reset-password', \App\Http\Controllers\Api\ResetPasswordController::class)
        ->middleware('guest')
        ->name('reset.password');
    Route::post('/email/verification-notification', \App\Http\Controllers\Api\EmailVerificationNotificationCodeController::class)
        ->middleware(['guest:api', 'throttle:6,1'])
        ->name('verification.send');
    Route::post('users/profile-photo', \App\Http\Controllers\Api\ProfilePhotoController::class)
        ->name('users.profile-photo')
        ->middleware('auth:api');
    Route::get('users/profile', \App\Http\Controllers\Api\ProfileController::class)
        ->name('users.profile')
        ->middleware('auth:api');
    Route::post('/users/refresh', \App\Http\Controllers\Api\RefreshTokenController::class)
        ->middleware('auth:api')
        ->name('users.refresh');
    Route::post('/users/logout', \App\Http\Controllers\Api\LogoutController::class)
        ->middleware('auth:api')
        ->name('users.logout');
    Route::delete('users/destroy', \App\Http\Controllers\Api\DestroyAccountController::class)
        ->name('users.destroy')
        ->middleware('auth:api');
    Route::patch('users/profile/password', \App\Http\Controllers\Api\ChangePasswordController::class)
        ->name('profile.password')
        ->middleware('auth:api');
    Route::patch('users/profile', \App\Http\Controllers\Api\UpdateProfileController::class)
        ->name('profile.update')
        ->middleware('auth:api');
    Route::post('users/phone/verification', [\App\Http\Controllers\Api\PhoneVerificationController::class, 'store'])
        ->name('users.store');
    Route::post('users/phone/verify', [\App\Http\Controllers\Api\PhoneVerificationController::class, 'verify'])
        ->name('users.verify');

    Route::get('/social/{driver}/callback', SocialiteController::class)->where('driver', 'apple|google');

    Route::get('products', [\App\Http\Controllers\ProductController::class, 'index'])
        ->name('products.index');
    Route::get('products/{product:slug}', [\App\Http\Controllers\ProductController::class, 'show'])
        ->name('products.show');
    Route::post('products/search-by-image', [\App\Http\Controllers\ProductController::class, 'findByImage']);

    // Cart flows
    Route::get('carts', [\App\Http\Controllers\Api\CartController::class, 'index'])
        ->name('carts.index');
    Route::get('carts/v2', \App\Http\Controllers\Api\CartRecordController::class)
        ->name('carts.indexes');
    Route::post('carts', [\App\Http\Controllers\Api\CartController::class, 'store'])
        ->name('carts.store');
    Route::get('carts/{product:id}', [\App\Http\Controllers\Api\CartController::class, 'show'])
        ->name('carts.show');
    Route::patch('carts/{product:id}', [\App\Http\Controllers\Api\CartController::class, 'update'])
        ->name('carts.update');
    Route::delete('carts/{product:id}', [\App\Http\Controllers\Api\CartController::class, 'destroy'])
        ->name('carts.destroy');
    Route::post('carts/checkout/{cart:key}', \App\Http\Controllers\Api\CheckoutController::class)
        ->name('carts.checkout')
        ->middleware('auth:api');

    Route::middleware(['auth:api'])->group(function () {
        Route::get('orders', [OrderController::class, 'index'])
            ->name('orders.index');

        Route::get('orders/{order:id}', [OrderController::class, 'show'])
            ->name('orders.show');

        Route::post('orders/{order:id}/pay', [OrderController::class, 'pay'])
            ->name('orders.pay');

        Route::apiResource('addresses', AddressController::class)->except(['destroy', 'show']);
    });
});

Route::get('test', function () {
    $assets = Cloudinary::admin()->assets([
        'tags' => true,
        'type' => 'upload',
        'prefix' => 'products',
        'max_results' => 500,
    ]);

    return $assets;

    //    $uniqueCategories = collect($assets['resources'])->map(function ($asset) {
    //        $categoriesArray = explode('/', $asset['public_id']);
    //        if (count($categoriesArray) > 2) {
    //            return $categoriesArray[1];
    //        }
    //
    //        return 'Others';
    //    })->unique()->values();
    //
    //    $categoriesWithSlug = collect($uniqueCategories)->map(function ($category) {
    //        return [
    //            'name' => $category,
    //            'slug' => Str::slug($category),
    //        ];
    //    });
    //
    //    return $categoriesWithSlug;
    //
    //    return $uniqueCategories;
});
