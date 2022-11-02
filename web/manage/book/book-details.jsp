<%-- 
    Document   : book-details
    Created on : Oct 31, 2022, 10:56:58 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Model.*"%>
<%@page import="context.*"%>
<%@page import="java.util.ArrayList"%>
<c:if test="${empty sessionScope.admin}">
    <%         
          response.sendRedirect("/Bookie/Home");
    %>
</c:if>
<!DOCTYPE html>
<html dir="ltr" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book No.${book.id}</title>
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">

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
            <!-- Topbar header - style you can find in pages.scss -->
            <jsp:include page="/manage/base/header.jsp"/>
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <jsp:include page="/manage/base/sidebar.jsp"/>
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
                            <h3 class="page-title mb-0 p-0">Book Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Admin/Dashboard">Home</a></li>
                                        <li class="breadcrumb-item"><a href="/Bookie/Admin/Book">Book Management</a></li>
                                        <li class="breadcrumb-item" aria-current="page">Book No.${book.id}</li>
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
                    <!-- Column -->
                    <div class="row">
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
                                            </div>
                    <div class="col-lg-8 col-xlg-9 col-md-7">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Books List</h4>
                                <div class="left-filter">
                                    <a class="btn btn-purple" href="./AddBook">Add Book</a>
                                </div>
                                <div class="table-responsive">
                                    
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                </div>
                <!-- ============================================================== -->
            </div>
            <!-- End Container fluid  -->
            <!-- footer -->
            <footer class="footer">                                 
                <span class="fa fa-github"></span>
                <a href="https://github.com/nekon0/SoWePray">Our Project</a> 
            </footer>
            <!-- End footer -->
        </div>
        <!-- End Page wrapper  -->
    </div>
    <!-- End Wrapper -->
    <!-- All Jquery -->
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
