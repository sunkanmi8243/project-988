<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('name')->nullable();
            $table->decimal('subtotal', 64, 0)->nullable();
            $table->decimal('total', 64, 0)->nullable();
            $table->decimal('tax', 64, 0)->nullable();
            $table->integer('discount')->default(0);
            $table->string('status')->default(\App\Enums\OrderStatus::PENDING->value);
            $table->string('comment')->nullable();
            $table->foreignId('address_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->timestamps();
            $table->softDeletes();

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
