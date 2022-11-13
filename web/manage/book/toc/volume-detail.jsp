<%-- 
    Document   : volume-detail
    Created on : Sep 30, 2022, 1:49:35 PM
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
        <title>Table of Contents</title>
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">
        <style>
            #contextMenu {
                position: absolute;
                display: none;
            }
        </style>
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
                                        <li class="breadcrumb-item active" aria-current="page"> Table of Contents</li>                                        
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <jsp:include page="/manage/book/toc/toc.jsp"/>
                        <div class="col-lg-8 col-xlg-9 col-md-7">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title mt-2"> 
                                        ${book.title} - Volume ${vol.no}
                                    </h5>
                                    <form action="./${service}Volume" method="post">
                                        <input type="hidden" name="id" value="${requestScope.vol.id}">
                                        <input type="hidden" name="bookId" value="${requestScope.book.id}">
                                        <div class="row mb-3">
                                            <label for="title" class="col-sm-2 col-form-label">Title <span style="color:red">*</span></label>
                                            <div class="col-sm-10">
                                                <input name="volumeTitle" type="text" class="form-control" id="title" required value="${requestScope.vol.title}">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="summary" class="col-sm-2 col-form-label">Summary</label>
                                            <div class="col-sm-10">
                                                <textarea style="white-space: pre-line" class="form-control" name="summary" rows="5" placeholder="Summary of this collection of stories. If you are diligent, you may add :v 
In most cases it is not necessary and can be left blank" aria-label="With textarea">${(requestScope.vol.summary==null)? null: requestScope.vol.summary}</textarea>
                                            </div>
                                        </div>
                                        <div class="col-auto" ${book.author.userId!=0? "hidden":""}>
                                            <button type="submit" name="service" class="btn btn-primary">${service} Volume</button>
                                        </div>
                                        <div class="col-md-4">
                                            <h6 class="text-center">
                                                <c:if test="${message !=null}">
                                                    ${message}
                                                </c:if></h6>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div id="contextMenu" class="dropdown clearfix">
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;margin-bottom:5px;">
                                <li>    <a tabindex="-1" href="#">Action 1</a>  </li>
                                <li>    <a tabindex="-1" href="#">Action 2</a>  </li>
                            </ul>
                        </div>
                    </div>
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
            $(function () {

                var $contextMenu = $("#contextMenu");

                $("body").on("contextmenu", "div h4", function (e) {
                    $contextMenu.css({
                        display: "block",
                        position: "fixed",
                        left: e.pageX,
                        top: e.pageY
                    });
                    return false;
                });

                $('html').click(function () {
                    $contextMenu.hide();
                });

                $("#contextMenu li a").click(function (e) {
                    var f = $(this);
                    debugger;
                });

            });
        </script>
    </body>

</html>                