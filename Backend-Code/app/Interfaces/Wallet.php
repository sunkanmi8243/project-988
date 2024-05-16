<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

interface Wallet
{
    public function deposit(int|string $amount, ?array $meta = null, bool $confirmed = true): Transaction;

    public function withdraw(int|string $amount, ?array $meta = null, bool $confirmed = true): Transaction;

    public function forceWithdraw(int|string $amount, ?array $meta = null, bool $confirmed = true): Transaction;

    public function transfer(self $wallet, int|string $amount, ?array $meta = null);

    public function safeTransfer(
        self $wallet,
        int|string $amount,
        ?array $meta = null
    );

    public function forceTransfer(
        self $wallet,
        int|string $amount,
        ?array $meta = null
    );

    public function canWithdraw(int|string $amount, bool $allowZero = false): bool;

    public function getBalanceAttribute(): string;

    public function getBalanceIntAttribute(): int;

    public function walletTransactions(): HasMany;

    public function transactions(): MorphMany;

    public function transfers(): HasMany;
}
