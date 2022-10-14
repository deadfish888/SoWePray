<%-- 
    Document   : Works
    Created on : Oct 11, 2022, 7:57:45 PM
    Author     : ACER
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
        <title>My Novels</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="../images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">My profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
                    </li>
                    <li class="active sidebar-item">
                        My Novels
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

                    <!-- Menu -->
                    <jsp:include page="/views/base/menu.jsp" />

                </div>
                <!--            </div>-->

                <div>
                    <div class="text-center">
                        <h2>Series of ${sessionScope.user.name}</h2>
                    </div>
                    <div class="container border rounded py-3">
                        <div class="row col-12">
                            <div class="left-part col-6" style="margin-bottom: 20px">
                                <a class="btn btn-secondary" href="./CreateNovel">Create!</a>
                            </div>

                            <div class="col-5"><form action="./Novels" method="get">
                                    <input name="search" class="form-control" type="text" placeholder="Search by Title" aria-label="Search"><!-- comment --></form>
                            </div>
                            <div class="col-1">
                                <span class="fa fa-search" style="vertical-align: bottom"></span>
                            </div>

                        </div>
                        <div class="table-responsive">
                            <table class="table user-table " id="tablepro">
                                <thead>
                                    <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                        <th>Title</th>
                                        <th style="width: 150px;">Image</th>
                                        <th>Genre</th>
                                        <th style="width: 30px;">Paid</th>
                                        <th style="width: 30px;">Update</th>
                                        <th style="width: 30px;">TOC</th>
                                        <th style="width: 30px;">Enable</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td>${book.title}</td>
                                            <td style="width: 150px;"><img  src="${!empty book.image? book.image : "../images/novel-sample.png"}" width="100px"></td>
                                            <td>
                                                <c:forEach items="${book.category}" var="category">
                                                    <span class="badge rounded-pill bg-secondary" style="font-size: 80%;font-weight: 400;color: whitesmoke;">${category.name}</span>
                                                </c:forEach>
                                            </td>
                                            <td><span class="fa ${book.issale()? "fa-check-square-o":"fa-times-circle"}"></span></td>
                                            <td><a class="btn btn-primary" href="./UpdateNovel?id=${book.id}"><i class="fa fa-pencil-square" aria-hidden="true"></i></a></td>
                                            <td><a class="btn btn-secondary" href="./Novels/TOC?id=${book.id}"><i class="fa fa-angle-right" aria-hidden="true"></i></a></td>
                                            <td>
                                                <form action="Disable" method="get">
                                                    <label class="switch">
                                                        <a href="./ChangeStatus?id=${book.id}" class="change-link" data="${book.id}">
                                                            <input id="myButton"  type="checkbox" name="status" ${book.status() ? "checked": null}>
                                                            <span class="slider"></span>
                                                        </a>
                                                    </label>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <c:if test="${empty books}">
                                <h4>
                                    No work to show
                                </h4>
                            </c:if>
                            <div class="${numPage <= 1 ? "hidden" : ""}" style="margin-left: 40%">
                                <ul class="pagination">
                                    <li class="page-item pl-0" >
                                        <a href="./Novels?page=${page-1}" class="page-link" data="${page-1}"
                                           style="${page<3?"display:none":""}">
                                            <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="${1}" end="${numPage}" var="item">
                                        <li class=" page-item ${item==page?"active":""} pl-0">
                                            <a href=".Book?page=${item}" class="page-link" data="${item}"
                                               style="${(page-1>item || page+1<item ) ?"display:none;":""}"
                                               >${item}</a></li>
                                        </c:forEach>
                                    <li class="page-item pl-0">
                                        <a href=".Novels?page=${page+1}" class="page-link" data="${page+1}"
                                           style="${page+2>numPage?"display:none":""}">
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>


        </div>
        <!-- Scripts -->

        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery.scrolly.min.js"></script>
        <script src="../assets/js/jquery.scrollex.min.js"></script>
        <script src="../assets/js/main.js"></script>
        <script>
            var search = location.search.substring(1);
            const changeLinks = document.querySelectorAll(".change-link");
            if (changeLinks) {
                changeLinks.forEach(item => {
                    const params = search ? JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"')
                            .replace(/&/g, '","').replace(/=/g, '":"') + '"}') : {};
                    const id = item.getAttribute("data");
                    params.id = id;
                    const href = new URLSearchParams(params).toString();
                    item.setAttribute("href", "./Status?" + href);
                });
            }
            const paginationLinks = document.querySelectorAll(".page-link");
            if (paginationLinks) {
                paginationLinks.forEach(item => {
                    const params = search ? JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"')
                            .replace(/&/g, '","').replace(/=/g, '":"') + '"}') : {};
                    const page = item.getAttribute("data");
                    params.page = page;
                    const href = new URLSearchParams(params).toString();
                    item.setAttribute("href", "?" + href);
                });
            }
        </script>
    </body>
</html>
