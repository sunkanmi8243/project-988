<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Order Details - #{{ $order->id }}</h4>
            </div>
            <div class="card">

                <div class="card-body">
                    <x-flash/>
                    <div class="mb-4 d-md-flex align-items-center justify-content-between">
                        <div>
                        </div>
                    </div>
                    <div>
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <h5 class="fw-bold mb-0">Order ID</h5>
                                        <span>#{{ $order->id }}</span>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-6 mb-3">
                                        <span>Status</span>
                                        <div class="mt-1 text-dark fw-bold">{{ $order->status }}</div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <span>Created At</span>
                                        <div class="mt-1 text-dark fw-bold">{{ $order->created_at->toFormattedDateString() }}</div>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-6 mb-3">
                                        <span>User Details:</span>
                                        <h5 class="fw-bold mt-2">{{ $order->user->longname }}</h5>
                                        <p><span>{{ $order->user->email }} </span><br><span>{{ $order->user->phone }}</span></p>

                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <span>Shipping Address</span>
                                        <h5 class="fw-bold mt-2">{{ $order->address->name }}</h5>
                                        <address>
                                            <p>
                                                <span>{{ $order->address->full_address }} </span><br>
                                                <span>{{ $order->address->email }} </span><br>
                                                <span>{{ $order->address->phone }}</span>
                                            </p>
                                        </address>
                                    </div>
                                </div>
                                <div class="mt-5">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>Product</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($order->orderItems as $items)
                                                <tr>
                                                    <td>{{ $loop->index + 1 }}</td>
                                                    <td>{{ $items->product->name }}</td>
                                                    <td>{{ $items->quantity }}</td>
                                                    <td>${{ \Illuminate\Support\Number::format($items->product->price, 2) }}</td>
                                                    <td>${{ \Illuminate\Support\Number::format($items->total, 2) }}</td>
                                                </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                                <div class="d-flex justify-content-end mt-5">
                                    <div class="text-end">
                                        <div class="border-bottom">
                                            <p class="mb-2"><span>Subtotal: </span><span>${{ \Illuminate\Support\Number::format($order->subtotal, 2) }}</span></p>
                                            <p class="mb-2">Tax: ${{ \Illuminate\Support\Number::format($order->tax, 2) }}</p>
                                            <p>Discount: ${{ \Illuminate\Support\Number::format($order->discount, 2) }}</p>

                                        </div>
                                        <h5 class="fw-bold mt-3"><span class="ms-1">Grand Total: </span><span>${{ \Illuminate\Support\Number::format($order->total, 2) }}</span></h5>
                                    </div>
                                </div>
                                <div class="border-top my-3"></div>

                                <div class="d-flex justify-content-end mt-5">
                                    @if($order->status === \App\Enums\OrderStatus::PAID)
                                        <form action="{{ route('orders.mark-as-shipped', $order->id) }}" method="post">
                                            @csrf
                                            @method('POST')
                                            <button class="btn btn-primary" type="submit">Mark as Shipped</button>
                                        </form>
                                    @endif

                                    @if($order->status === \App\Enums\OrderStatus::SHIPPED)
                                        <form action="{{ route('orders.mark-as-completed', $order->id) }}" method="post">
                                            @csrf
                                            @method('POST')
                                            <button class="btn btn-success ms-3" type="submit">Mark as Completed</button>
                                        </form>
                                    @endif

                                    @if(in_array($order->status, [\App\Enums\OrderStatus::PENDING, \App\Enums\OrderStatus::PAID]))
                                        <form action="{{ route('orders.mark-as-cancelled', $order->id) }}" method="post">
                                            @csrf
                                            @method('POST')
                                            <button class="btn btn-danger ms-3" type="submit">Mark as Cancelled</button>
                                        </form>
                                    @endif
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
