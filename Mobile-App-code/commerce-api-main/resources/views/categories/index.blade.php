<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Manage Categories</h4>
            </div>
            <div class="card">

                <div class="card-body">
                    <x-flash/>
                    <div class="mb-4 d-md-flex align-items-center justify-content-between">
                        <div>
                        </div>
                        <a href="{{ route('categories.create') }}" class="btn btn-primary">New Category</a>
                    </div>
                    <div>
                        <table class="table table-hover user-list-table">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Created At</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($categories as $category)
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="ms-2">
                                                <div class="text-dark fw-bold">{{ $category->name }}</div>
                                                <div class="text-muted">{{ $category->slug }}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span>{{ $category->description }}</span>
                                    </td>
                                    <td>
                                        <span>{{ $category->created_at }}</span>
                                    </td>
                                    <td class="text-end">
                                        <div class="dropdown">
                                            <a href="#" class="px-2" data-bs-toggle="dropdown">
                                                <i class="feather icon-more-vertical"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-end">
                                                <li>
                                                    <a href="{{ route('categories.edit', $category) }}" class="dropdown-item">
                                                        <div class="d-flex align-items-center">
                                                            <i class="feather icon-edit"></i>
                                                            <span class="ms-2">Edit</span>
                                                        </div>
                                                    </a>
                                                </li>
                                                <li>
                                                    <form method="POST" action="{{ route('categories.destroy', $category) }}">
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
                        {{ $categories->links() }}
                    </div>
                </div>
            </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
