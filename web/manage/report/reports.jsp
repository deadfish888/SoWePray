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
                                    <form id="frm" action="./Report" method="get">
                                        <div class="row col-12">
                                            <div class="col-4">
                                                <label class="form-control"
                                                       style="border:none;display: inline;">Type</label>
                                                <select class="form-select" name="type" style="display: inline; width: 150px;" onchange="typeR()">
                                                    <option id="opt1" value="">All</option>
                                                    <option id="opt2" value="book">Book</option>
                                                    <option id="opt3" value="comment">Comment</option>
                                                    <option id="opt4" value="transaction">Transaction</option>
                                                </select>
                                            </div>
                                            <div class="col-2 ms-auto">
                                                <div class="btn-group" role="group" onclick="status()">
                                                    <input type="radio" class="btn-check" name="status" id="btnradio1" autocomplete="off" value="" checked>
                                                    <label class="btn btn-outline-primary" for="btnradio1">Open</label>

                                                    <input type="radio" class="btn-check" name="status" id="btnradio2" autocomplete="off" value="1">
                                                    <label class="btn btn-outline-primary" for="btnradio2">Close</label>

                                                    <input type="radio" class="btn-check" name="status" id="btnradio3" autocomplete="off" value="0">
                                                    <label class="btn btn-outline-primary" for="btnradio3">Reject</label>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px; ">
                                            <th style="width: 40px"><i class="fa-solid fa-list-ol"></i></th>
                                            <th style="width: 250px">Reporter</th>
                                            <th style="width: 150px">Type</th>
                                            <th style="width: 370px; padding-left: 50px">Violations</th>
                                            <th style="width: 250px">Sent Date</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="s" items="${listR}">
                                        <form action="./Author" method="Post">
                                            <tr>
                                                <td>${s.id}</a></td>
                                                <td>
                                                    <a href="./Activities?id=${s.userId}" style="text-decoration: none">${s.userR.username} - ID: ${s.userId}</a>
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
                                                <td><a class="btn btn-secondary" href="./ReportDetail?id=${s.id}"><i class="fa fa-angle-right" aria-hidden="true"></i></a></td>
                                            </tr>
                                        </form>

                                        <!-- Show detail modal -->
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div id="sp" class="pagination-arena " style="margin-left: 45%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="./Report?page=${page-1}" class="page-link" style="${page<3?"display:none":""}" data="${page-1}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage}" var="item">
                                            <li class="page-item ${item==page?"active":""}">
                                                <a href="./Report?page=${item}"  
                                                   data="${item}"
                                                   class="page-link " style="${(page-1>item || page+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="./Report?page=${page+1}" class="page-link" style="${page+2>numPage?"display:none":""}" data="${page+1}">
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

            function status() {
                document.getElementById("frm").submit();
            }
            function typeR() {
                document.getElementById("frm").submit();
            }
            const url_string = window.location.href;
            const url = new URL(url_string);
            var status1 = url.searchParams.get("status");
            var type = url.searchParams.get("type");
            if (status1 == "1") {
                document.getElementById("btnradio2").checked = true;
            }
            if (status1 == "0") {
                document.getElementById("btnradio3").checked = true;
            }
            if (type == "book") {
                document.getElementById("opt2").selected = true;
            }else if(type == "comment"){
                document.getElementById("opt3").selected = true;
            }else if(type == "transaction"){
                document.getElementById("opt4").selected = true;
            }
            console.log(type);
            const paginationLinks = document.querySelectorAll(".page-link");
            var search = location.search.substring(1);
            if (paginationLinks) {
                paginationLinks.forEach(item => {
                    const params = new URLSearchParams(search);
                    const page = item.getAttribute("data");
                    params.set('page', page);
                    const href = new URLSearchParams(params).toString();
                    item.setAttribute("href", "?" + href);
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
