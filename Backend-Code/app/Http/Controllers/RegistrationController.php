<?php

namespace App\Http\Controllers;

use App\Events\ApiRegistered;
use App\Http\Requests\RegistrationRequest;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class RegistrationController extends Controller
{
    /**
     * @OA\Post(
     * path="/signup",
     * operationId="RegisterationController::__invoke",
     * tags={"Authentication"},
     * summary="User Registeration",
     * description="User Registers here",
     *
     *    @OA\RequestBody(
     *         description="Create new user",
     *         required=true,
     *
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             example={
     *                 "firstname": "Ugbanawaji",
     *                 "lastname": "Ugbanawaji",
     *                 "email" : "test@commerce.com",
     *                 "password" : "password",
     *                 "password_confirmation" : "password"
     *             },
     *
     *             @OA\Schema(ref="#/components/schemas/RegistrationRequest")
     *         )
     *     ),
     *
     *     @OA\Response(
     *         response=201,
     *         description="success",
     *
     *         @OA\JsonContent(
     *             type="object",
     *             example={
     *                 "message":"Please verify your email address",
     *                 "status": true,
     *                 "data": {
     *                     "firstname" : "Ugbanawaji",
     *                     "lastname" : "Ekenekiso",
     *                     "email" : "test@verited.com",
     *                     "created_at" : "2022-09-08T12:29:54.000000Z",
     *                     "updated_at" : "2022-09-08T12:29:54.000000Z"
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
     *  Store a newly created resource in storage.
     *
     * @return JsonResponse
     */
    public function __invoke(RegistrationRequest $request)
    {

        $user = User::create($this->filter($request));
        $user->referredBy($request->referrer);
        event(new ApiRegistered($user));
        $user->assignRoles('customer');

        return $this->created(
            new UserResource($user),
            'Please verify your email address'
        );
    }
}
