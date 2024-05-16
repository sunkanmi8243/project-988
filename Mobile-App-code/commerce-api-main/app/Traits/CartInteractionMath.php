<?php

namespace App\Traits;

use App\Models\CartItem;

trait CartInteractionMath
{
    /**
     * @return string
     */
    public function total($decimals = null, $decimalPoint = null, $thousandSeperator = null): string|float
    {
        return $this->numberFormat(
            $this->items->reduce(function ($total, CartItem $item) {
                return $total + ($item->quantity * $item->priceTax);
            }, 0),
            $decimals,
            $decimalPoint,
            $thousandSeperator
        );
    }

    /**
     * @return string
     */
    public function subtotal($decimals = null, $decimalPoint = null, $thousandSeperator = null): string|float
    {

        return $this->numberFormat(
            $this->items->reduce(function ($subTotal, CartItem $item) {
                return $subTotal + ($item->quantity * $item->price);
            }, 0),
            $decimals,
            $decimalPoint,
            $thousandSeperator
        );
    }

    /**
     * @return string
     */
    public function tax($decimals = null, $decimalPoint = null, $thousandSeperator = null): float|string
    {

        return $this->numberFormat(
            $this->items->reduce(function ($sub, CartItem $item) {
                return $sub + ($item->quantity * $item->taxRate);
            }, 0),
            $decimals,
            $decimalPoint,
            $thousandSeperator
        );
    }

    private function numberFormat($value, $decimals, $decimalPoint, $thousandSeperator): string
    {
        if (! config('harde.format.format')) {
            return $value;
        }
        if (is_null($decimals)) {
            $decimals = is_null(config('harde.format.decimals')) ? 2 : config('harde.format.decimals');
        }
        if (is_null($decimalPoint)) {
            $decimalPoint = is_null(config('harde.format.decimal_point')) ? '.' : config('harde.format.decimal_point');
        }
        if (is_null($thousandSeperator)) {
            $thousandSeperator = is_null(config('harde.format.thousand_seperator')) ? '' : config('harde.format.thousand_seperator');
        }

        return number_format($value, $decimals, $decimalPoint, $thousandSeperator);
    }
}
