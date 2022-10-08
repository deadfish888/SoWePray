<%-- 
    Document   : Favourite
    Created on : Sep 24, 2022, 12:48:07 AM
    Author     : ttaad
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${empty sessionScope.user}">
    <%         
          response.sendRedirect("/Bookie/Home");
    %>
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Favourite</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
        
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
                    <h1>My Favourite</h1>
                    <div class="image main">
                        <img
                            src="images/banner-image-6-1920x500.jpg"
                            class="img-fluid"
                            alt=""
                            />
                    </div>
                    <form action="Favourite" method="GET">
                        <input type="hidden" name="category" value="${category!=null?category:"0"}"> 
                    <div class="md-form active-pink active-pink-2 mb-3 mt-0 col-md-10" style="margin:0 auto;">
                        <input name="search" class="form-control" type="text" placeholder="Search by Title" aria-label="Search">
                    </div>
                    
                    <div class="grid_column-10">
                        <div class="home-filter">
                            <h2>Category</h2>
                        </div>
                        <div class="home-filter">
                            <button name="category"  type="submit" class="primary" value="0" style="overflow:initial;">All</button>
                            <c:forEach items="${category}" var="category">
                                <button name="category" type="submit" class="primary" value="${category.id}">${category.getName()}</button>
                            </c:forEach>
                        </div>
                    </div>
                    </form>
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

                    <!-- Products -->
                    <section class="tiles">
                        <c:forEach items="${books}" var="book">
                            <article id="bootstrap-overrides" class="style1" style="">
                                <span class="image">
                                    <img src="${book.getImage()}" alt="" style="height: 250px;"/>
                                </span>
                                <a href="BookDetail?id=${book.id}" alt="${book.title}">
                                    <h2 style="overflow: hidden;text-overflow: ellipsis;">${book.title}</h2>
                                    <h3 style="font-size: 0.85em;"><i>${book.author.name}</i></h3>
                                            <c:if test="${book.issale()}">
                                        <p>
                                            <del>$${book.getPrice()}</del> 
                                            <strong>$${5.00}</strong>
                                        </p>
                                    </c:if>
                                    <c:if test="${!book.issale()}">
                                        <p><strong>$${book.getPrice()}</strong></p>
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
                                <a href="https://github.com/nekon0/IIBOOK">Our Project</a>
                            </li>
                            <li>
                                <span class="fa fa-map-pin"></span>
                                <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7">
                                    DE336, FBT University</a
                                >
                            </li>
                        </ul>
                    </section>
                    <ul class="copyright">
                        <li>HLV</li>
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
