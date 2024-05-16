<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    /**
     * @OA\Get(
     * path="/users/profile",
     * operationId="ProfileController::__invoke",
     * tags={"Profiles"},
     * summary="The authenticated user resources",
     * security={ * {"sanctum": {} } * },
     * description="The authenticated user resources.",
     *
     *     @OA\Response(
     *         response=200,
     *         description="The authenticated user resources.",
     *
     *         @OA\JsonContent(
     *             type="object",
     *             example={
     *                 "message":"success",
     *                 "status": true,
     *                 "data": {
     *                     "firstname" : "Ugbanawaji",
     *                     "middlename" : "Leonard",
     *                     "lastname" : "Ekenekiso",
     *                     "image": "http://localhost:8000/storage/images/DU8Y739YQWHDLKuhluwqehdluiwked.png",
     *                     "id" : 24,
     *                 }
     *             }
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
     * Get the authenticated user resource in storage.
     *
     * @return JsonResponse
     */
    public function __invoke(Request $request)
    {
        return $this->success(
            new UserResource($request->user('api')->load('roles')),
            'success'
        );
    }
}
