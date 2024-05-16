<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Update Product</h4>
                <div class="breadcrumb">
                    <span class="me-1 text-gray"><i class="feather icon-home"></i></span>
                    <div class="breadcrumb-item"><a href="{{ route('dashboard') }}">Dashboard </a></div>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <x-flash/>
                    <x-helper.message/>
                    <div class="mt-4">
                        <div class="row">
                            <form method="POST" action="{{ route('products.update', $product) }}" enctype="multipart/form-data">
                                @csrf
                                {{ method_field('PUT') }}
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input name="name" value="{{ old('name', $product->name) }}" type="text" class="form-control" id="name" placeholder="Enter product name">
                                        @error('name')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="mb-3">
                                        <label for="slug" class="form-label">Slug</label>
                                        <input name="slug" value="{{ old('slug', $product->slug) }}" type="text" class="form-control" id="slug" placeholder="Enter product slug">
                                        @error('slug')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Price</label>
                                                <input name="price" type="text" class="form-control" id="price" value="{{ old('price', $product->price) }}" placeholder="Enter product price">
                                                @error('price')
                                                <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="status" class="form-label">Status</label>
                                                <select name="status" id="status" class="form-select">
                                                    @forelse($statuses as $key => $status)
                                                        <option {{ old('status', $product->status->value) == $status ? "selected" : "" }} value="{{ $status }}">{{ $status }}</option>
                                                    @empty
                                                        <option >No record</option>
                                                    @endforelse
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="category_id" class="form-label">Category</label>
                                                <select name="category_id" id="category_id" class="form-select">
                                                    @forelse($categories as $category)
                                                        <option {{ old('category_id', $product->category_id) == $category->id ? "selected" : "" }} value="{{ $category->id }}">{{ $category->name }}</option>
                                                    @empty
                                                        <option >No record</option>
                                                    @endforelse


                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea name="description" rows="10" type="text" class="form-control" id="description" placeholder="Enter product description">{{ old('description', $product->description) }}</textarea>
                                        @error('description')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="mb-3">
                                        <div class="upload upload-text w-100">
                                            <div>
                                                <label for="image" class="btn btn-secondary w-100">Product Image</label>
                                            </div>
                                            <input id="image" type="file" name="image" class="upload-input" accept="image/png, image/jpeg">
                                        </div>
                                    </div>
                                    <div class="mb-3 pt-3">
                                        <button type="submit" class="btn btn-primary float-end">Update</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <x-helper.footer/>
    </div>
</x-app-layout>
