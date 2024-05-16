<?php

namespace App\Providers;

use App\Interfaces\TransactionInterface;
use App\Services\Flutterwave;
use App\Services\Paystack;
use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class TransactionServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap services.
     */
    public function boot(Request $request): void
    {
        $this->app->singleton(
            TransactionInterface::class, // the logger interface
            function ($app) use ($request) {
                $provider = $request->provider == 'flutterwave' ? Flutterwave::class : Paystack::class;

                return $app->make($provider);
            }
        );
    }
}
