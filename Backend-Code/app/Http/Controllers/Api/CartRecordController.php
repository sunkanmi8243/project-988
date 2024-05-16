<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\GeneralRequest;
use App\Http\Resources\CartItemCollection;
use App\Http\Resources\CartResource;
use App\Repositories\CartRepository;

class CartRecordController extends Controller
{
    /**
     * @OA\get(
     *     path="/carts/v2",
     *     tags={"Carts"},
     *     summary="The Shopping-Cart Item resource",
     *     description="The Shopping-Cart Item resource",
     *     operationId="Api/CartRecordController::invoke",
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
     *             @OA\Items(ref="#/components/schemas/CartResource")
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
    public function __invoke(GeneralRequest $request, CartRepository $cart)
    {

        return $this->success(
            new CartResource($cart->cartAndItems($request->key ?? '')),
            'success'
        );
    }
}
