<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAddressRequest;
use App\Http\Requests\UpdateAddressRequest;
use App\Http\Resources\AddressResource;
use App\Models\Address;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
use OpenApi\Annotations as OA;

class AddressController extends Controller
{
    /**
     * @OA\Get(
     *     path="/addresses",
     *     tags={"Addresses"},
     *     security={ * {"sanctum": {} } * },
     *     summary="Get all addresses",
     *     operationId="Api/AddressController::index",
     *
     *     @OA\Response(
     *         response=200,
     *         description="The resource collection",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/AddressResource")
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
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function index(Request $request)
    {
        $addresses = Address::where('user_id', $request->user('api')->id)->get();

        return AddressResource::collection($addresses);
    }

    /**
     * @OA\Post(
     *     path="/addresses",
     *     tags={"Addresses"},
     *     security={ * {"sanctum": {} } * },
     *     summary="Create an address",
     *     operationId="Api/AddressController::store",
     *
     *     @OA\RequestBody(
     *           required=true,
     *           description="The address details",
     *
     *           @OA\MediaType(
     *              mediaType="application/json",
     *              example={
     *                   "name": "John Doe",
     *                   "email": "john@example.com",
     *                   "phone": "123-456-7890",
     *                   "street": "123 Main St",
     *                   "city": "Springfield",
     *                   "state": "IL",
     *                   "country": "US",
     *              }
     *          ),
     *
     *         @OA\Schema(
     *               ref="#/components/schemas/StoreAddressRequest"
     *             ),
     *          ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The AddressResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/AddressResource")
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
     * @return \App\Http\Resources\AddressResource
     */
    public function store(StoreAddressRequest $request)
    {
        $address = Address::create([
            ...$request->validated(),
            'user_id' => $request->user('api')->id,
        ]);

        return new AddressResource($address);
    }

    /**
     * @OA\Patch(
     *     path="/addresses/:addressId",
     *     tags={"Addresses"},
     *     security={ * {"sanctum": {} } * },
     *     summary="Update an address",
     *     operationId="Api/AddressController::update",
     *
     *     @OA\Parameter(
     *          name="addressId",
     *          in="path",
     *          description="The resource Id",
     *          required=true,
     *
     *          @OA\Schema(
     *              type="string",
     *          )
     *      ),
     *
     *     @OA\RequestBody(
     *           required=true,
     *           description="The address details",
     *
     *           @OA\MediaType(
     *              mediaType="application/json",
     *              example={
     *                   "name": "John Doe",
     *                   "email": "john@example.com",
     *                   "phone": "123-456-7890",
     *                   "street": "123 Main St",
     *                   "city": "Springfield",
     *                   "state": "IL",
     *                   "country": "US",
     *              }
     *          ),
     *
     *         @OA\Schema(
     *               ref="#/components/schemas/StoreAddressRequest"
     *             ),
     *          ),
     *
     *     @OA\Response(
     *         response=200,
     *         description="The AddressResource.",
     *
     *         @OA\JsonContent(
     *             type="array",
     *
     *             @OA\Items(ref="#/components/schemas/AddressResource")
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
     * Update the specified resource.
     *
     * @return \App\Http\Resources\AddressResource
     */
    public function update(UpdateAddressRequest $request, Address $address)
    {
        Gate::allowIf($request->user('api')->addresses->contains($address));

        $address->update($request->validated());

        return new AddressResource($address->refresh());
    }
}
