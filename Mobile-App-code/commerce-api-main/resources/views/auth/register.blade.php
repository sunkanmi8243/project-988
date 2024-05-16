<x-guest-layout>
    <form method="POST" action="{{ route('register') }}">
        @csrf

        <!-- Name -->
        <div>
            <x-input-label for="name" :value="__('Name')" />
            <x-text-input id="name" class="block mt-1 w-full" type="text" name="name" :value="old('name')" required autofocus autocomplete="name" />
            <x-input-error :messages="$errors->get('name')" class="mt-2" />
        </div>

        <!-- Email Address -->
        <div class="mt-4">
            <x-input-label for="email" :value="__('Email')" />
            <x-text-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autocomplete="username" />
            <x-input-error :messages="$errors->get('email')" class="mt-2" />
        </div>

        <!-- Password -->
        <div class="mt-4">
            <x-input-label for="password" :value="__('Password')" />

            <x-text-input id="password" class="block mt-1 w-full"
                            type="password"
                            name="password"
                            required autocomplete="new-password" />

            <x-input-error :messages="$errors->get('password')" class="mt-2" />
        </div>

        <!-- Confirm Password -->
        <div class="mt-4">
            <x-input-label for="password_confirmation" :value="__('Confirm Password')" />

            <x-text-input id="password_confirmation" class="block mt-1 w-full"
                            type="password"
                            name="password_confirmation" required autocomplete="new-password" />

            <x-input-error :messages="$errors->get('password_confirmation')" class="mt-2" />
        </div>

        <div class="flex items-center justify-end mt-4">
            <a class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" href="{{ route('login') }}">
                {{ __('Already registered?') }}
            </a>

            <x-primary-button class="ml-4">
                {{ __('Register') }}
            </x-primary-button>
        </div>
    </form>
    <div class="auth-full-height">
        <div class="row m-0">
            <div class="col p-0 auth-full-height" style="background-image: url({{ asset('assets/images/others/bg-4.jpg') }});">
                <div class="d-flex justify-content-between flex-column h-100 px-5 py-3">
                    <div></div>
                    <div class="w-100 text-center">
                        <img class="img-fluid" style="max-height: 430px;" src="{{ asset('assets/images/others/img-1.png') }}" alt="">
                        <h1 class="display-4 mt-5 mb-4">Sign up with {{ config('app.name') }}</h1>
                        <p class="lead mx-auto text-muted" style="max-width: 630px;">Climb leg rub face on everything give attitude nap all day for under the bed. Chase mice attack feet but rub face on everything hopped up.</p>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span>©  {{  now()->format('Y').' '.config('app.name') }}</span>
                        <div>
                            <a href="" class="text-link ms-3">Legal</a>
                            <a href="" class="text-link">Privacy</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 p-0 auth-full-height bg-white" style="max-width: 450px;">
                <div class="d-flex h-100 align-items-center p-5">
                    <div class="w-100">
                        <div class="d-flex justify-content-center mt-3">
                            <div class="text-center logo">
                                <img alt="logo" class="img-fluid" src="{{ asset('assets/images/logo/logo.png') }}" style="height: 70px;">
                            </div>
                        </div>
                        <div class="text-center mt-4">
                            <h3>Create Account</h3>
                        </div>
                        <div class="mt-4">
                            <form>
                                <div class="form-group mb-3">
                                    <label class="form-label">Username</label>
                                    <input
                                        type="text"
                                        class="form-control no-validation-icon no-success-validation"
                                        name="username"
                                    >
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label">Email</label>
                                    <input
                                        type="email"
                                        class="form-control no-validation-icon no-success-validation"
                                        name="email"
                                    >
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label">Password</label>
                                    <input
                                        type="password"
                                        class="form-control no-validation-icon no-success-validation"
                                        name="password"
                                    >
                                </div>
                                <div class="form-group mb-3">
                                    <label class="form-label">Confirm Password</label>
                                    <input
                                        type="password"
                                        class="form-control no-validation-icon no-success-validation"
                                        name="confirmPassword"
                                    >
                                </div>
                                <button class="btn btn-primary d-block w-100" type="submit">Sign Up</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-guest-layout>
