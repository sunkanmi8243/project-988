<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Dashboard</h4>
            </div>
            <div class="card">
                <div class="card-body">
                    <x-flash/>
                    <x-helper.message/>
                    <div class="mt-4">
                            <div class="row">
                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_users }}</h5>
                                        <span class="text-muted">Total Users</span>
                                    </div>
                                </div>

                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_active_users }}</h5>
                                        <span class="text-muted">Total Active Users</span>
                                    </div>
                                </div>

                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_suspended_users }}</h5>
                                        <span class="text-muted">Total Suspended Users</span>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_products }}</h5>
                                        <span class="text-muted">Total Products</span>
                                    </div>
                                </div>

                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_orders }}</h5>
                                        <span class="text-muted">Total Orders</span>
                                    </div>
                                </div>

                                <div class="col-6 col-md-4">
                                    <div class="text-center py-3 border-end">
                                        <h5>{{ $total_pending_orders }}</h5>
                                        <span class="text-muted">Total Pending Orders</span>
                                    </div>
                                </div>

                            </div>

                    <div class="row">
                        <div class="col-6 col-md-4">
                            <div class="text-center py-3 border-end">
                                <h5>{{ $total_completed_orders }}</h5>
                                <span class="text-muted">Total Completed Orders</span>
                            </div>
                        </div>

                        <div class="col-6 col-md-4">
                            <div class="text-center py-3 border-end">
                                <h5>{{ $total_cancelled_orders }}</h5>
                                <span class="text-muted">Total Cancelled Orders</span>
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
