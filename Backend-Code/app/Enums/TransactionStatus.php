<?php

namespace App\Enums;

use App\Traits\EnumOperation;

enum TransactionStatus: string
{
    use EnumOperation;
    case DRAFT = 'Draft';
    case WAIVED = 'Waived';
    case ISSUED = 'Issued';
    case OUTSTANDING = 'Outstanding';
    case PAID = 'Paid';
    case VOID = 'Void';
    case FAILED = 'Failed';
    case PENDING = 'Pending';
    case AWAITINGPAYMENT = 'Awaiting Payment';
    case AWAITINGFULFILMENT = 'Awaiting Fulfillment';
    case AWAITINGSHIPMENT = 'Awaiting Shipment';
    case AWAITINGPICKUP = 'Awaiting Pickup';
    case COMPLETED = 'Completed';
    case SHIPPED = 'Shipped';
    case CANCELLED = 'Cancelled';
    case DECLINED = 'Declined';
    case REFUNDED = 'Refunded';
    case DISPUTED = 'Disputed';
    case MANUALVERIFICATIONREQUIRED = 'Manual Verification Required';
    case PARTIALLYREFUNDED = 'Partially Refunded';
}
