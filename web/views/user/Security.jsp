<%-- 
    Document   : Security
    Created on : Sep 17, 2022, 10:05:17 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../javascripts/ProfileScript.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>Profile</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <canvas id="myCanvas" width="100em" height="100em" style="border:2px solid #fff; display: block; margin: auto">
                        Your browser does not support the HTML5 canvas tag.</canvas>
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">My Profile</a>
                    </li>
                    <li class="active">
                        Security
                    </li>
                    <li class="sidebar-item">
                        <a href="#">Settings</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="#">Support</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10" style="display: block">
                <!-- Header -->
                <!--            <div class="topbar">-->

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
                    <nav id="menu">
                        <h2>
                            <c:if test="${!empty sessionScope.user}">
                                Welcome ${sessionScope.user.name}
                            </c:if>
                            <c:if test="${!empty sessionScope.admin}">
                                Welcome ${sessionScope.admin.name}
                            </c:if>
                        </h2>
                        <ul>
                            <li><a href="<%=request.getContextPath()%>/Home">Home</a></li>
                            <li><a href="<%=request.getContextPath()%>/Store">Store</a></li>

                            <c:if test="${!empty sessionScope.user}">
                                <li class="active" style="color: #5cabff; pointer-events: none; border-left: 5px groove #5cabff; padding-left: 10px"><a href="<%=request.getContextPath()%>/User/Profile">My profile</a></li>
                                <li><a href="<%=request.getContextPath()%>/Book?id=0">Bookshelf</a></li>
                                <li><a href="<%=request.getContextPath()%>/Favor">Favor</a></li>
                                <li><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                                </c:if>

                            <c:if test="${!empty sessionScope.admin}">
                                <li class="nav-item"><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                                </c:if>                

                            <li><a href="<%=request.getContextPath()%>/about.jsp">About</a></li>
                                <c:if test="${empty sessionScope.user and empty sessionScope.admin}">
                                <li class="nav-item"><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>
                                </c:if>
                        </ul>
                    </nav>

                </div>
                <!--            </div>-->

                <div>
                    <div class="text-center">
                        <h1>SECURITY</h1>

                    </div>
                    <form method="post" action="Security" style="width: 90%; display: block; margin: auto">
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
                                                                <input type="email" name="newEmail"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Password
                                                            </th>
                                                            <td>
                                                                <input type="password" name="password"/>
                                                                <div style="color: red">${old_pass_noti}</div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <!--</div>-->
                                                </div>
                                                <div class="modal-footer" style="text-align: center">
                                                    <button type="button" data-dismiss="modal">Cancel</button>
                                                    <button type="submit" name="action" value="changeEmail">Confirm</button>
                                                </div>
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
                                                    <div class="modal-header">
                                                        <h3 class="modal-title">Change password</h3>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!--<div class="wrapper row">-->
                                                        <table>
                                                            <tr>
                                                                <th>
                                                                    Password
                                                                </th>
                                                                <td>
                                                                    <input type="password" name="currentPassword"/>
                                                                    <div style="color: red">${old_pass_noti}</div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                New password
                                                            </th>
                                                            <td>
                                                                <input type="password" name="newPassword"/>
                                                                <div style="color: red">${new_pass_noti}</div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>
                                                                Confirm password
                                                            </th>
                                                            <td>
                                                                <input type="password" name="confirmPassword"/>
                                                                <div style="color: red">${confirm_pass_noti}</div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <!--</div>-->
                                                </div>
                                                <div class="modal-footer" style="text-align: center">
                                                    <button type="button" data-dismiss="modal">Cancel</button>
                                                    <button type="submit" name="action" value="changePassword">Confirm</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <p>${processMessage}</p>      

                    </form>
                </div>
            </div>


        </div>
        <!-- Scripts -->

        <script>
            function changePassword() {
                var element = document.getElementById("change-password");
                if (element.style.display == 'none')
                    element.style.display = "block";
                else {
                    element.style.display = 'none';
                }
            }
        </script>
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery.scrolly.min.js"></script>
        <script src="../assets/js/jquery.scrollex.min.js"></script>
        <script src="../assets/js/main.js"></script>
    </body>
</html>
