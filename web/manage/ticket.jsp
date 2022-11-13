<%-- 
    Document   : UserList
    Created on : Sep 14, 2022, 1:48:48 PM
    Author     : duypham0705
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
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, materialpro admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, materialpro admin lite design, materialpro admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Material Pro Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Users Management</title>
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
                            <h3 class="page-title mb-0 p-0">Ticket</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Ticket</li>
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
                    <div class="row">
                        <!-- column -->
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">List</h4>
                                    <div class="table-responsive">
                                        <table class="table user-table">

                                           
                                            <thead>
                                                <tr style="cursor: pointer; font-size: 15px;">
                                                    <th class="border-top-0"><i class="fa-solid fa-list-ol"></i></th>
                                                    <th class="border-top-0">UserID</th>
                                                    <th class="border-top-0">Type</th>
                                                    <th class="border-top-0" style="text-align: center">Note</th>
                                                    <th class="border-top-0">Sent</th>

                                                    <th class="border-top-0"><i class="fa-solid fa-ranking-star"></i></th>
                                                </tr>
                                            </thead>
                                            <tbody id="contentList">
                                                <c:forEach var="s" items="${baocao}">
                                                <form action="./Ticket" method="Post">
                                                    <tr>
                                                        <td>${s.id}</td>
                                                        <td width="15%"><a style="text-decoration: none" href="Activities?id=${s.uid}">${s.uid}</a></td>
                                                        
                                                        <c:choose>
                                                            <c:when test="${s.typeID==4}">
                                                                <td><a href="LoadAuthor?sendid=${s.uid}" style="text-decoration: none">${s.getTypeName()}</a></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                  <td>${s.getTypeName()}</td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td style="width: 40%;text-align: center;">${s.note}</td>
                                                        <td>${s.sent}</td>
                                                        <td>  
                                                            <div class="dropdown">
                                                                <button class="btn btn-primary"><i class="fa fa-chevron-down"></i></button>
                                                                <div class="noidung_dropdown">
                                                                    <a><button class="btn btn-primary" name="id_pass" value="${s.id}" type="submit">Pass</button></a>
                                                                    <a><button class="btn btn-primary" name="id_reject" value="${s.id}" type="submit">Reject</button></a>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </form>

                                                <!-- Show detail modal -->
                                            </c:forEach>
                                            </tbody>

                                        </table>

                                    </div>
                                    <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                        <ul class="pagination">
                                            <li class="page-item" >
                                                <a href="Ticket?xpage=${xpage-1}" class="page-link" style="${xpage<3?"display:none":""}">
                                                    <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                                </a>
                                            </li>
                                            <c:forEach begin="${1}" end="${numPage}" var="item">
                                                <li class="page-item ${item==xpage?"active":""}">
                                                    <a href="Ticket?xpage=${item}" 
                                                       class="page-link " style="${(xpage-1>item || xpage+1<item ) ?"display:none;":""}"
                                                       >${item}</a></li>
                                                </c:forEach>
                                            <li >
                                                <a href="Ticket?xpage=${xpage+1}" class="page-link" style="${xpage+2>numPage?"display:none":""}">
                                                    <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                                </a>
                                            </li>
                                            <li style="margin-left: 80%">
                                                <form action="./Ticket" method="Post">
                                                    <a><button class="btn btn-primary" name="id_pass" value="0" type="submit">Pass</button></a>
                                                    <a><button class="btn btn-primary" name="id_reject" value="0"  type="submit">Reject</button></a>
                                                </form>
                                            </li>
                                        </ul>

                                    </div>

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