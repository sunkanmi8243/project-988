<?php

namespace App\Enums;

use App\Traits\EnumOperation;

enum CartType: string
{
    use EnumOperation;

    case CART = 'CART';
    case WAITLIST = 'WAITLIST';
    case WISHLIST = 'WISHLIST';
}
