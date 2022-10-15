<%-- 
    Document   : EditProfile
    Created on : Sep 14, 2022, 12:53:15 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
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
                        <a href="./Payment">Payment</a>
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

                    <jsp:include page="/views/base/menu.jsp" />
                </div>
                <!--            </div>-->

                <div>
                    <div class="text-center">
                        <h1>MY PROFILE</h1>

                    </div>
                    <form method="post" action="Profile" style="width: 90%; display: block; margin: auto">
                        <table class="border-0">
                            <tr>
                                <th style="width: 25%; padding: inherit;padding-left: 5%; vertical-align: middle">
                                    Name<span style="color: red">*</span>
                                </th>
                                <td colspan="4">
                                    <input type="text" name="name" value="${sessionScope.user.name}"/>
                                    <div style="color: red">${requestScope.nameMessage1}</div>
                                    <div style="color: red">${requestScope.nameMessage2}</div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Email
                                </th>
                                <td colspan="4">
                                    ${sessionScope.user.email}
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Birth<span style="color: red">*</span>
                                </th>
                                <td style="width: 27%; padding-right: 5%">
                                    <input type="date" name="dob" value="${sessionScope.user.dob}" style="width: 100%"/>
                                </td>
                                <th style="width: 20%">
                                    Gender
                                </th>
                                <td style="width: auto">
                                    <input type="radio" name="gender" value="Male" id="male" <c:if test="${sessionScope.user.gender eq 'Male'}"> checked="checked" </c:if>/>
                                    <label for="male">Male</label>
                                </td>
                                <td style="width: auto">
                                    <input type="radio" name="gender" value="Female" id="female" <c:if test="${sessionScope.user.gender ne 'Male'}"> checked="checked"</c:if>/>
                                <label for="female">Female</label>
                                </td>
                                </tr>
                                <tr>
                                    <th>
                                        Phone number<span style="color: red">*</span>
                                    </th>
                                    <td colspan="4">
                                        <input type="tel" name="phone" value="${sessionScope.user.phone}"/>
                                    <div style="color: red">${requestScope.phoneMessage}</div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    Address
                                </th>
                                <td colspan="4">
                                    <input type="text" name="address" value="${sessionScope.user.address}"/>
                                </td>
                            </tr>
                        </table>
                        <div class="text-center">
                            <!--<button class="" onclick="editProfile()">Edit</button>-->
                        </div>
                        <div style="text-align: center">
                            <input type="submit" name="action" value="clear"/>
                            <input type="submit" name="action" value="save" style="margin: 0em 2em"/>
                            <input type="submit" name="action" value="change email"/>
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
