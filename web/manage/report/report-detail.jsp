<%-- 
    Document   : report-detail
    Created on : Oct 28, 2022, 2:41:44 PM
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
        <title>Report No.${report.id}</title>
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
                                        <li class="breadcrumb-item"><a href="/Bookie/Admin/Report">Reports</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">No.${report.id}</li>
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
                        <div class="col-4">
                            <div class="card">
                                <div class="card-body profile-card">
                                    <c:choose>
                                        <c:when test="${report.reportType == 1}">
                                            <center class="mt-4"> <img src="${report.bookO.image}" class="rounded"
                                                                       width="150" />
                                                <h4 class="card-title mt-2">
                                                    <a target="_blank" href="../BookDetail?id=${report.bookO.id}"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                    <a target="_blank" href="./BookDetail?id=${report.bookO.id}">${report.bookO.title} - ID: ${report.bookO.id}</a></h4>

                                                <c:if test="${report.bookO.author.userId !=0}">
                                                    <h6 class="card-subtitle">Creator: <a target="_blank" href="./Activities?id=${report.bookO.author.userId}">${report.bookO.author.user.name} - ID: ${report.bookO.author.userId}</a></h6>
                                                </c:if>
                                                <c:if test="${report.bookO.author.userId ==0}">
                                                    <h6 class="card-subtitle">Author: ${report.bookO.author.name}</h6>
                                                </c:if>
                                            </center>
                                        </c:when>
                                        <c:when test="${report.reportType == 2}">
                                            <center class="mt-4"> <img src="../images/default.png" class="rounded-circle"
                                                                       width="100" />
                                                <h4 class="card-title mt-2">
                                                    <a target="_blank" href="./Activities?id=${report.comO.userId}"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                    ${report.comO.user.name} - ID: ${report.comO.userId}
                                                </h4>
                                                <h6 class="card-subtitle">
                                                    <a target="_blank" href="../BookDetail?id=${report.bookO.id}&cmtId=${report.comO.id}"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                    CommentID: ${report.comO.id}
                                                </h6>

                                            </center>
                                        </c:when>
                                        <c:when test="${report.reportType == 5}">
                                            <h6 class="card-title mt-2">
                                                <form action="./Transaction" method="post">
                                                    <input type="hidden" name="transId" value="${report.transO.transactionId}">
                                                    <button class="btn" type="submit"><i class="fa fa-external-link-alt" aria-hidden="true"></i></button>
                                                    Transaction ID: ${report.transO.transactionId}
                                                </form>
                                            </h6>
                                            <h6 class="card-title mt-2">
                                                <a target="_blank" href="./Activities?id=${report.userId}"><i class="fa fa-external-link-alt" aria-hidden="true"></i></a>
                                                User: ${report.userR.username} - ID: ${report.userId}
                                            </h6>
                                            <h6 class="card-subtitle">
                                                Amount: ${report.transO.amount}
                                            </h6>
                                            <h6 class="card-subtitle">
                                                Type:<c:if test="${report.transO.type eq 1}">Deposit</c:if> 
                                                <c:if test="${report.transO.type eq 2}">Withdraw</c:if> 
                                                <c:if test="${report.transO.type eq 3}">Purchase</c:if> 
                                                <c:if test="${report.transO.type eq 4}">Selling</c:if> 
                                                </h6>  
                                                <h6 class="card-subtitle">
                                                    Description: ${report.transO.description}
                                            </h6>
                                            <h6 class="card-subtitle">
                                                Time: ${report.transO.transactionTime eq null? "Pending":report.transO.transactionTime}
                                            </h6>

                                        </c:when>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="card">
                                <div class="card-header">
                                    <div class="card-title">Report No.${report.id}</div>
                                    <c:choose>
                                        <c:when test="${empty report.isStatus()}">
                                            <span class="badge rounded-pill bg-success">Open</span>
                                        </c:when>
                                        <c:when test="${report.isStatus()}">
                                            <span class="badge rounded-pill bg-purple">Closed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-danger">Rejected</span>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${report.reportType == 1 || report.reportType ==2 }">
                                            <form action="./ReportDetail" method="post">
                                                <input type="hidden" name="id" value="${report.id}">
                                                <table class="table">
                                                    <tr>
                                                        <th>Type</th>
                                                        <td>${report.reportTypeName}</td>
                                                    </tr>
                                                    <c:if test="${report.reportType ==2 }">
                                                        <tr>
                                                            <th>Content</th>
                                                            <td style="white-space: pre-line; font-style: italic">${report.comO.comment}</td>
                                                        </tr>
                                                    </c:if>
                                                    <tr>
                                                        <th>Reporter</th>
                                                        <td><a target="_blank" href="./Activities?id=${report.userId}">${report.userR.username}</a> - ID: ${report.userId}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Violations</th>
                                                        <td>
                                                            <ul>
                                                                <c:forEach var="ss" items="${report.violates}">
                                                                    <li>${ss.title}</li>
                                                                    </c:forEach>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Detail</th>
                                                        <td style="white-space: pre-line">${report.note}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Sent</th>
                                                        <td>${report.getSent()}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Status</th>
                                                        <td>
                                                            ${empty report.isStatus()?"Pending":(report.isStatus()?(report.getReceived()):"Rejected")}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Action</th>
                                                        <td>
                                                            <c:if test="${empty report.isStatus()}">
                                                                <textarea class="form-control" style="white-space: pre-line" name="action" rows="5" required>${report.action}</textarea>
                                                            </c:if>
                                                            <c:if test="${!empty report.isStatus()}">
                                                                <p style="white-space: pre-line">${report.action}</p>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <c:if test="${empty report.isStatus()}">
                                                    <div class="row mt-3">
                                                        <div class="col-md-1">
                                                            <button type="submit" name="service" value="close" class="btn btn-primary">Close</button>
                                                        </div>
                                                        <div class="col-md-1 m-l-10">
                                                            <button type="submit" name="service" value="reject" class="btn btn-danger">Reject</button>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="./ReportDetail" method="post">
                                                <input type="hidden" name="id" value="${report.id}">
                                                <table class="table">
                                                    <tr>
                                                        <th>Type</th>
                                                        <td>${report.reportTypeName}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Problems</th>
                                                        <td>
                                                            <ul>
                                                                <c:forEach var="ss" items="${report.violates}">
                                                                    <li>${ss.title}</li>
                                                                    </c:forEach>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Detail</th>
                                                        <td style="white-space: pre-line">${report.note}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Sent</th>
                                                        <td>${report.getSent()}</td>
                                                    </tr>
                                                    <tr>
                                                        <th>Status</th>
                                                        <td>
                                                            ${empty report.isStatus()?"Pending":(report.isStatus()?(report.getReceived()):"Rejected")}
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>Action</th>
                                                        <td>
                                                            <c:if test="${empty report.isStatus()}">
                                                                <textarea class="form-control" style="white-space: pre-line" name="action" rows="5" required>${report.action}</textarea>
                                                            </c:if>
                                                            <c:if test="${!empty report.isStatus()}">
                                                                <p style="white-space: pre-line">${report.action}</p>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <c:if test="${empty report.isStatus()}">
                                                    <div class="row mt-3">
                                                        <div class="col-md-1">
                                                            <button type="submit" name="service" value="close" class="btn btn-primary">Close</button>
                                                        </div>
                                                        <div class="col-md-1 m-l-10">
                                                            <button type="submit" name="service" value="reject" class="btn btn-danger">Reject</button>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
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
            var element = document.getElementById("report-management");
            element.classList.add("selected");
            element = document.getElementById("report-management-a");
            element.classList.add("active");
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

