<%-- 
    Document   : book-reading
    Created on : Sep 28, 2022, 1:56:27 PM
    Author     : thanhienee
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${book.getTitle()}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
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

            <!-- SideOption -->
            <section class="side_option">
                <a href="#"><i class='bx bu bx-chevrons-left bx-sm btm '></i></a>
                <br><a href="BookDetail?id=${book.getId()}"><i class='bx bu bxs-home bx-sm'></i></a>
                <br><a data-affect="#"><i class='bx bu bx-font-family bx-sm' onClick="Show()"></i></a>
                <br><a href="#"><i class='bx bu bx-info-circle bx-sm'></i></a>
                <br><a href="#"><i class='bx  bx-chevrons-right bx-sm'></i></a>
            </section>

            <!-- Main -->
            <div id="main">
                <h1 style="text-align: center">${book.getTitle()}</h1>
                <h2 style="text-align: center">Chapter: ${cid}</h2>
                <h3 style="text-align: center"></h3>
                <c:forEach items="${listr}" var="listr">
                    <p style="margin-left: 80px; margin-right: 100px; text-align: justify">${listr.getContent()}</p>
                </c:forEach>
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
                        <li> HLV </li>
                    </ul>
                </div>
            </footer>

        </div>
        <style>
            .bx{
                border-bottom: 1px solid #ccc;
                border-left: 1px solid #ccc;
                border-right: 1px solid #ccc;
                padding: 15px 15px;
            }
            
            .btm{
                border-top: 1px solid #ccc;
            }
            
            .side_option{
                position: fixed;
                bottom: 30px;
                right: 30px;
            }
            


	

        </style>
        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>