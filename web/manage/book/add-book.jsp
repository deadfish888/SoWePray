<%-- 
    Document   : add-book
    Created on : Sep 26, 2022, 2:10:35 PM
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
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book Management</title>
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">

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
                                        <li class="breadcrumb-item"><a href="/Bookie/Admin/Book">Book Management</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">${service} Book</li>
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
                                <h4 class="card-title">${service} Book</h4>
                                <div class="panel-body table-responsive">
                                    <div class="sliderList">
                                        <form action="./${service}Book" method="post">
                                            <div class="form-group">
                                                <label class="control-label" style="display: inline-block; margin-right: 20px;">ID</label>
                                                <input class="form-control" style="width: auto;display: inline-block;" type="text"  name="id" readonly value="${(book.getId()!=null)?book.getId(): newId}">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleSelect1" class="control-label">Title</label>
                                                <input class="form-control" type="text" name="title" required value="${book.getTitle()}">
                                            </div>
                                            <div class="form-group">
                                                <label for="exampleSelect1" class="control-label">Author</label>
                                                <input class="form-control" type="text" name="author" required value="${book.getAuthor()}">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label class="control-label">Category</label>
                                                <select class="form-select" name="categoryId">
                                                    <c:forEach var="cate" items="${cates}">
                                                        <option value="${cate.getId()}" ${cate.getId()==book.getCategoryid()?"selected":""}>${cate.getName()}</option>
                                                    </c:forEach>
                                                    <option value="0" ${book.getCategoryid()==null?"selected":""}>Uncategorized</option>
                                                </select>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <label class="control-label ">Price</label>
                                                $<input class="form-control" type="text" name="price" pattern="[+-]?([0-9]*[.])?[0-9]+" required value="${book.getPrice()}">

                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Sale</label>
                                                <input type="checkbox" name="issale" value="true" ${book.issale()?"checked":""}>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label">Summary</label>
                                                <textarea class="form-control" name="description" style="height: 95px;">${book.getDescription()}</textarea>
                                            </div>
                                            <div class="form-group">
                                                <label class="control-label" >Image (Enter Link)</label>
                                                <input class="form-control" type="text" name="image" required value="${book.getImage()}">
                                                <!--                                                <input class="form-control" id="img" onchange="changeimg()" name="image" type="file" -->
                                                <input name="proimage" id="image" value="${book.getImage()}" type="hidden" >
                                                <img  src="${book.getImage()}" id="demoimg${book.getId()}" style="margin-top: 5px;" height="100">
                                            </div>
                                            <div class="col-md-10">
                                                <div class="left-filter"> 
                                                    <input class="btn ${service=="Add"?"btn-primary":"btn-outline-danger"}" name="in" type="submit" value="${service}">
                                                </div>
                                                <c:if test="${message !=null}">
                                                    ${message}
                                                </c:if>
                                            </div>
                                        </form>
                                    </div>
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
    <script>
        var element = document.getElementById("book-management");
        element.classList.add("selected");
        element = document.getElementById("book-management-a");
        element.classList.add("active");
    </script>
</body>

</html>