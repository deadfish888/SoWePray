<%-- 
    Document   : products
    Created on : Jun 15, 2022, 10:56:23 AM
    Author     : ACER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${author.name}'s Works</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
        <style>
                        .home-filter{
                            text-align: center;
                            display: flex;
                            margin: 0 50px;
                        }
                        button{
                            margin: 0 10px;
                        }
                        section #bootstrap-overrides{
                            width: calc(17% - 2.5em);
                                     margin: 4em 0 0 4em;
                        }
        </style>
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
                    <h1>From ${author.name}</h1>
                    <div class="image main">
                        <img
                            src="images/banner-image-6-1920x500.jpg"
                            class="img-fluid"
                            alt=""
                            />
                    </div>
                    <!-- Products -->
                    <section class="tiles">
                            <c:forEach items="${requestScope.bookauthor}" var="bookau">
                                <article class="style1">
                                    <span class="image">
                                        <img src="${bookau.image}" alt="${bookau.image}" style="height: 391px;" />
                                    </span>
                                    <a href="BookDetail?id=${bookau.id}">
                                        <h2>${bookau.title}</h2>

                                        <c:if test="${bookau.issale()}">
                                            <p>
                                                <del>$${bookau.price}</del> 
                                                <strong>$5.00</strong>
                                            </p>
                                        </c:if>
                                        <c:if test="${!bookau.issale()}">
                                            <p><strong>$${bookau.price}</strong></p>
                                        </c:if>
                                    </a>
                                </article>
                            </c:forEach>
                        </section>

                </div>
            </div>
            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li>
                                <span class="fa fa-github"></span>
                                <a href="https://github.com/nekon0/SoWePray">Our Project</a>
                            </li>
                            <li>
                                <span class="fa fa-map-pin"></span>
                                <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7">
                                    DE210, FBT University</a
                                >
                            </li>
                        </ul>
                    </section>
                    <ul class="copyright">
                        <li>Bookie</li>
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
    </body>
</html>