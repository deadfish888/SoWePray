<%-- 
    Document   : Security
    Created on : Sep 17, 2022, 10:05:17 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/views/base/userHeadImport.jsp"/>
        <title>Security</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="${context}/images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id} ${sessionScope.user.is_super() eq 3?"- <i class=\"fa fa-dollar\"></i>":""}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">My profile</a>
                    </li>
                    <li class="active sidebar-item">
                        Security
                    </li>
                    <li class="sidebar-item">
                        <a href="./Novels">My Novels</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Payment">Payment</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Support">Support</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10" style="display: block">
                <!-- Menu -->
                <div class="" style="padding: 0; display: block">
                    <header id="header" style="padding: 0;padding-top: 1.1em">
                        <div>
                            <!-- Logo -->
                            <a href="${context}/Home" class="logo" style="margin-bottom: 1.1em">
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
                    <jsp:include page="/views/base/menu.jsp" />
                </div>

                <div>
                    <div class="text-center">
                        <h1>SECURITY</h1>

                    </div>
                    <table class="border-0">
                        <tr>
                            <th>
                                Linked email
                            </th>
                            <td>
                                ${sessionScope.user.email}
                            </td>
                            <td>
                                <button type="button" data-toggle="modal" data-target="#changeEmailModal">Change</button>
                                <div class="modal fade" id="changeEmailModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <form action="ChangeEmail" method="post">
                                                <div class="modal-header">
                                                    <h3 class="modal-title">Change email</h3>
                                                </div>
                                                <div class="modal-body">
                                                    <!--<div class="wrapper row">-->
                                                    <table>
                                                        <tr>
                                                            <th>
                                                                Current email
                                                            </th>
                                                            <td>
                                                                ${sessionScope.user.email}
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                New email
                                                            </th>
                                                            <td>
                                                                <input type="email" name="newEmail" required/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Password
                                                            </th>
                                                            <td>
                                                                <input type="password" name="password" required/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <!--</div>-->
                                                </div>
                                                <div class="modal-footer" style="text-align: center">
                                                    <button type="button" data-dismiss="modal">Cancel</button>
                                                    <button type="submit" name="action" value="changeEmail">Confirm</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Password
                            </th>
                            <td>
                                <c:if test="${sessionScope.user.getPasswordLevel() == 1}"><span style="color: red">Week</span></c:if>
                                <c:if test="${sessionScope.user.getPasswordLevel() == 2}"><span style="color: #ffbb00">Medium</span></c:if>
                                <c:if test="${sessionScope.user.getPasswordLevel() == 3}"><span style="color: green">Strong</span></c:if>
                                </td>
                                <td>
                                    <button type="button" data-toggle="modal" data-target="#changePasswordModal">Change</button>
                                    <div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <form action="ChangePassword" method="post">
                                                    <div class="modal-header">
                                                        <h3 class="modal-title">Ticket</h3>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!--<div class="wrapper row">-->
                                                        <table>
                                                            <tr>
                                                                <th>
                                                                    Password
                                                                </th>
                                                                <td>
                                                                    <input type="password" name="currentPassword" required/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>
                                                                    New password
                                                                </th>
                                                                <td>
                                                                    <input type="password" name="newPassword" required/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>
                                                                    Confirm password
                                                                </th>
                                                                <td>
                                                                    <input type="password" name="confirmPassword" required/>
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </div>
                                                    <div class="modal-footer" style="text-align: center">
                                                        <button type="button" data-dismiss="modal">Cancel</button>
                                                        <button type="submit" name="action" value="changePassword">Confirm</button>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <div>${sessionScope.processMessage}</div>                    
                    <%request.getSession().removeAttribute("processMessage");%>

                    <div style="color: red">${sessionScope.error}</div>                                   
                    <%request.getSession().removeAttribute("error");%>
                </div>
            </div>


        </div>
        <!-- Scripts -->

        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery.scrolly.min.js"></script>
        <script src="../assets/js/jquery.scrollex.min.js"></script>
        <script src="../assets/js/main.js"></script>
    </body>
</html>
