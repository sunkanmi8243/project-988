<?php

namespace Tests\Supports;

trait SupportFormat
{
    private function format($value, $decimals = null, $decimalPoint = null, $thousandSeperator = null): string
    {
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
