<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Http\Requests\GeneralRequest;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(GeneralRequest $request)
    {
        $categories = (new Category())
            ->paginate($request->quantity);

        return view('categories.index', [
            'categories' => $categories,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('categories.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $productData = $request->validate([
            'name' => 'required|string',
            'description' => 'required|string',
            'slug' => 'required|string',
        ]);

        $category = Category::create($productData);
        $category->update([
            'slug' => Str::slug($request->slug),
        ]);

        return redirect()->route('categories.index')
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
    public function edit(Category $category)
    {
        return view('categories.update', [
            'category' => $category,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Category $category)
    {
        $productData = $request->validate([
            'name' => 'required|string',
            'description' => 'required|string',
            'slug' => 'required|string',
        ]);

        $category->update(array_filter($productData));
        $category->update([
            'slug' => Str::slug($request->slug),
        ]);

        return redirect()->route('categories.index')
            ->with('success', 'Updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        if ($category->hasProduct()) {
            return redirect()->route('categories.index')
                ->with('error', "Delete failed. {$category->name} has one or more product(s).");
        }
        $category->delete();

        return redirect()->route('categories.index')
            ->with('success', 'Deleted successfully');

    }
}
