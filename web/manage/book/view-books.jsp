<%-- 
    Document   : book
    Created on : Sep 22, 2022, 10:48:25 PM
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
        <title>Book Management</title>
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
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Book Management</li>
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
                                <h4 class="card-title">Books List</h4>
                                <div class="left-filter">
                                    <a class="btn btn-purple" href="./AddBook">Add Book</a>
                                </div>
                                <div class="table-responsive">
                                    <table class="table user-table " id="tablepro">
                                        <thead>
                                            <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Author</th>
                                                <th style="width: 150px;">Image</th>
                                                <th>Category</th>
                                                <th>Price</th>
                                                <th>Sale</th>
                                                <th>Update</th>
                                                <th>TOC</th>
                                                <th>Enable</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="book" items="${books}">
                                                <tr>
                                                    <td >${book.getId()}</td>
                                                    <td>${book.getTitle()}</td>
                                                    <td>${book.getAuthor()}</td>
                                                    <td style="width: 150px;"><img  src="${book.getImage()}" width="100px"></td>
                                                    <td>
                                                        <c:forEach var="category" items="${categories}">
                                                            ${category.getId()==book.getCategoryid()?category.getName():null}
                                                        </c:forEach>
                                                    </td>
                                                    <td>$${book.getPrice()}</td>
                                                    <td><input class="checkbox-inline" type="checkbox" ${book.issale()?"checked":""} disabled></td>
                                                    <td><a class="btn btn-primary" href="./UpdateBook?id=${book.getId()}"><i class="fa fa-pen-square" aria-hidden="true"></i></a></td>
                                                    <td><a class="btn btn-secondary" href="./Book/TOC?id=${book.getId()}"><i class="fa fa-angle-right" aria-hidden="true"></i></a></td>
                                                    <td>
                                                        <form action="Disable" method="get">
                                                            <label class="switch">
                                                                <a href="./ChangeStatus?id=${book.getId()}&xpage=${xpage}">
                                                                    <input id="myButton" type="checkbox" name="status" ${book.status() ? "checked": null}>
                                                                    <span class="slider"></span>
                                                                </a>
                                                            </label>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="Book?xpage=${xpage-1}" class="page-link" style="${xpage<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage}" var="item">
                                            <li class="page-item ${item==xpage?"active":""}">
                                                <a href="Book?xpage=${item}" 
                                                   class="page-link " style="${(xpage-1>item || xpage+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="BookManager?xpage=${xpage+1}" class="page-link" style="${xpage+2>numPage?"display:none":""}">
                                                <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                            </a>
                                        </li>
                                    </ul>
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

