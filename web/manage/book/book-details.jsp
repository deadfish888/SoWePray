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
<!DOCTYPE html>
<html dir="ltr" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book No.${book.id}</title>
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <link href="/Bookie/manage/html/css/dropdown.css" rel="stylesheet">

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
                        <div class="col-6 left-filter">
                            <form action="./ChangeStatus" method="post" style="margin-left: 80%">
                                <input  type="hidden" name="id" value="${book.id}">
                                <a><button class="btn ${book.status()?"btn-danger":"btn-primary"}" id="myButton" name="status" type="submit">
                                        <i class="fa-solid ${book.status()?"fa-ban":"fa-up-long"}"></i>
                                    </button>
                                </a>

                            </form>
                        </div>

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
                        <div class="col-4">
                            <div class="card">
                                <div class="card-body profile-card">
                                    <center class="mt-4"> <img src="${!empty book.image? book.image:"../images/novel-sample.png"}" class="rounded"
                                                               width="150" />
                                        <h4 class="card-title mt-2">
                                            <a target="_blank" href="../BookDetail?id=${book.id}"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                ${book.title}
                                        </h4>
                                        <c:if test="${book.author.userId !=0}">
                                            <h6 class="card-subtitle">Creator: <a target="_blank" href="./Activities?id=${book.author.userId}">${book.author.user.name} - ID: ${book.author.userId}</a></h6>
                                            <h6 class="card-subtitle">${book.price}$/thousand words</h6>
                                            <h6 class="card-subtitle">${book.issale()?"In paid":""}</h6>
                                        </c:if>
                                        <c:if test="${book.author.userId ==0}">
                                            <h6 class="card-subtitle">Author: ${book.author.name}</h6>
                                            <h6 class="card-subtitle">${book.price}$</h6>
                                            <h6 class="card-subtitle">${book.issale()?"In sale":""}</h6>
                                        </c:if>
                                        <h6 class="card-subtitle"><i class="fa fa-star"></i>${book.rating}</h6>
                                    </center>
                                </div>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">Activities</h4>
                                    <table class="table">
                                        <tr>
                                            <td>Number of words:</td>
                                            <td>${words}</td>
                                        </tr>
                                        <tr>
                                            <td>Number of views: </td>
                                            <td>${book.views}</td>
                                        </tr>
                                        <tr>
                                            <td>Number of favorite: </td>
                                            <td>${book.favourite}</td>
                                        </tr>
                                        <tr>
                                            <td>Number of votes:</td>
                                            <td>${votes}</td>
                                        </tr>
                                        <tr>
                                            <td>Number of comments:</td>
                                            <td>${comments}</td>
                                        </tr>
                                        <tr>
                                            <td>Bought:</td>
                                            <td>${users} user(s)</td>
                                        </tr>
                                    </table>



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
<script>
                                                    var element = document.getElementById("book-management");
                                                    element.classList.add("selected");
                                                    element = document.getElementById("book-management-a");
                                                    element.classList.add("active");
                                                    
    </script>
</body>

</html>
