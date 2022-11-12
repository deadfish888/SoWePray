<%-- 
    Document   : author
    Created on : Oct 10, 2022, 11:06:12 PM
    Author     : duypham0705
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
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Authors Management</title>
        <!-- Favicon icon -->
        <!-- Custom CSS -->
        <link href="/Bookie/manage/html/css/style.min.css" rel="stylesheet">
        <link href="/Bookie/manage/html/css/dropdown.css" rel="stylesheet">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
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
                            <h3 class="page-title mb-0 p-0">Authors Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Authors Management</li>
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
                    <div class="col-md-6" style="width: 100% ; display: flex ; flex-direction: row">
                        <div class="card" style="flex-basis:  50%">
                            <div class="card-header">
                                <div class="card-title">Authors</div>
                            </div>
                            <div class="card-body">

                                <div class="card-sub">	

                                    <div class="form-outline">
                                        <form action="Author" method="Post">
                                            <input type="search" id="form1" class="form-control" placeholder="Search . . . ." aria-label="Search" style="width: 200px"
                                                   name="txt" type="text" value="${txt}" >
                                        </form>

                                    </div>
                                </div>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;">
                                            <th class="border-top-0"><i class="fa-solid fa-list-ol"></i></th>
                                            <th class="border-top-0" style="padding-left: 100px">Full Name</th>
                                            <th class="border-top-0"></th>

                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="s" items="${listA}">
                                        <form action="./Author" method="Post">
                                            <tr>
                                                <td><a href="LoadAuthor?aid=${s.id}" style="text-decoration: none">${s.id}</a></td>
                                                <td style="padding-left: 100px">
                                                    <div class="form-group">
                                                        
                                                        <div class="col-md-12">
                                                            <input type="text" placeholder="${s.name}" 
                                                                   class="form-control ps-0 form-control-line" name="fullname" style="border: none;background-color:  inherit">
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>  
                                                    <button class="btn btn-primary" name="id_au" value="${s.id}"><i class="mdi mdi-update"></i></button>
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
                        <div class="card" style="flex-basis:  30%;margin-left: 100px">
                            <div class="card-header">
                                <div class="card-title">Users - Authors</div>
                            </div>
                            <div class="card-body">
                                <div class="card-sub">											
                                    <div class="form-outline">
                                        <form action="Author" method="Post">
                                            <input type="search" id="form1" class="form-control" placeholder="Search . . . ." aria-label="Search" style="width: 200px"
                                                   name="stxt" type="text" value="${stxt}" >
                                        </form>
                                    </div>
                                </div>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;">
                                            <th class="border-top-0"><i class="fa-solid fa-list-ol"></i></th>
                                            <th class="border-top-0" style="padding-left: 100px">Full Name</th>

                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <% int no1=1;%>
                                        <c:forEach var="se" items="${listU}">
                                        <form action="./Users" method="Post">
                                            <tr>
                                                <td><a href="LoadAuthor?aid=${se.id}" style="text-decoration: none">${se.id}</a></td>
                                                <td style="padding-left: 100px">
                                                    <div class="form-group">
                                                        <div class="col-md-12">
                                                            <input type="text" placeholder="${se.name}"
                                                                   class="form-control ps-0 form-control-line" name="fullname" style="border: none;background-color:  inherit">
                                                        </div>
                                                    </div>
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
                                            <a href="LoadAuthor?xpage2=${xpage2-1}" class="page-link" style="${xpage2<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage2}" var="item">
                                            <li class="page-item ${item==xpage2?"active":""}">
                                                <a href="LoadAuthor?xpage2=${item}"  

                                                   class="page-link " style="${(xpage2-1>item || xpage2+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="LoadAuthor?xpage2=${xpage2+1}" class="page-link" style="${xpage2+2>numPage2?"display:none":""}">
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