<header class="topbar" data-navbarbg="skin6">
    <nav class="navbar top-navbar navbar-expand-md navbar-dark">
        <div class="navbar-header" data-logobg="skin6">
            <!-- ============================================================== -->
            <!-- Logo -->
            <!-- ============================================================== -->
            <a class="navbar-brand ms-4" href="/Bookie/Home">
                <!-- Logo icon -->
                <b class="logo-icon">
                    <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                    <!-- Dark Logo icon -->
                    <span class="fa fa-book" alt="homepage" class="dark-logo"></span>

                </b>
                <!--End Logo icon -->
                <!-- Logo text -->
                <span class="logo-text" alt="homepage">Bookie</span>
            </a>
            <!-- ============================================================== -->
            <!-- End Logo -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <a class="nav-toggler waves-effect waves-light text-white d-block d-md-none"
               href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
        </div>
        <!-- ============================================================== -->
        <!-- End Logo -->
        <!-- ============================================================== -->
        <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin5">
            <ul class="navbar-nav d-lg-none d-md-block ">
                <li class="nav-item">
                    <a class="nav-toggler nav-link waves-effect waves-light text-white "
                       href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
                </li>
            </ul>
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav me-auto mt-md-0 ">
                <!-- ============================================================== -->
                <!-- Search -->
                <!-- ============================================================== -->

                <li class="nav-item search-box">
                    <a class="nav-link text-muted" href="javascript:void(0)"><i class="ti-search"></i></a>
                    <form class="app-search" style="display: none;">
                        <input type="text" class="form-control" placeholder="Search &amp; enter"> <a
                            class="srh-btn"><i class="ti-close"></i></a>
                    </form>
                </li>
            </ul>

            <!-- ============================================================== -->
            <!-- Right side toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav">
                <!-- ============================================================== -->
                <!-- User profile and search -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark" href="#"
                       id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="/Bookie/manage/assets/images/users/profile.png" alt="user" class="profile-pic me-2">${sessionScope.admin.getName()}
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown"></ul>
                </li>
            </ul>
        </div>
    </nav>
</header>