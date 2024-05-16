<?php

namespace App\Traits;

use App\Models\Invoice;

trait InteractWithInvoice
{
    public function invoices()
    {
        return $this->hasMany(
            Invoice::class,
            'user_id'
        );
    }

    public function latestInvoice()
    {
        return $this->invoices()
            ->orderBy('id', 'DESC')
            ->first();
    }

    public function sendInvoice(?Invoice $invoice = null)
    {
        $invoice ??= $this->latestInvoice();
        $invoice->send();
    }
}
