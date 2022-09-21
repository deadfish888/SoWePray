<%-- 
    Document   : ADprofile
    Created on : Sep 13, 2022, 10:52:12 AM
    Author     : duypham0705
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Model.*"%>
<%@page import="context.*"%>
<%@page import="java.util.ArrayList"%>

<c:if test="${!empty sessionScope.admin && !empty sessionScope.adminS}">
    <%         
          response.sendRedirect("/Bookie/Home");
    %>
</c:if>
<!DOCTYPE html>
<html dir="ltr" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Admin Profile</title>
        <!-- Favicon icon -->
        <!-- Custom CSS -->
        <!--<link rel="stylesheet" href="html/css/style.min.css">-->
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    </head>

    <body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
             data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- ============================================================== -->
            <!-- Topbar header - style you can find in pages.scss -->
            <!-- ============================================================== -->
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
                                    <img src="/Bookie/manage/assets/images/users/user.png" alt="user" class="profile-pic me-2">${sessionScope.admin.getName()}${sessionScope.adminS.getName()}
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown"></ul>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>
            <!-- ============================================================== -->
            <!-- End Topbar header -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <aside class="left-sidebar" data-sidebarbg="skin6">
                <!-- Sidebar scroll-->
                <div class="scroll-sidebar">
                    <!-- Sidebar navigation-->
                    <nav class="sidebar-nav">
                        <ul id="sidebarnav">
                            <!-- User Profile-->

                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="./Edit" aria-expanded="false">
                                    <i class="mdi me-2 mdi-account-check"></i><span class="hide-menu">Profile</span></a>
                            </li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="index.html" aria-expanded="false"><i class="mdi me-2 mdi-gauge"></i><span
                                        class="hide-menu">Dashboard</span></a></li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="./UserManager" aria-expanded="false"><i class="mdi me-2 mdi-table"></i><span
                                        class="hide-menu">Users Management</span></a></li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="icon-material.html" aria-expanded="false"><i
                                        class="mdi me-2 mdi-emoticon"></i><span class="hide-menu">Icon</span></a></li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="./manage/GGmap.jsp" aria-expanded="false"><i class="mdi me-2 mdi-earth"></i><span
                                        class="hide-menu">Google Map</span></a></li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="pages-blank.html" aria-expanded="false"><i
                                        class="mdi me-2 mdi-book-open-variant"></i><span class="hide-menu">Blank</span></a>
                            </li>
                            <li class="sidebar-item"> <a class="sidebar-link waves-effect waves-dark sidebar-link"
                                                         href="pages-error-404.html" aria-expanded="false"><i
                                        class="mdi me-2 mdi-help-circle"></i><span class="hide-menu">Error 404</span></a>
                            </li>
                            <!--                            <li class="text-center p-20 upgrade-btn">
                                                            <a href="https://www.wrappixel.com/templates/materialpro/"
                                                               class="btn btn-warning text-white mt-4" target="_blank">Upgrade to
                                                                Pro</a>
                                                        </li>-->
                        </ul>

                    </nav>
                    <!-- End Sidebar navigation -->
                </div>
                <!-- End Sidebar scroll-->
                <div class="sidebar-footer">
                    <div class="row">
                        <div class="col-4 link-wrap">
                            <!-- item-->
                            <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Settings"><i
                                    class="ti-settings"></i></a>
                        </div>
                        <div class="col-4 link-wrap">
                            <!-- item-->
                            <a href="" class="link" data-toggle="tooltip" title="" data-original-title="Email"><i
                                    class="mdi mdi-gmail"></i></a>
                        </div>
                        <div class="col-4 link-wrap">
                            <!-- item-->
                            <a href="/Bookie/Logout" class="link" data-toggle="tooltip" title="" data-original-title="Logout"><i
                                    class="mdi mdi-power"></i></a>
                        </div>
                    </div>
                </div>
            </aside>
            <!-- ============================================================== -->
            <!-- End Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Page wrapper  -->
            <!-- ============================================================== -->
            <div class="page-wrapper">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="page-breadcrumb">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-8 align-self-center">
                            <h3 class="page-title mb-0 p-0">Profile</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Profile</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                        <!--                        <div class="col-md-6 col-4 align-self-center">
                                                    <div class="text-end upgrade-btn">
                                                        <a href="https://www.wrappixel.com/templates/materialpro/"
                                                           class="btn btn-danger d-none d-md-inline-block text-white" target="_blank">Upgrade to
                                                            Pro</a>
                                                    </div>
                                                </div>-->
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Container fluid  -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <!-- Row -->
                    <!--                    <div class="row">
                                            <div class="col-lg-4 col-xlg-3 col-md-5">
                                                <div class="card">
                                                    <div class="card-body profile-card">
                                                        <center class="mt-4"> <img src="assets/images/users/5.jpg"rounded-circle"
                                                                                   width="150" />
                                                            <h4 class="card-title mt-2">Hanna Gover</h4>
                                                            <h6 class="card-subtitle">Accoubts Manager Amix corp</h6>
                                                            <div class="row text-center justify-content-center">
                                                                <div class="col-4">
                                                                    <a href="javascript:void(0)" class="link">
                                                                        <i class="icon-people" aria-hidden="true"></i>
                                                                        <span class="value-digit">254</span>
                                                                    </a>
                                                                </div>
                                                                <div class="col-4">
                                                                    <a href="javascript:void(0)" class="link">
                                                                        <i class="icon-picture" aria-hidden="true"></i>
                                                                        <span class="value-digit">54</span>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </center>
                                                    </div>
                                                </div>
                                            </div>-->
                    <!-- Column -->
                    <div class="col-lg-8 col-xlg-9 col-md-7">
                        <div class="card">
                            <div class="card-body">
                                <form action="./Edit" method="Post" class="form-horizontal form-material mx-2" >
                                    <div class="form-group">
                                        <label for="example-email" class="col-md-12"><i class="fa-solid fa-envelope"></i> Email</label>
                                        <div class="col-md-12">
                                            <input type="email" placeholder="${sessionScope.admin.email}${sessionScope.adminS.email}"
                                                   class="form-control ps-0 form-control-line" name="email"
                                                   id="example-email">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0"><i class="fa-solid fa-user"></i>  Username</label>
                                        <div class="col-md-12">
                                            <input type="text" placeholder="${sessionScope.admin.username}${sessionScope.adminS.username}"
                                                   class="form-control ps-0 form-control-line">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0"> <i class="fa-solid fa-lock"></i>   Password</label>         
                                            <span style="position: absolute" onclick="showPass()">
                                                <i id="hide1" class="fa-solid fa-eye" ></i>
                                                <i id="hide2" style="display: none" class="fa-sharp fa-solid fa-eye-slash"></i>
                                            </span>


                                        <div class="col-md-12">
                                            <input type="password" value="${sessionScope.admin.password}${sessionScope.adminS.password}" id="unsignPass"
                                                   class="form-control ps-0 form-control-line" name="password"> 
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0"><i class="fa-solid fa-address-book"></i> Full Name</label>
                                        <div class="col-md-12">
                                            <input type="text" placeholder="${sessionScope.admin.name}${sessionScope.adminS.name}"
                                                   class="form-control ps-0 form-control-line" name="fullname">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0"><i class="fa-solid fa-phone"></i>  Phone</label>
                                        <div class="col-md-12">
                                            <input type="text" placeholder="${sessionScope.admin.phone}${sessionScope.adminS.phone}"
                                                   class="form-control ps-0 form-control-line" name="phone">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12 mb-0"><i class="fa-sharp fa-solid fa-location-pin"></i>  Address</label>
                                        <div class="col-md-12">
                                            <input type="text" placeholder="${sessionScope.admin.address}${sessionScope.adminS.address}"
                                                   class="form-control ps-0 form-control-line" name="address">
                                        </div>
                                    </div>

                                    <br>
                                    <c:if test="${notice!=null }">
                                        <div class="form-group" style="color : red" ">
                                            <i class="fa-solid fa-check"></i>
                                            ${notice}
                                        </div>
                                    </c:if>
                                    <div class="form-group">
                                        <div class="col-sm-12 d-flex">
                                            <button class="btn btn-success mx-auto mx-md-0 text-white" type="submit">Update
                                                Profile</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                <!-- Row -->
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Right sidebar -->
                <!-- ============================================================== -->
                <!-- .right-sidebar -->
                <!-- ============================================================== -->
                <!-- End Right sidebar -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer">                                 
                <span class="fa fa-github"></span>
                <a href="https://github.com/nekon0/SoWePray">Our Project</a> 
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="https://kit.fontawesome.com/a65741f09b.js" crossorigin="anonymous"></script>

    <script src="/Bookie/manage/assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.js"></script>
    <script src="/Bookie/manage/html/js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="/Bookie/manage/html/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="/Bookie/manage/html/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="/Bookie/manage/html/js/custom.js"></script>
</body>

</html>
