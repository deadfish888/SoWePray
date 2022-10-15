<%-- 
    Document   : category-view
    Created on : Oct 16, 2022, 2:35:07 AM
    Author     : fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <link href="../../assets/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <title>Category management</title>
    </head>
    <body><body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader" style="display: none;">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="mini-sidebar" data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- Topbar header - style you can find in pages.scss -->
            
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
                            <h3 class="page-title mb-0 p-0">Category Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Category Management</li>
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
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Categories list</h4>
                                <div class="left-filter">
                                    <a class="btn btn-purple" href="./Add">Add category</a>
                                </div>
                                <div class="table-responsive">
                                    <table class="table user-table " id="tablepro">
                                        <thead>
                                            <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Number of book</th>
                                                <th>Remove</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${categoryList}" var="category">
                                                <tr>
                                                    <td class="text-center">${category.id}</td>
                                                    <td id="${category.name}">${category.name} 
                                                        <button style="border: 0; background: none" onclick="">
                                                            <i id="pen" class='fa fa-pencil-square'></i>
                                                        </button>
                                                    </td>
                                                    <td class="text-center">${categoryMap[category]}</td>
                                                    
                                                    <td class="text-center"><button style="border: 0; background: none"><a href="Remove?categoryId=${category.id}"><i id="garbage-can" class='fa fa-trash-o'></i></a></button></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
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
