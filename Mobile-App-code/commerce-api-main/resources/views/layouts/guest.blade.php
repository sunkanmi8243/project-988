<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Espire - Admin Dashboard Template</title>

        <link rel="shortcut icon" href="{{ asset("assets/images/logo/favicon.ico") }}">

        <link href="{{ asset("assets/css/app.min.css") }}" rel="stylesheet">

    </head>

    <body>
        <div class="auth-full-height">
            <div class="row m-0">
                <div class="col p-0 auth-full-height" style="background-image: url('{{ asset("assets/images/others/bg-1.jpg") }}');">
                    <div class="d-flex justify-content-between flex-column h-100 px-5 py-3">
                        <div></div>
                        <div class="w-100 ">
                            <h1 class="display-4 text-white mb-4">Commerce Application</h1>
                            <p class="text-white lead" style="max-width: 630px;">Climb leg rub face on everything give attitude nap all day for under the bed. Chase mice attack feet but rub face on everything hopped up.</p>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-white">© 2021 School Project</span>
                            <div>
                                <a href="" class="text-white text-link me-3">Legal</a>
                                <a href="" class="text-white text-link">Privacy</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 p-0 auth-full-height bg-white" style="max-width: 450px;">
                   {{ $slot }}
                </div>
            </div>
        </div>

        <script src="{{ asset("assets/js/vendors.min.js") }}"></script>
        <script src="{{ asset("assets/js/app.min.js") }}"></script>
    </body>
</html>
