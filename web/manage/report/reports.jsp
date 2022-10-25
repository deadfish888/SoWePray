<%-- 
    Document   : reports
    Created on : Oct 24, 2022, 10:09:28 AM
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
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Authors Management</title>
        <link href="/Bookie/manage/html/css/style.min.css" rel="stylesheet">
        <link href="/Bookie/manage/html/css/dropdown.css" rel="stylesheet">
    </head>

    <body>
        <!-- Preloader - style you can find in spinners.css -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
             data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- ============================================================== -->
            <!-- Topbar header - style you can find in pages.scss -->
            <jsp:include page="/manage/base/header.jsp"/>
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <jsp:include page="/manage/base/sidebar.jsp"/>

            <!-- Page wrapper  -->
            <div class="page-wrapper">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="page-breadcrumb">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-8 align-self-center">
                            <h3 class="page-title mb-0 p-0">Reports Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Reports Management</li>
                                    </ol>
                                </nav>
                            </div>
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
                    <!-- ============================================================== -->
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">Reports</div>
                            </div>
                            <div class="card-body">

                                <div class="card-sub">	

                                    <div class="form-outline">
                                        <form action="./Report" method="Post">
                                            <input type="search" id="form1" class="form-control" placeholder="Search . . . ." aria-label="Search" style="width: 200px"
                                                   name="txt" type="text" value="${txt}" >
                                        </form>

                                    </div>
                                </div>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;">
                                            <th class="border-top-0"><i class="fa-solid fa-list-ol"></i></th>
                                            <th class="border-top-0" style="padding-left: 100px">Reporter</th>
                                            <th class="border-top-0">Type</th>
                                            <th class="border-top-0">Violations</th>
                                            <th class="border-top-0">Date</th>
                                            <th class="border-top-0">Solved</th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="s" items="${listR}">
                                        <form action="./Author" method="Post">
                                            <tr>
                                                <td>${s.id}</a></td>
                                                <td style="padding-left: 100px">
                                                    <a href="#" style="text-decoration: none">${s.userR.name} - ID: ${s.userId}</a>
                                                </td>
                                                <td>  
                                                    ${s.reportTypeName}
                                                </td>
                                                <td>
                                                    <c:forEach var="ss" items="${s.violates}">
                                                        <span class="badge rounded-pill bg-secondary" style="font-size: 80%;font-weight: 400;display: block;">${ss.title}</span>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    ${s.sent}
                                                </td>
                                                <td>
                                                    <span class="fa ${s.isStatus()? "fa-check-square-o":"fa-times-circle"}"></span>
                                                    <c:if test="${s.status}">
                                                        ${s.received}
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </form>

                                        <!-- Show detail modal -->
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="LoadAuthor?xpage1=${xpage1-1}" class="page-link" style="${xpage1<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage1}" var="item">
                                            <li class="page-item ${item==xpage1?"active":""}">
                                                <a href="LoadAuthor?xpage1=${item}"  

                                                   class="page-link " style="${(xpage1-1>item || xpage1+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="LoadAuthor?xpage1=${xpage1+1}" class="page-link" style="${xpage1+2>numPage1?"display:none":""}">
                                                <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="left-filter">
                                    <a class="btn btn-purple" href="./AddBook">Add Author</a>
                                </div>
                            </div>
                        </div>
                        
                    </div>








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

        <script>
            function load(param) {
                $.ajax({
                    url: "/Bookie/Admin/LoadUser",
                    type: "post", //send it through get method
                    data: {
                        type: param
                    },
                    success: function (data) {
                        var row = document.getElementById("contentList");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
            function searchByName(param) {
                var txtSearch = param.value;
                $.ajax({
                    url: "/Bookie/LoadUser",
                    type: "get", //send it through get method
                    data: {
                        txt: txtSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("contentList");
                        row.innerHTML = data;
                    },
                    error: function (xhr) {
                        //Do Something to handle error
                    }
                });
            }
        </script>
        <script src="https://kit.fontawesome.com/a65741f09b.js" crossorigin="anonymous"></script>
        <script src="/Bookie/manage/assets/plugins/jquery/dist/jquery.min.js"></script>

        <!-- Bootstrap tether Core JavaScript -->
        <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

        <script src="/Bookie/manage/html/js/app-style-switcher.js"></script>

        <!--Wave Effects -->
        <script src="/Bookie/manage/html/js/waves.js"></script>

        <!--Menu sidebar -->
        <script src="/Bookie/manage/html/js/sidebarmenu.js"></script>

        <!--Custom JavaScript -->
        <script src="/Bookie/manage/html/js/custom.js"></script>
        <script src="/Bookie/manage/html/js/dropdown.js"></script>
    </body>

</html>
