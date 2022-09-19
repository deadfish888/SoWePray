<%-- 
    Document   : Profile
    Created on : Sep 12, 2022, 1:02:02 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../assets/js/ProfileScript.js" type="text/javascript"></script>
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
                    <li class="active sidebar-item">
                        My profile
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
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
                    <jsp:include page="/views/base/menu.jsp" />
                    <!--class="active" style="color: #F2849E; pointer-events: none; border-left: 5px groove #F2849E; padding-left: 10px"-->

                </div>
                <!--            </div>-->

                <div>
                    <div class="text-center">
                        <h1>MY PROFILE</h1>

                    </div>
                    <form method="post" action="Profile" style="width: 90%; display: block; margin: auto">
                        <table class="border-0">
                            <tr>
                                <th>
                                    Name
                                </th>
                                <td colspan="3">
                                    ${sessionScope.user.name}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Email
                                </th>
                                <td colspan="0">
                                    ${sessionScope.user.email}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Birth
                                </th>
                                <td>
                                    ${sessionScope.user.dob}
                                </td>
                                <th>
                                    Gender
                                </th>
                                <td>
                                    ${sessionScope.user.gender}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Phone number
                                </th>
                                <td colspan="3">
                                    ${sessionScope.user.phone}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Address
                                </th>
                                <td colspan="3">
                                    ${sessionScope.user.address}
                                </td>
                            </tr>
                        </table>
                        <div class="text-center">
                            <!--<button class="" onclick="editProfile()">Edit</button>-->
                        </div>
                        <div style="text-align: center">
                            <input type="submit" name="action" value="edit"/>
                        </div>
                    </form>
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
