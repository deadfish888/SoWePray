<%-- 
    Document   : chapter-detail
    Created on : Oct 1, 2022, 4:14:50 PM
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
        <script src="https://cdn.tiny.cloud/1/izyaj8jmwovw4l5rpdwzaikjwkm00f6sg4wd6v8cffj4h7y3/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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
                                        ${requestScope.vol.title} - Chapter ${requestScope.chap.no}
                                    </h5>
                                    <form action="./${service}Chapter" method="post">
                                        <input type="hidden" name="id" value="${requestScope.chap.id}">
                                        <input type="hidden" name="bookId" value="${requestScope.book.id}">
                                        <input type="hidden" name="volumeId" value="${requestScope.vol.id}">
                                        <div class="row mb-3">
                                            <label for="title" class="col-sm-2 col-form-label">Title  <span style="color:red">*</span></label>
                                            <div class="col-sm-10">
                                                <input name="title" type="text" class="form-control" id="title" required value="${requestScope.chap.title}">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="status" class="col-sm-2 col-form-label">Status  <span style="color:red">*</span></label>
                                            <div class="col-sm-10">
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="status" id="status1" value="finished" ${requestScope.chap.status? "checked" : null}>
                                                    <label class="form-check-label" for="status1">Finished</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="status" id="status2" value="unfinished" ${(!requestScope.chap.status)? "checked" : null}>
                                                    <label class="form-check-label" for="status2">Unfinished</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <label for="content" class="form-label">Content<span style="color:red">*</span></label>
                                            <div class="col-12">
                                                <textarea class="form-control" style="white-space: pre-line" id="content" name="content" rows="20" aria-label="With textarea">${requestScope.chap.content}</textarea>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" name="service" class="btn btn-primary">${service} Chapter</button>
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
            tinymce.init({
      selector: 'textarea',
      plugins: 'advlist autolink lists link image charmap print preview hr anchor pagebreak',
      toolbar: 'undo redo | blocks | bold italic underline strikethrough | link image media table mergetags | align lineheight | checklist numlist bullist indent outdent | emoticons charmap | removeformat',
      tinycomments_mode: 'embedded',
      tinycomments_author: 'Author name',
      mergetags_list: [
        { value: 'First.Name', title: 'First Name' },
        { value: 'Email', title: 'Email' },
      ]
    });
        </script>
    </body>

</html>                