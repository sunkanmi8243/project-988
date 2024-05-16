<?php

namespace App\Http\Controllers\Api;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Http\Resources\OrderCollection;
use App\Http\Resources\OrderResource;
use App\Models\Order;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    /**
     * @OA\Get(
     *     path="/orders",
     *     tags={"Orders"},
     *     security={ * {"sanctum": {} } * },
     *     summary="The resource collection",
     *     description="The resource collection",
     *     operationId="Api/OrderController::index",
     *
     *     @OA\Response(
     *         response=200,
     *         description="The resource collection",
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
     */
    public function index(Request $request): OrderCollection
    {
        $user = auth('api')->user();
        $orders = Order::where('user_id', $user->id)
            ->with('user', 'orderItems.product')
            ->latest()
            ->paginate(10);

        return new OrderCollection($orders);
    }

    /**
     * @OA\Get(
     *     path="/orders/{orderId}",
     *     tags={"Orders"},
     *     security={ * {"sanctum": {} } * },
     *     summary="The Orders paginated resource.",
     *     description="The order resource collection",
     *     operationId="Api/OrderController::show",
     *
     *     @OA\Parameter(
     *         name="orderId",
     *         in="path",
     *         description="The resource Id",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The paginated order resource.",
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
     */
    public function show(Request $request, int $order): JsonResponse
    {
        return $this->success(
            new OrderResource(
                Order::where('user_id', auth('api')->id())
                    ->with('orderItems.product', 'address')
                    ->findOrFail($order)
            ),
            'success'
        );
    }

    /**
     * @OA\Post(
     *     path="/orders/{orderId}/pay",
     *     tags={"Orders"},
     *     security={ * {"sanctum": {} } * },
     *     summary="Pay for a Order",
     *     description="Pay for a Order",
     *     operationId="Api/OrderController::pay",
     *
     *     @OA\Parameter(
     *         name="orderId",
     *         in="path",
     *         description="The resource Id",
     *         required=true,
     *
     *         @OA\Schema(
     *             type="string",
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The paginated Order resource.",
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
     * Pay for a transaction
     *
     * @param  int  $transaction
     * @return JsonResponse
     */
    public function pay(Request $request, int $order)
    {
        $user = auth('api')->user();
        $order = Order::where('user_id', $user->id)
            ->findOrFail($order);

        if ($order->status !== OrderStatus::PENDING) {
            return $this->error([], 'You can only pay for orders that are still pending', 400);
        }

        if ($user->wallet_balance < $order->total) {
            return $this->error([], 'You do not have enough balance to pay for this order', 400);
        }

        $user->update([
            'wallet_balance' => $user->wallet_balance - $order->total,
        ]);

        $order->update(['status' => OrderStatus::PAID]);

        return $this->success(
            new OrderResource($order->fresh()->load('orderItems.product', 'address')),
            'success'
        );
    }
}
