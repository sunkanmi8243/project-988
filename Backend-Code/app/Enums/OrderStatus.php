<?php

namespace App\Enums;

use App\Traits\EnumOperation;

enum OrderStatus: string
{
    use EnumOperation;

    case PENDING = 'Pending';

    case PAID = 'Paid';

    case SHIPPED = 'Shipped';

    case COMPLETED = 'Completed';

    case CANCELLED = 'Cancelled';
}
