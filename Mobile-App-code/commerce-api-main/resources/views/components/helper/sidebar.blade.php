<div class="side-nav vertical-menu nav-menu-light scrollable">

    <div class="nav-logo">
        <div class="w-100 logo">
            <img class="img-fluid" src="{{ asset("assets/images/logo/logo.png") }}" style="max-height: 70px;" alt="logo">
        </div>
        <div class="mobile-close">
            <i class="icon-arrow-left feather"></i>
        </div>
    </div>
    <ul class="nav-menu">
        <li @class([
        "nav-menu-item",
        "router-link-active" => request()->routeIs('dashboard')
        ])>
            <a href="{{ route('dashboard') }}">
                <i class="feather icon-home"></i>
                <span class="nav-menu-item-title">Dashboard</span>
            </a>
        </li>

        <li @class([
             "nav-menu-item",
             "router-link-active" => request()->routeIs('products.*')
        ])>
            <a href="{{ route('products.index') }}">
                <i class="feather icon-shopping-bag"></i>
                <span class="nav-menu-item-title">Products</span>
            </a>
        </li>
        <li @class([
            "nav-menu-item",
            "router-link-active" => request()->routeIs('categories.*')
        ])>
            <a href="{{ route('categories.index') }}">
                <i class="feather icon-folder"></i>
                <span class="nav-menu-item-title">Category</span>
            </a>
        </li>
        <li @class([
            "nav-menu-item",
            "router-link-active" => request()->routeIs('users.*')
        ])>
            <a href="{{ route('users.index') }}">
                <i class="feather icon-users"></i>
                <span class="nav-menu-item-title">Users</span>
            </a>
        </li>

        <li @class([
            "nav-menu-item",
            "router-link-active" => request()->routeIs('orders.*')
        ])>
            <a href="{{ route('orders.index') }}">
                <i class="feather icon-shopping-cart"></i>
                <span class="nav-menu-item-title">Orders</span>
            </a>
        </li>
    </ul>
</div>
