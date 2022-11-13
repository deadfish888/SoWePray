<%-- 
    Document   : Bookshelf
    Created on : Oct 13, 2022, 9:03:38 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<script src="../assets/js/ProfileScript.js" type="text/javascript"></script>-->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>Support</title>
    </head>
    <body>
        <div class = "wrapper" style="min-height: 100vh">

            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="../images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id} ${sessionScope.user.is_super() eq 3?"- <i class=\"fa fa-dollar\"></i>":""}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item ">
                        <a href="./Profile">My Profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Novels">My Novels</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Payment">Payment</a>
                    </li>
                    <li class="active sidebar-item">
                        Support
                    </li>
                </ul>   
            </nav>
            <div class="col-md-12" style="display: block">
                <div class="" style="padding: 0; display: block">
                    <header id="header" style="padding: 0;padding-top: 1.1em">
                        <div>
                            <!-- Logo -->
                            <a href="<%=request.getContextPath()%>/Home" class="logo" style="margin-bottom: 1.1em">
                                <span class="fa fa-book" style="padding-left: 2em"></span>
                                <span class="title">BOOKIE</span>
                            </a>


                            <!-- Nav -->
                            <nav>
                                <ul>
                                    <li><a href="#menu">Menu</a></li>
                                </ul>
                            </nav>
                        </div>
                    </header>

                    <!-- Menu -->
                    <jsp:include page="/views/base/menu.jsp" />

                </div>


                <div id="userInfo" class="text-center" style="margin-left: -20%">
                    <form action="./Support" method="Post">
                        <div>
                            <a href="Support"> 
                                <span class="m-0" style="padding: 0 2em; display: inline-block">
                                    <span class="fas fa-book" style="margin-right:0.5em;">  Read</span><br/>
                                </span>
                            </a>
                            <a href="Support?type=1"> 
                                <span class="m-0 border-left border-right" style="padding: 0 2em; display: inline-block">
                                    <span class="fas fa-heart" style="margin-right:0.5em;">  Unread</span><br/>
                                </span>
                            </a>

                            <a href="Support?type=2"> 
                                <span class="m-0" style="padding: 0 2em; display: inline-block">
                                    <span class="fas fa-pen-nib" style="margin-right:0.5em;">  Sending</span><br/>

                                </span>
                            </a>


                        </div>
                    </form>

                </div>

                <div class="table-responsive" style="margin: 2% 4%">
                    <table class="table user-table " id="tablepro" style="width:70%">
                        <thead>
                            <tr style="cursor: pointer; font-size: 15px;">
                                <th style="width: 20%">Title</th>
                                <th style="width: 40%;text-align: center">Note</th>
                                <th style="width: 10%">Sent</th>
                                <th style="width: 10%">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reads" items="${reads}">
                                <tr data-toggle="modal" data-target="#changePasswordModal" style="cursor: pointer" >
                                    <td style="width: 20%">${reads.getTypeName()}
                                        <div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h3 class="modal-title">Report Detail</h3>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!--<div class="wrapper row">-->
                                                        <table>
                                                            <tr>
                                                                <th>
                                                                    Title
                                                                </th>
                                                                <td>
                                                                    <span>${reads.getTypeName()}</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>
                                                                    Note
                                                                </th>
                                                                <td>
                                                                    <span>${reads.note}</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>
                                                                    Date
                                                                </th>
                                                                <td>
                                                                    <span>Sending : ${reads.sent}  </span>
                                                                    <c:if test="${reads.received!=null}">
                                                                        <span>- Reading : ${reads.received}</span>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>
                                                                    Status
                                                                </th>
                                                                <td>
                                                                    <span>${reads.stage}</span>
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="width: 40%;text-align: center">${reads.note}</td>
                                    <td style="width: 10%">
                                        ${reads.sent}
                                    </td>
                                    <td style="width: 10%">${reads.stage} </td>
                                    <c:if test="${requestScope.okok!=null}">
                                        <td style="width: 10%"><a class="btn btn-secondary" href="OnRead?rpID=${reads.id}">V</a>
                                        </td>
                                    </c:if>

                                </tr>

                            </c:forEach>
                        </tbody>

                    </table>
                    <c:if test="${requestScope.okok!=null}">
                        <a style="margin-left: 60%" class="btn btn-secondary" href="OnRead">Read ALL</a>
                    </c:if>

                </div>

                <div>
                    <c:if test="${requestScope.forTick!=null}" >
                        <button type="button" data-toggle="modal" data-target="#changeEmailModal">Ticket</button>
                        <div class="modal fade" id="changeEmailModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">Report</h3>
                                    </div>
                                    <form action="Support" method="Post">
                                        <div class="modal-body">
                                            <!--<div class="wrapper row">-->
                                            <table>
                                                <tr>
                                                    <th>
                                                        Name
                                                    </th>
                                                    <td>
                                                        ${sessionScope.user.name}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        Note
                                                    </th>
                                                    <td>
                                                        <input type="text" name="txt"/>
                                                    </td>
                                                </tr>

                                            </table>
                                            <!--</div>-->
                                        </div>
                                        <div class="modal-footer" style="text-align: center">
                                            <button type="button" data-dismiss="modal">Cancel</button>
                                            <button type="submit" name="action" value="support" >Send</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Scripts -->

        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery.scrolly.min.js"></script>
        <script src="../assets/js/jquery.scrollex.min.js"></script>
        <script src="../assets/js/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>

        <script>

        </script>
    </body>
</html>
