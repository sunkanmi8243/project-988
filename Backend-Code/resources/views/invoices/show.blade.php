<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Invoice</title>

    <style>
        .invoice-box {
            max-width: 800px;
            margin: auto;
            padding: 30px;
            border: 1px solid #eee;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            font-size: 16px;
            line-height: 24px;
            font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
            color: #555;
        }
        @media print {
            .invoice-box {
                max-width: unset;
                box-shadow: none;
                border: 0px;
            }
        }
        .invoice-box table {
            width: 100%;
            line-height: inherit;
            text-align: left;
        }

        .invoice-box table td {
            padding: 5px;
            vertical-align: top;
        }

        .invoice-box table tr td:nth-child(2) {
            text-align: right;
        }

        .invoice-box table tr.top table td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.top table td.title {
            font-size: 45px;
            line-height: 45px;
            color: #333;
        }

        .invoice-box table tr.information table td {
            padding-bottom: 40px;
        }

        .invoice-box table tr.heading td {
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }

        .invoice-box table tr.details td {
            padding-bottom: 20px;
        }

        .invoice-box table tr.item td {
            border-bottom: 1px solid #eee;
        }

        .invoice-box table tr.item.last td {
            border-bottom: none;
        }

        .invoice-box table tr.total td:nth-child(2) {
            border-top: 2px solid #eee;
            font-weight: bold;
        }

        @media only screen and (max-width: 600px) {
            .invoice-box table tr.top table td {
                width: 100%;
                display: block;
                text-align: center;
            }

            .invoice-box table tr.information table td {
                width: 100%;
                display: block;
                text-align: center;
            }
        }

        /** RTL **/
        .invoice-box.rtl {
            direction: rtl;
            font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        }

        .invoice-box.rtl table {
            text-align: right;
        }

        .invoice-box.rtl table tr td:nth-child(2) {
            text-align: left;
        }
        .free{
            text-decoration-style: double;
        }
    </style>
</head>

<body>
<div class="invoice-box">
    <table cellpadding="0" cellspacing="0">
        <tr class="top">
            <td colspan="2">
                <table>
                    <tr>
                        <td class="title">
                            <img
                                src="{{ asset('harde/images/logos/logo-bs.png') }}"
                                style="width: 100%; max-width: 300px"
                            />
                        </td>

                        <td>
                            Invoice #: {{ $invoice->id }}<br/>
                            Created: {{ $invoice->created_at->format('d-m-Y') }}<br/>
                            Status: {{ $invoice->status->value }}<br/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr class="information">
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                            {{config('app.name')}}, Inc.<br/>
                            Test address,
                            <br/>
                            Ikeja, Lagos
                        </td>

                        <td>
                            {{ $invoice->user->fullname }}
                            <br/>
                           {{ $invoice->order->address }}<br/>
                            {{ $invoice->user->email }}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr class="heading">
            <td>Description</td>
            <td>Price</td>
        </tr>
        @foreach($invoice->order->orderItems as $item)
            <tr class="item">
                <td>{{ $item->product->name }}</td>

                <td>{{ $invoice->currency->name }} {{ $item->sub_total }}</td>
            </tr>
        @endforeach
        <tr class="total">
            <td></td>
            <td>Tax: {{ $invoice->currency->name }} {{ $invoice->order->tax ?? '--' }}</td>
        </tr>
        <tr class="total">
            <td></td>
            <td>Sub total: {{ $invoice->currency->name }} {{ $invoice->order->sub_total ?? '--' }}</td>
        </tr>
        <tr class="total">
            <td></td>
            <td>Total: <span class="{{ $invoice->status->value }}">
                    {{ $invoice->currency->name }} {{ $invoice->order->total }}
                </span>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
