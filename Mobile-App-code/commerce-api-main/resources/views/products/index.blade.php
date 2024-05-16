<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Manage Products</h4>
            </div>
            <div class="card">

                <div class="card-body">
                    <x-flash/>
                    <div class="mb-4 d-md-flex align-items-center justify-content-between">
                        <div>
                        </div>
                        <a href="{{ route('products.create') }}" class="btn btn-primary">New Product</a>
                    </div>
                    <div>
                        <table class="table table-hover user-list-table">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($products as $product)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar avatar-circle avatar-image" style="width: 38px; height: 38px;">
                                                <img src="{{ $product->image->url }}" alt="">
                                            </div>
                                            <div class="ms-2">
                                                <div class="text-dark fw-bold"><a href="{{ $product->path(true, 'products', 'slug') }}">{{ $product->name }}</a></div>
                                                <div class="text-muted">{{ $product->category->name }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span>{{ $product->description }}</span>
                                    </td>
                                    <td>
                                        <span>${{ \Illuminate\Support\Number::format($product->price, 2) }}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center text-success">
                                            <span class="badge-dot me-2 bg-success"></span>
                                            <span class="text-capitalize">{{ $product->status->value }}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <span>{{ $product->created_at }}</span>
                                    </td>
                                    <td class="text-end">
                                        <div class="dropdown">
                                            <a href="#" class="px-2" data-bs-toggle="dropdown">
                                                <i class="feather icon-more-vertical"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li>
                                                    <a href="{{ $product->path(true, 'products', 'slug') }}" class="dropdown-item">
                                                        <div class="d-flex align-items-center">
                                                            <i class="feather icon-user-plus"></i>
                                                            <span class="ms-2">View</span>
                                                        </div>
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="{{ route('products.edit', $product) }}" class="dropdown-item">
                                                        <div class="d-flex align-items-center">
                                                            <i class="feather icon-edit"></i>
                                                            <span class="ms-2">Edit</span>
                                                        </div>
                                                    </a>
                                                </li>
                                                <li>
                                                    <form method="POST" action="{{ route('products.destroy', $product) }}">
                                                        {{ csrf_field() }}
                                                        {{ method_field('DELETE') }}

                                                        <button class="dropdown-item">
                                                            <div class="d-flex align-items-center">
                                                                <i class="feather icon-trash-2"></i>
                                                                <span class="ms-2">Delete</span>
                                                            </div>
                                                        </button>
                                                    </form>

                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>No record</tr>
                            @endforelse

                            </tbody>
                        </table>
                        {{ $products->links() }}
                    </div>
                </div>
            </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
