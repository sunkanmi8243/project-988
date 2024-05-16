<?php

namespace App\Http\Controllers\Api;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\CheckoutRequest;
use App\Http\Resources\OrderResource;
use App\Models\Cart;
use App\Models\Order;
use App\Notifications\OrderPaid;
use App\Notifications\OrderPlaced;
use Illuminate\Http\JsonResponse;

class CheckoutController extends Controller
{
    /**
     * @OA\Post(
     *     path="/carts/checkout/{key}",
     *     tags={"Carts"},
     *     security={ * {"sanctum": {} } * },
     *     summary="The OrderResource.",
     *     description="The OrderResource.",
     *     operationId="Api/CheckoutController::__invoke",
     *
     *     @OA\Parameter(
     *         name="key",
     *         in="path",
     *         description="The Cart resource key",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\RequestBody(
     *           required=true,
     *           description="The order checkout shipping details",
     *
     *           @OA\MediaType(
     *              mediaType="application/json",
     *              example={
     *                   "address_id": 1,
     *              }
     *     ),
     *
     *              @OA\Schema(
     *                 ref="#/components/schemas/CheckoutRequest"
     *              ),
     *          ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The OrderResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/OrderResource")
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
    public function __invoke(CheckoutRequest $request, Cart $cart)
    {
        $user = $request->user('api');
        $user->takeCart($cart->key);
        $cartTotal = $cart->total(2, '.', '');

        $order = Order::create(array_merge([
            'user_id' => $user->id,
            'status' => OrderStatus::PENDING,
            'subtotal' => $cart->subtotal(2, '.', ''),
            'tax' => $cart->tax(2, '.', ''),
            'total' => $cartTotal,
        ], $request->validated()));

        $order->addItem($cart);

        $user->notify(new OrderPlaced($order));

        $cart->items()->delete();
        $cart->delete();

        if ($user->wallet_balance < $cartTotal) {
            return $this->error(new OrderResource($order), 'You do not have enough balance to complete this order', 400);
        }

        $user->update([
            'wallet_balance' => $user->wallet_balance - $cartTotal,
        ]);

        $order->update(['status' => OrderStatus::PAID]);

        $user->notify(new OrderPaid($order));

        return $this->success(
            new OrderResource($order->refresh()->load('orderItems.product')),
            'success'
        );
    }
}
