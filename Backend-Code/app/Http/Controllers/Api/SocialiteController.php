<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Laravel\Socialite\Facades\Socialite;

/**
 * Attempts to login the user via socialite.
 *
 * @OA\Get(
 * path="/social/{driver}/callback",
 * operationId="SocialiteController::__invoke",
 * tags={"Authentication"},
 * summary="Logs user into system via socialite",
 * description="Login or create a new user account via social signin/up",
 *
 *    @OA\Parameter(
 *           name="driver",
 *           in="path",
 *           description="The socialite driver to use, available driber include google, apple",
 *           required=true,
 *
 *           @OA\Schema(
 *               type="string",
 *           )
 *       ),
 *
 *     @OA\Parameter(
 *          name="token",
 *          in="query",
 *          description="The user access from socialite provider",
 *          required=true,
 *
 *          @OA\Schema(
 *              type="string",
 *          )
 *      ),
 *
 *     @OA\Response(
 *         response=200,
 *         description="success",
 *
 *         @OA\JsonContent(
 *             type="object",
 *             example={
 *                 "message":"success",
 *                 "status": true,
 *                 "data": {
 *                      "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdmVyaXRlZC50ZXN0L2FwaS92MS9sb2dpbiIsImlhdCI6MTY5NzI3NTMwOSwiZXhwIjoxNjk3Mjc4OTA5LCJuYmYiOjE2OTcyNzUzMDksImp0aSI6IjZBYmN0ZEJUaU9tY1RKemYiLCJzdWIiOiI1MSIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjciLCJkYXRhIjp7ImlkIjo1MSwiZmlyc3RuYW1lIjoiQWx2YSIsIm1pZGRsZW5hbWUiOiJQZmVmZmVyIiwibGFzdG5hbWUiOiJDYXNwZXIiLCJ1c2VybmFtZSI6bnVsbCwiYmlvIjoiTW9sZXN0aWFlIGV4IHBlcmZlcmVuZGlzIHBlcnNwaWNpYXRpcyBoaWMgdW5kZS4iLCJpbnRyb2R1Y3Rpb24iOiJQbGFjZWF0IGN1bHBhIGVhIHJlY3VzYW5kYWUgbWFnbmFtIHNlZCB1dC4iLCJleHBlcmllbmNlIjoiRXhlcmNpdGF0aW9uZW0gZHVjaW11cyBkb2xvciBuaWhpbCBxdWlhIGFzcGVybmF0dXIuIiwiaW1hZ2UiOiIvc3RvcmFnZS9pbWFnZXMvMTE2YzI3MDgtZWE5OC00ODNiLWE5ZDAtNmQ4NWNkZWM0YjJkLTIwMjMtMDgtMTQtMTEtNDEtNTUuanBlZyIsInJvbGUiOiJTdHVkZW50Iiwicm9sZXMiOlt7ImlkIjoyLCJuYW1lIjoic3R1ZGVudCIsImxhYmVsIjoiU3R1ZGVudCJ9LHsiaWQiOjY5LCJuYW1lIjoidXQiLCJsYWJlbCI6IlV0In1dfX0.7gYWPr0VVFpBOyYKPO8qjfvEr09p8nwF8it-hGwM8Xk",
 *                      "token_type": "bearer",
 *                      "expires_in": "3600",
 *                  }
 *             }
 *         )
 *     ),
 *
 *     @OA\Response(response=422, ref="#/components/responses/422"),
 *     @OA\Response(response=400, ref="#/components/responses/400"),
 *     @OA\Response(response=404, ref="#/components/responses/404"),
 *     @OA\Response(response="default", ref="#/components/responses/500")
 * )
 *
 * @throws ValidationException
 * @throws AuthenticationException
 */
class SocialiteController extends Controller
{
    public function __invoke(Request $request, string $driver)
    {
        // validate that there is a valid access token in the request
        $validatedData = validator($request->all(), [
            'token' => ['required', 'string'],
        ])->validate();

        $socialiteUser = Socialite::driver($driver)->stateless()->userFromToken($validatedData['token']);
        [$firstName, $lastName] = explode(' ', $socialiteUser->name);

        $user = User::firstOrCreate([
            'email' => $socialiteUser->email,
        ], [
            'firstname' => $firstName,
            'lastname' => $lastName,
            'password' => bcrypt(fake()->password(10)),
            'username' => Str::uuid()->toString().'-'.time(),
            'email_verified_at' => now(),
        ]);

        return $this->respondWithToken(Auth::guard('api')->login($user));
    }
}
