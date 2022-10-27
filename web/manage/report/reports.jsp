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
        <title>Reports</title>
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
                                        <li class="breadcrumb-item active" aria-current="page">Reports</li>
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

                                <div class="col-12">	
                                    <form action="./Report" method="Post">
                                        <div class="row col-12">
                                            <div class="col-3">
                                                <label class="form-control"
                                                       style="border:none;display: inline;">Type</label>
                                                <select class="form-control" name="cid" style="display: inline; width: 100px;">
                                                    <option value="">All</option>
                                                    <c:forEach var="cate" items="${cates}">
                                                        <option value="${cate.getId()}" ${cate.getId()==param['cid']?"selected":""}>${cate.getName()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-3">
                                                <input type="text" name="search" class="form-control" value="${param['search']} "
                                                       style="width: 250px;" placeholder="Search" />
                                            </div>
                                            <div class="col-3">

                                                <select class="form-control input-sm" name="type-search">
                                                        <option value="0" ${param['type-search']==0?'selected':''}>Title</option>
                                                    <option value="1" ${param['type-search']==1?'selected':''}>Author</option>
                                                </select>
                                            </div>
                                            <div class="col-3">
                                                <button class="btn btn-default" name="service" value="search">Go</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                            <th style="width: 40px"><i class="fa-solid fa-list-ol"></i></th>
                                            <th style="width: 200px">Reporter</th>
                                            <th style="width: 100px">Type</th>
                                            <th style="width: 380px">Violations</th>
                                            <th style="width: 217px">Sent Date</th>
                                            <th>Settle Date</th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="s" items="${listR}">
                                        <form action="./Author" method="Post">
                                            <tr>
                                                <td>${s.id}</a></td>
                                                <td>
                                                    <a href="#" style="text-decoration: none">${s.userR.username} - ID: ${s.userId}</a>
                                                </td>
                                                <td>  
                                                    ${s.reportTypeName}
                                                </td>
                                                <td>
                                                    <ul>
                                                        <c:forEach var="ss" items="${s.violates}">
                                                            <li>${ss.title}</li>
                                                            </c:forEach>
                                                    </ul>
                                                </td>
                                                <td>
                                                    ${s.getSent()}
                                                </td>
                                                <td style="text-align: center">
                                                    ${(s.isStatus()?s.getReceived():"Pending")}
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
                                            <a href="./Report?page=${xpage-1}" class="page-link" style="${xpage1<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage}" var="item">
                                            <li class="page-item ${item==xpage?"active":""}">
                                                <a href="./Report?page=${item}"  

                                                   class="page-link " style="${(xpage-1>item || xpage+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="./Report?page=${xpage+1}" class="page-link" style="${xpage+2>numPage?"display:none":""}">
                                                <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                            </a>
                                        </li>
                                    </ul>
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
