<%-- 
    Document   : report
    Created on : Sep 30, 2022, 2:07:49 PM
    Author     : ttaad
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Report Comment</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <link rel="stylesheet" href="assets/css/StarRating.css" />
        <link rel="stylesheet" href="assets/css/rateButton.css" />
        
        
        <noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
    </head>
    <body class="is-preload">
        <!-- Wrapper -->
        <div id="wrapper">

            <!-- Header -->
            <header id="header">
                <div class="inner">
                    <!-- Logo -->
                    <a href="./Home" class="logo">
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
            <jsp:include page="/views/base/menu.jsp" />

            <!-- Main -->
            <div id="main">
                <div class="inner">
                    <h1> Report Comment </h1>
                    <h2> ${book.title} </h2>
                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.getImage()}" class="img-fluid" alt="${book.getImage()}">
                                
                            </div>
                            <div class="col-md-7">
                                <table class="table">
                                    <tr>
                                        <th>User</th>
                                        <th>Comment</th>
                                    </tr>
                                    <tr>
                                        <th style="width: 200px" scope="row">
                                            ${comment.user.name}
                                        </th>
                                        <td style="white-space: pre-line" style="height: 100px">${comment.comment}</td>
                                    </tr>
                                </table> 
                                <ul class="ks-cboxtags">
                                    <form action="ReportComment" method="post">
                                        <input type="hidden" name="bId" value="${book.id}">
                                        <input type="hidden" name="cId" value="${comment.id}">
                                        <c:forEach items="${list}" var="v">
                                          <li><input type="checkbox" id="${v.id}" name="report" value="${v.id}"><label for="${v.id}">${v.title}</label></li>
                                        </c:forEach>
                                        <li><textarea id="id" name="note" rows="5" cols="10" placeholder="Issue details..." required="true"></textarea></li>
                                        <li><input type="submit" class="primary" value="Send Report"></li>
                                    </form>
                                </ul>         
                            </div>
                        </div>           
                    </div>
                    <br>
                    <br>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li><span class="fa fa-github"></span> <a href="https://github.com/nekon0/SoWePray">Our Project</a></li>
                            <li><span class="fa fa-map-pin"></span> <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7"> DE210, FBT University</a></li>
                        </ul>
                    </section>

                    <ul class="copyright">
                        <li> Bookie </li>
                    </ul>
                </div>
            </footer>

        </div>

        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>
        <script src="/Bookie/manage/html/js/custom.js"></script>

    </body>
</html>

