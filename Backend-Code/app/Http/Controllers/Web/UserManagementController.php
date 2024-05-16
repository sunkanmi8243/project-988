<?php

namespace App\Http\Controllers\Web;

use App\Enums\UserStatus;
use App\Http\Controllers\Controller;
use App\Http\Requests\GeneralRequest;
use App\Models\User;
use Illuminate\Http\Request;

class UserManagementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(GeneralRequest $request)
    {
        $users = (new User())
            ->paginate($request->quantity);

        return view('users.index', [
            'users' => $users,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('users.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

        return redirect()->route('products.index')
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
    public function edit(User $user)
    {
        $statuses = UserStatus::values();

        return view('users.update', [
            'user' => $user,
            'statuses' => $statuses,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {

        $userData = $request->validate([
            'status' => ['required', 'string'],
            'wallet_balance' => ['required', 'numeric', 'gte:0'],
        ]);

        $user->update($userData);

        return redirect()->route('users.index')
            ->with('success', 'updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $user->delete();

        return redirect()->route('users.index')
            ->with('success', 'Deleted successfully');
    }
}
