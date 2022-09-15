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
        <script src="../javascripts/ProfileScript.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>Profile</title>
    </head>
    <body>
        <!--        <div class="preloader">
                    <div class="lds-ripple">
                        <div class="lds-pos"></div>
                        <div class="lds-pos"></div>
                    </div>
                </div>-->

        <div class="wrapper">

            <nav id="sidebar" class="bg-dark col-md-2">
                <div class="sidebar-header">
                    <h3>Bootstrap Sidebar</h3>
                </div>

                <ul class="list-unstyled components">
                    <p>Dummy Heading</p>
                    <li class="active">
                        <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Home</a>
                        <ul class="collapse list-unstyled" id="homeSubmenu">
                            <li>
                                <a href="#">Home 1</a>
                            </li>
                            <li>
                                <a href="#">Home 2</a>
                            </li>
                            <li>
                                <a href="#">Home 3</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">About</a>
                    </li>
                    <li>
                        <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Pages</a>
                        <ul class="collapse list-unstyled" id="pageSubmenu">
                            <li>
                                <a href="#">Page 1</a>
                            </li>
                            <li>
                                <a href="#">Page 2</a>
                            </li>
                            <li>
                                <a href="#">Page 3</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">Portfolio</a>
                    </li>
                    <li>
                        <a href="#">Contact</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10">
            <!-- Header -->
<!--            <div class="topbar">-->
                
                <header id="header">
                    <div class="inner">
                        <!-- Logo -->
                        <a href="<%=request.getContextPath()%>/Home" class="logo">
                            <span class="fa fa-book"></span>
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
<!--            </div>-->
                
            <div>
                <h1>MY PROFILE</h1>
                <table>
                    <tr>
                        <th>
                            Name
                        </th>
                        <td colspan="0" class="input">
                            ${sessionScope.user.name}
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Email
                        </th>
                        <td colspan="0" class="input">
                            ${sessionScope.user.email}
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Birth
                        </th>
                        <td class="input">
                            ${sessionScope.user.dob}
                        </td>
                        <th>
                            Gender
                        </th>
                        <td class="input">
                            ${sessionScope.user.gender}
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Phone number
                        </th>
                        <td colspan="0" class="input">
                            ${sessionScope.user.phone}
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Address
                        </th>
                        <td colspan="0" class="input">
                            ${sessionScope.user.address}
                        </td>
                    </tr>
                </table>
                <button onclick="editProfile()">Edit</button>
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
