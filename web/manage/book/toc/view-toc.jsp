<%-- 
    Document   : view-tocs
    Created on : Sep 28, 2022, 8:36:40 PM
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
                        <c:choose>
                            <c:when test="${requestScope.vol != null}">
                                <div class="col-lg-8 col-xlg-9 col-md-7">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title mt-2"> 
                                                ${vol.book.title} - Volume ${vol.no}
                                            </h5>

                                            <table class="table">
                                                <tr>
                                                    <th scope="row">
                                                        Title
                                                    </th>
                                                    <td>
                                                        ${vol.title}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        Summary
                                                    </th>
                                                    <td rowspan="5" style="white-space: pre-line">${(vol.summary == null) ? "No summary" : vol.summary}</td>
                                                </tr>
                                            </table>
                                            <div class="row mt-3" ${book.author.userId!=0? "hidden":""}>

                                                <div class="col-md-1">
                                                    <form method="get" action="./EditVolume" >
                                                        <input type="hidden" name="id" value="${vol.id}">
                                                        <button type="submit" name="service" value="edit" class="btn btn-primary">Edit</button>
                                                    </form>
                                                </div>
                                                <div class="col-md-1">
                                                    <!-- Button trigger modal -->
                                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                                        Delete
                                                    </button>
                                                </div>
                                                <!-- Modal -->
                                                <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="staticBackdropLabel">ALERT</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <h6>Are you sure to delete the volume - <i>${vol.title}</i> and its chapters: </h6>
                                                                <c:forEach items="${requestScope.chapters}" var="chapter">
                                                                    <c:if test="${chapter.volumeId==vol.id}">
                                                                        <li class="list-group-item">
                                                                            <a target="_blank" href="#"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                                            <a href="./TOC?id=${book.id}&cid=${chapter.id}">   ${chapter.title}</a>
                                                                        </li>
                                                                    </c:if>

                                                                </c:forEach>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <form method="Post" action="./DeleteVolume">
                                                                    <input type="hidden" name="id" value="${vol.id}">
                                                                    <input type="hidden" name="bid" value="${book.id}">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-danger">YES, DELETE</button>
                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <h6 class="text-center">
                                                        <c:if test="${message !=null}">
                                                            ${message}
                                                        </c:if>
                                                    </h6>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${requestScope.chap != null}">
                                <div class="col-lg-8 col-xlg-9 col-md-7">
                                    <div class="card">
                                        <div class="card-body">
                                            <h5 class="card-title mt-2"> 
                                                ${chap.volume.title} - Chapter ${chap.no}
                                            </h5>
                                            <h6>
                                                <c:if test="${message !=null}">
                                                    ${message}
                                                </c:if>
                                            </h6>
                                            <table class="table">
                                                <tr>
                                                    <th scope="row">
                                                        Name
                                                    </th>
                                                    <td>
                                                        ${chap.title}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        Status
                                                    </th>
                                                    <td>
                                                        ${chap.status ? "Done" : "Not Done"}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <p><strong>Content</strong></p>
                                                        <c:forEach items="${requestScope.content}" var="para">
                                                            <p>${para}</p>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class="row mt-3" ${book.author.userId!=0? "hidden":""}>
                                                <div class="col-md-1">
                                                    <form method="get" action="./EditChapter" >
                                                        <input type="hidden" name="id" value="${chap.id}">
                                                        <button type="submit" name="service" value="edit" class="btn btn-primary">Edit</button>
                                                    </form>
                                                </div>
                                                <div class="col-md-1">
                                                    <!-- Button trigger modal -->
                                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                                        Delete
                                                    </button>
                                                </div>
                                                <!-- Modal -->
                                                <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="staticBackdropLabel">ALERT</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                    Delete this chapter?
                                                                </div>
                                                            <div class="modal-footer">
                                                                <form method="Post" action="./DeleteChapter">
                                                                    <input type="hidden" name="id" value="${book.id}">
                                                                    <input type="hidden" name="cid" value="${chap.id}">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-danger">YES, DELETE</button>
                                                                </form>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>


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