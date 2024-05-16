<?php

namespace App\Http\Controllers;

class WebBaseController extends Controller
{
    public function __construct()
    {
        view()->share('*', [
            'user' => auth('web')->user(),
        ]);
    }
}
