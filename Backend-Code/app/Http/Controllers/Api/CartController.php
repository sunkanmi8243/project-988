<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\CartRequest;
use App\Http\Resources\CartItemCollection;
use App\Http\Resources\CartItemResource;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class CartController extends Controller
{
    /**
     * @OA\Get(
     *
     *     path="/carts",
     *     tags={"Carts"},
     *     summary="The Shopping-Cart Item resource",
     *     description="The Shopping-Cart Item resource",
     *     operationId="Api/CartController::index",
     *
     *     @OA\Parameter(
     *         name="key",
     *         in="query",
     *         description="guest user Identifier key",
     *         required=true,
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
     *             @OA\Items(ref="#/components/schemas/CartItemResource")
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
     * @return CartItemCollection
     */
    public function index(Request $request)
    {
        $items = CartItem::whereIn('cart_id', function ($query) use ($request) {
            $query->select('id')
                ->from('carts')
                ->when(auth('sanctum')->check(), function ($builder) {
                    $builder->where('user_id', auth('sanctum')->id());
                })->when($request->key ?? false, function ($builder) use ($request) {
                    $builder->where('key', $request->key);
                });
        })
            ->with('cart', 'product')
            ->paginate(10);

        return new CartItemCollection($items);
    }

    /**
     * @OA\Post(
     * path="/carts",
     * operationId="Api/CartController::store",
     * tags={"Carts"},
     * summary="The request resource.",
     * description="The request resource.",
     *
     *    @OA\RequestBody(
     *         description="The resource body content",
     *         required=true,
     *
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             example={
     *                 "product": 2,
     *                 "key": "3328uqr984yhoflk39e8yQQQQQQUTYT",
     *             },
     *
     *             @OA\Schema(ref="#/components/schemas/CartRequest")
     *         ),
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *
     *         @OA\JsonContent(
     *
     *             @OA\Schema(ref="#/components/schemas/CartItemResource"),
     *             type="object",
     *             example={
     *                 "message":"Added to cart successfully.",
     *                 "status": true,
     *                 "data": {
     *                     "id" : 1,
     *                     "name" : "lorem ipsum dolum ima ikegwuru",
     *                 }
     *             }
     *         )
     *     ),
     *
     *    @OA\Response(response=400, ref="#/components/responses/400"),
     *    @OA\Response(response=404, ref="#/components/responses/404"),
     *    @OA\Response(response=422, ref="#/components/responses/422"),
     *    @OA\Response(response="default", ref="#/components/responses/500")
     * )
     *
     * Store an applicant newly created resource in storage.
     *
     * @return JsonResponse
     */
    public function store(CartRequest $request)
    {
        $product = Product::findOrFail($request->product);

        return $this->success(
            new CartItemResource(
                $product->addItem($request->key ?? Str::uuid()->toString(),
                    $request->quantity
                )->load('product', 'cart')
            ),
            'Added to cart successfully.'
        );

    }

    /**
     * @OA\Get(
     *     path="/carts/{product}",
     *     tags={"Carts"},
     *     summary="The CartItemResource.",
     *     description="The CartItemResource.",
     *     operationId="Api/CartController::show",
     *
     *     @OA\Parameter(
     *         name="product",
     *         in="path",
     *         description="The Product resource Id",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="integer",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The CartItemResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/CartItemResource")
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
    public function show(CartRequest $request, Product $product)
    {
        return $this->success(
            new CartItemResource(
                $product->addItem($request->key ?? '',
                    $request->quantity
                )->load('product', 'cart')
            ),
            'success'
        );
    }

    /**
     * @OA\Patch(
     *     path="/carts/{product}",
     *     tags={"Carts"},
     *     summary="The CartItemResource.",
     *     description="The CartItemResource.",
     *     operationId="Api/CartController::update",
     *
     *     @OA\Parameter(
     *         name="product",
     *         in="path",
     *         description="The Product resource Id",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="integer",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The CartItemResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/CartItemResource")
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
    public function update(CartRequest $request, Product $product)
    {
        return $this->success(
            new CartItemResource(
                $product->addItem($request->key ?? '',
                    $request->quantity
                )->load('product', 'cart')
            ),
            'success'
        );
    }

    /**
     * @OA\Delete(
     *     path="/carts/{product}",
     *     tags={"Carts"},
     *     summary="The CartItemResource.",
     *     description="The CartItemResource.",
     *     operationId="Api/CartController::destroy",
     *
     *     @OA\Parameter(
     *         name="product",
     *         in="path",
     *         description="The Product resource Id",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="integer",
     *         )
     *     ),
     *
     *    @OA\RequestBody(
     *         description="The resource body content",
     *         required=true,
     *
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             example={
     *                 "key": "3328uqr984yhoflk39e8yQQQQQQUTYT",
     *             },
     *
     *             @OA\Schema(ref="#/components/schemas/CartRequest")
     *         ),
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The CartItemResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/CartItemResource")
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
    public function destroy(CartRequest $request, Product $product)
    {

        $product->removeItem($request->key);

        return $this->delete(
            [],
            'success'
        );

    }
}
