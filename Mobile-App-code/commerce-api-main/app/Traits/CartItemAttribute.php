<?php

namespace App\Traits;

trait CartItemAttribute
{
    public function getPriceTaxAttribute(): int|float
    {
        return $this->product->price + $this->taxRate;
    }

    public function getTotalAttribute(): int|float
    {
        return $this->quantity * $this->priceTax;
    }

    public function getSubTotalAttribute(): int|float
    {
        return $this->quantity * $this->product->price;
    }

    public function getPriceAttribute(): int|float
    {
        return $this->product->price;
    }

    public function getTaxRateAttribute(): int|float
    {
        return $this->product->price * ($this->tax / 100);
    }
}
