<%-- 
    Document   : Profile
    Created on : Sep 12, 2022, 1:02:02 PM
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
        <title>Profile</title>
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
                    <li class="active sidebar-item">
                        My profile
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
