<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Manage Orders</h4>
            </div>
            <div class="card">

                <div class="card-body">
                    <x-flash/>
                    <div class="mb-4 d-md-flex align-items-center justify-content-between">
                        <div>
                        </div>

                    </div>
                    <div>
                        <table class="table table-hover user-list-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Owner</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                    <th>Created At</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($orders as $order)

                                    <tr>
                                        <td>
                                            <span>{{ $order->id }}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar avatar-circle avatar-image"
                                                     style="width: 38px; height: 38px;">
                                                    <img src="{{ $order->user->image->url }}" alt="">
                                                </div>
                                                <div class="ms-2">
                                                    <div
                                                        class="text-dark fw-bold">{{ $order->user->longname }}</div>
                                                    <div class="text-muted">Email: {{ $order->user->email }}</div>

                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span>${{ \Illuminate\Support\Number::format($order->total, 2) }}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center text-success">
                                                <span class="badge-dot me-2 bg-success"></span>
                                                <span class="text-capitalize">{{ $order->status->value }}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span>{{ $order->created_at->toFormattedDateString() }}</span>
                                        </td>
                                        <td class="text-end">
                                            <div class="dropdown">
                                                <a href="#" class="px-2" data-bs-toggle="dropdown">
                                                    <i class="feather icon-more-vertical"></i>
                                                </a>
                                                <ul class="dropdown-menu dropdown-menu-end">
                                                    <li><a href="{{ route('orders.show', $order->id) }}"
                                                           class="dropdown-item">View Order</a></li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>No record</tr>
                                @endforelse

                            </tbody>
                        </table>
                        {{ $orders->links() }}
                    </div>
                </div>
            </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
