<?php

namespace App\Http\Controllers;

use App\Http\Requests\GeneralRequest;
use App\Http\Resources\ProductCollection;
use App\Http\Resources\ProductResource;
use App\Models\Product;
use App\Services\RoboflowService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * @OA\Get(
     *     path="/products",
     *     tags={"Products"},
     *     summary="The resource collection",
     *     description="The resource collection",
     *     operationId="Api/ProductController::index",
     *
     *     @OA\Parameter(
     *         name="search",
     *         in="query",
     *         description="Search the resource by name or description",
     *         required=false,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\Parameter(
     *         name="category",
     *         in="query",
     *         description="filter down the product categories",
     *         required=false,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The resource collection",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/ProductResource")
     *         )
     *     ),
     *
     *    @OA\Response(response=400, ref="#/components/responses/400"),
     *    @OA\Response(response=403, ref="#/components/responses/403"),
     *    @OA\Response(response=404, ref="#/components/responses/404"),
     *    @OA\Response(response=422, ref="#/components/responses/422"),
     *    @OA\Response(response="default", ref="#/components/responses/500")
     * )
     *
     * Display a listing of the resource.
     *
     * @return ProductCollection
     */
    public function index(GeneralRequest $request)
    {
        $products = (new Product)->searchName($request->search ?? '')
            ->filterByCategory($request->category)
            ->status()
            ->with('category')
            ->paginate(60);

        return new ProductCollection($products);

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    /**
     * @OA\Get(
     *     path="/products/{product}",
     *     tags={"Products"},
     *     summary="The product paginated resource.",
     *     description="The product resource collection",
     *     operationId="Api/ProductController::show",
     *
     *     @OA\Parameter(
     *         name="product",
     *         in="path",
     *         description="The resource slug",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The paginated product resource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/ProductResource")
     *         )
     *     ),
     *
     *    @OA\Response(response=400, ref="#/components/responses/400"),
     *    @OA\Response(response=403, ref="#/components/responses/403"),
     *    @OA\Response(response=404, ref="#/components/responses/404"),
     *    @OA\Response(response=422, ref="#/components/responses/422"),
     *    @OA\Response(response="default", ref="#/components/responses/500")
     * )
     *
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function show(Request $request, $slug)
    {

        $product = Product::where('slug', $slug)
            ->with('category')->firstOrFail();

        return $this->success(
            new ProductResource($product),
            'success'
        );
    }

    /**
     * @OA\Post(
     *     path="/products/search-by-image",
     *     tags={"Products"},
     *     summary="Search a product by image.",
     *     description="Search for a product by uploading an image.",
     *     operationId="Api/ProductController@findByImage",
     *
     *     @OA\RequestBody(
     *         required=true,
     *         description="Product image to search",
     *
     *         @OA\MediaType(
     *             mediaType="multipart/form-data",
     *
     *             @OA\Schema(
     *                 required={"image"},
     *
     *                 @OA\Property(
     *                     property="image",
     *                     type="string",
     *                     format="binary",
     *                     description="Product image file"
     *                 ),
     *             )
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="List of products matching the image.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/ProductResource")
     *         )
     *     ),
     *
     *     @OA\Response(response=400, description="Bad request"),
     *     @OA\Response(response=403, description="Forbidden"),
     *     @OA\Response(response=404, description="Not found"),
     *     @OA\Response(response=422, description="Unprocessable entity"),
     *     @OA\Response(response="default", description="Unexpected error")
     * )
     */
    public function findByImage(Request $request)
    {
        $request->validate(['image' => 'required|image|max:10240']);

        $predictedClasses = app(RoboflowService::class)->analyzeImage($request->file('image'));

        $products = Product::with('category')->byClassifications($predictedClasses)->paginate();

        return new ProductCollection($products);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
