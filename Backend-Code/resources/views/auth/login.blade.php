<x-guest-layout>
    <div class="d-flex h-100 align-items-center p-5">
        <div class="w-100">
            <div class="d-flex justify-content-center mt-3">
                <div class="text-center logo">
                    <img alt="logo" class="img-fluid" src="{{ asset('assets/images/logo/logo.png') }}" style="height: 70px;">
                </div>
            </div>
            <div class="mt-4">
                <form method="POST" action="{{ route('login') }}" class="w-100">
                    @csrf
                    <div class="form-group mb-3">
                        <label for="email">{{ __('Email') }}</label>
                        <input id="email" type="email" class="form-control" name="email" value="{{ old('email') }}" required autofocus autocomplete="username" />
                        <x-input-error :messages="$errors->get('email')" class="mt-2" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label d-flex justify-content-between" for="password">
                            <span>{{ __('Password') }}</span>

                            <a href="" class="text-primary font">Forget Password?</a>
                        </label>
                        <div class="form-group input-affix flex-column">
                            <label class="d-none">Password</label>
                            <input id="password" type="password" class="form-control" name="password" required autocomplete="current-password" />
                            <i class="suffix-icon feather cursor-pointer text-dark icon-eye" ng-reflect-ng-class="icon-eye"></i>
                            <x-input-error :messages="$errors->get('password')" class="mt-2" />

                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Log In</button>
                </form>
            </div>
        </div>
    </div>
</x-guest-layout>

