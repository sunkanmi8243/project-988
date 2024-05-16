<?php

namespace App\Enums;

use App\Traits\EnumOperation;

enum PaymentGateway: string
{
    use EnumOperation;
    case STRIPE = 'STRIPE';
    case FLUTTERWAVE = 'FLUTTERWAVE';
    case PAYSTACK = 'PAYSTACK';
    case BANKTRANSFER = 'BANKTRANSFER';
    case WRITEOFF = 'WRITEOFF';
    case WALLET = 'WALLET';
    case INTERNAL_TRANSFER = 'INTERNAL_TRANSFER';

}
