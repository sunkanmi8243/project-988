<x-app-layout>
    <div class="content">
        <div class="main">
            <div class="page-header">
                <h4 class="page-title">Update Category - {{ $category->name }}</h4>
            </div>
            <div class="card">
                <div class="card-body">
                    <x-flash/>
                    <x-helper.message/>
                    <div class="mt-4">
                        <div class="row">
                            <form method="POST" action="{{ route('categories.update', $category) }}">
                                @csrf
                                {{ method_field('PUT') }}
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input name="name" value="{{ old('name', $category->name) }}" type="text" class="form-control" id="name" placeholder="Enter category name">
                                        @error('name')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="mb-3">
                                        <label for="slug" class="form-label">Slug</label>
                                        <input name="slug" value="{{ old('slug', $category->slug) }}" type="text" class="form-control" id="slug" placeholder="Enter category slug">
                                        @error('slug')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea name="description" rows="10" type="text" class="form-control" id="description" placeholder="Enter category description">{{ old('description', $category->description) }}</textarea>
                                        @error('description')
                                        <div class="invalid-feedback">{{ $message }}</div>
                                        @enderror
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
