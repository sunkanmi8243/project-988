<?php

namespace App\Providers;

use App\Interfaces\PaymentGatewayInterface;
use App\Services\StripeGateway;
use Illuminate\Support\ServiceProvider;
use Tests\Supports\StripePaymentStub;

class PaymentGateWayServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        $this->app->singleton(PaymentGatewayInterface::class, function ($app) {
            if ($app->environment('testing')) {
                return new StripePaymentStub();
            }

            return new StripeGateway();
        });
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        //
    }
}
