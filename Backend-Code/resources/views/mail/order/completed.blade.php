<x-mail::message>
# Hello {{ $order->user->longname }},

We are pleased to inform you that your order has been completed. Here are the details of your order:

## Order Information
- <b>ID:</b> #{{ $order->id }}
- <b>Order Status:</b> {{ $order->status }}

## Order Summary

<x-mail::table>
| Product              | Quantity   | Price        | Total Amount      |
|:---------------------|:----------:|:------------:|------------------:|
@foreach($order->orderItems as $orderItem)
    | {{ $orderItem->product->name }}   | {{ $orderItem->quantity }} | ${{ \Illuminate\Support\Number::format($orderItem->product->price, 2) }} | ${{  \Illuminate\Support\Number::format($orderItem->product->price * $orderItem->quantity, 2) }} |
@endforeach
| ------ |
|        |             |Subtotal        | ${{  \Illuminate\Support\Number::format($order->subtotal ?? 0, 2) }} |
|        |             |Discount        | ${{  \Illuminate\Support\Number::format($order->discount ?? 0, 2) }} |
|        |             |VAT (7.5%)      | ${{  \Illuminate\Support\Number::format($order->tax ?? 0, 2) }}      |
|        |             |Grand Total     | ${{  \Illuminate\Support\Number::format($order->total ?? 0, 2) }}    |
</x-mail::table>


## Shipping Details

{{ $order->address->name }}<br/>
{{ $order->address->fullAddress }}<br/>
{{ $order->address->email }}<br/>
{{ $order->address->phone }}<br/>



If you have any questions or need further assistance, please feel free to our support team.

Thanks for shopping with us!<br/>
{{ config('app.name') }}
</x-mail::message>
