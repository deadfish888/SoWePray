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
                            <h3 class="page-title mb-0 p-0">Activities</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">User ${requestScope.userA.name} Detail</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                        <form action="./Users" method="Post" style="margin-left: 80%">
                            <c:choose>
                                <c:when test="${userA.is_super()==0}">
                                    <a><button class="btn btn-primary" name="id_up" value="${userA.getId()}" type="submit">Up<i class="fa-solid fa-up-long"></i></button></a>
                                        </c:when>
                                        <c:when test="${userA.is_super()+1==sessionScope.admin.is_super()}">
                                    <a><button class="btn btn-primary" name="id_down" value="${userA.getId()}" type="submit">Down<i class="fa-solid fa-down-long"></i></button></a>
                                    <a><button class="btn btn-primary" name="id_ban" value="${userA.getId()}" type="submit">Disable<i class="fa-solid fa-user-slash"></i></button></a>
                                        </c:when>
                                        <c:when test="${userA.is_super()==1}">
                                    <a><button class="btn btn-primary" name="id_up" value="${userA.getId()}" type="submit">Up<i class="fa-solid fa-up-long"></i></button></a>
                                    <a><button class="btn btn-primary" name="id_ban" value="${s.getId()}" type="submit">Disable<i class="fa-solid fa-user-slash"></i></button></a>
                                        </c:when>
                                        <c:otherwise>
                                    <a><button class="btn btn-primary" name="id_up" value="${userA.getId()}" type="submit">Up<i class="fa-solid fa-up-long"></i></button></a>
                                    <a><button class="btn btn-primary" name="id_down" value="${userA.getId()}" type="submit">Down<i class="fa-solid fa-down-long"></i></button></a>
                                    <a><button class="btn btn-primary" name="id_ban" value="${userA.getId()}" type="submit">Disable<i class="fa-solid fa-user-slash"></i></button></a>
                                        </c:otherwise>
                                    </c:choose>
                        </form>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Container fluid  -->
                <!-- ============================================================== -->
                <div class="container-fluid" >

                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="col-md-6" style="width: 100% ; display: flex ; flex-direction: row">
                        <div class="card" style="flex-basis:  20%">
                            <div class="card-header">
                                <div class="card-title">Detail</div>
                            </div>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="example-email" class="col-md-12"><i class="fa-solid fa-envelope"></i> Email</label>
                                    <div class="col-md-12">
                                        ${requestScope.userA.email}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12 mb-0"><i class="fa-solid fa-user"></i>  Username</label>
                                    <div class="col-md-12">
                                        ${requestScope.userA.username}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12 mb-0"><i class="fa-solid fa-address-book"></i> Full Name</label>
                                    <div class="col-md-12">
                                        ${requestScope.userA.name}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12 mb-0"><i class="fa-solid fa-phone"></i>  Phone</label>
                                    <div class="col-md-12">
                                        ${requestScope.userA.phone}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12 mb-0"><i class="fa-sharp fa-solid fa-location-pin"></i>  Address</label>
                                    <div class="col-md-12">
                                        ${requestScope.userA.address}
                                    </div>
                                </div>
                                <div class="form-group">
                                    <a href="LoadAuthor?sendid=${requestScope.userA.id}" style="text-decoration: none;">
                                        <label class="col-md-12 mb-0">${requestScope.userA.username} Novels : ${requestScope.numberNovel}</label></a>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-12 mb-0"> ${requestScope.userA.username} Books : ${requestScope.numberBook}</label>
                                </div>
                            </div>
                        </div>
                        <div class="card" style="flex-basis:  50%;margin-left: 5px">
                            <div class="card-header">
                                <div class="card-title">Transaction</div>
                            </div>
                            <div class="card-body">

                                <div class="card-sub">	


                                </div>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;">
                                            <th class="border-top-0">Balance After</th>
                                            <th class="border-top-0" style="align-content: center">Description</th>
                                            <th class="border-top-0">Date - Time</th>
                                            <th class="border-top-0">Status</th>


                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="s" items="${listA}">
                                            <tr>
                                                <td>${s.balanceAfter}</td>
                                                <td  style="align-content: center">
                                                    <div class="form-group">
                                                        ${s.description}

                                                    </div>
                                                </td>
                                                <td>  
                                                    ${s.transactionTime}
                                                </td>
                                                <td>${s.getStatus()}</td>
                                            </tr>

                                            <!-- Show detail modal -->
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="Activities?xpage10=${xpage10-1}" class="page-link" style="${xpage10<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage10}" var="item">
                                            <li class="page-item ${item==xpage10?"active":""}">
                                                <a href="Activities?xpage10=${item}"  

                                                   class="page-link " style="${(xpage10-1>item || xpage10+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="Activities?xpage10=${xpage10+1}" class="page-link" style="${xpage10+2>numPage10?"display:none":""}">
                                                <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>

                            </div>
                        </div>
                        <div class="card" style="flex-basis:  50%;margin-left: 5px">
                            <div class="card-header">
                                <div class="card-title">Report - Ticket</div>
                            </div>
                            <div class="card-body">
                                <div class="card-sub">											

                                </div>
                                <table class="table table-striped mt-3">
                                    <thead>
                                        <tr style="cursor: pointer; font-size: 15px;">
                                            <th class="border-top-0">Type</th>
                                            <th class="border-top-0" style="padding-left: 20px">Note</th>
                                            <th class="border-top-0">Sent</th>
                                            <th class="border-top-0">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="contentList">
                                        <c:forEach var="se" items="${listU}">
                                            <tr>
                                                <td>${se.getTypeName()}</td>
                                                <td style="padding-left: 20px">
                                                    ${se.note}
                                                </td>
                                                <td>${se.sent}</td>
                                                <td>${se.getStage()}</td>
                                            </tr>

                                            <!-- Show detail modal -->
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="Activities?xpage20=${xpage20-1}" class="page-link" style="${xpage20<3?"display:none":""}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage20}" var="item">
                                            <li class="page-item ${item==xpage20?"active":""}">
                                                <a href="Activities?xpage20=${item}"  

                                                   class="page-link " style="${(xpage20-1>item || xpage20+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="Activities?xpage2=${xpage2+1}" class="page-link" style="${xpage2+2>numPage20?"display:none":""}">
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