<?php

namespace App\Http\Controllers\Web;

use App\Enums\DocumentStatus;
use App\Enums\StorageProvider;
use App\Http\Controllers\Controller;
use App\Http\Requests\GeneralRequest;
use App\Models\Category;
use App\Models\Product;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(GeneralRequest $request)
    {
        $products = (new Product)->searchName($request->search ?? '')
            ->filterByCategory($request->category)
            ->with('category')
            ->paginate($request->quantity);

        return view('products.index', [
            'products' => $products,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $categories = Category::limit(20)->get();
        $statuses = DocumentStatus::values();

        return view('products.create', compact('categories', 'statuses'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $productData = $request->validate([
            'price' => 'required|integer',
            'name' => 'required|string',
            'status' => 'required|string',
            'description' => 'required|string',
            'slug' => 'required|string',
            'category_id' => 'required|integer',
            'image' => 'required|image|max:10240',
        ]);

        $result = Cloudinary::upload($request->file('image')->getRealPath(), [
            'folder' => 'uploads/products',
            'categorization' => config('cloudinary.categorization'),
            'auto_tagging' => '0.8',
        ]);

        $product = Product::create([
            ...$productData,
            'tags' => $result->getTags(),
        ]);

        $product->media()->create([
            'path' => $result->getSecurePath(),
            'disk' => StorageProvider::CLOUDINARY,
            'current' => true,
            'size' => $result->getSize(),
        ]);

        return redirect()->route('products.index')
            ->with('success', 'Save successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product)
    {

        return view('products.update', [
            'product' => $product->load('category'),
            'statuses' => DocumentStatus::values(),
            'categories' => Category::limit(20)->get(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product)
    {
        $productData = $request->validate([
            'price' => 'required|numeric',
            'name' => 'required|string',
            'status' => 'required|string',
            'description' => 'required|string',
            'slug' => 'required|string',
            'category_id' => 'required|integer',
            'image' => 'nullable|image|max:10240',
        ]);

        if ($request->hasFile('image')) {
            // upload the image to cloudinary
            $result = Cloudinary::upload($request->file('image')->getRealPath(), [
                'folder' => 'uploads/products',
                'categorization' => config('cloudinary.categorization'),
                'auto_tagging' => '0.8',
            ]);

            // remove the old image from cloudinary and database
            if ($product->image->url && is_cloudinary_url($product->image->url)) {
                $imagePublicId = get_cloudinary_public_id($product->image->url);

                if ($imagePublicId) {
                    Cloudinary::destroy($imagePublicId);
                }
            }

            $product->media()->delete();

            // store uploaded image in database
            $product->media()->create([
                'path' => $result->getSecurePath(),
                'disk' => StorageProvider::CLOUDINARY,
                'current' => true,
                'size' => $result->getSize(),
            ]);

            $productData['tags'] = $result->getTags();

        }

        $product->update(array_filter($productData));

        return redirect()->route('products.index')
            ->with('success', 'updated successfully');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {

        // delete the product image
        if ($product->image->url && is_cloudinary_url($product->image->url)) {
            $imagePublicId = get_cloudinary_public_id($product->image->url);

            if ($imagePublicId) {
                Cloudinary::destroy($imagePublicId);
            }
        }

        $product->media()->delete();
        $product->delete();

        return redirect()->route('products.index')
            ->with('success', 'Deleted successfully');
    }
}
