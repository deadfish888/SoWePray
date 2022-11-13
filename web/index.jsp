

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookie</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
                <div
                    id="carouselExampleIndicators"
                    class="carousel slide"
                    data-ride="carousel"
                    >
                    <ol class="carousel-indicators">
                        <li
                            data-target="#carouselExampleIndicators"
                            data-slide-to="0"
                            class="active"
                            ></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-1-1920x700.jpg"
                                alt="First slide"
                                />
                        </div>
                        <div class="carousel-item">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-2-1920x700.jpg"
                                alt="Second slide"
                                />
                        </div>
                        <div class="carousel-item">
                            <img
                                class="d-block w-100"
                                src="images/slider-image-3-1920x700.jpg"
                                alt="Third slide"
                                />
                        </div>
                    </div>
                    <a
                        class="carousel-control-prev"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="prev"
                        >
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a
                        class="carousel-control-next"
                        href="#carouselExampleIndicators"
                        role="button"
                        data-slide="next"
                        >
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>

                <br />
                <br />

                <div class="inner">
                    <!-- About Us -->
                    <header id="inner">
                        <h1>Tell us what book you love</h1>
                        <blockquote>
                            <p>
                                <i
                                    >"Books are the quietest and most constant of friends; they
                                    are the most accessible and wisest of counselors, and the most
                                    patient of teachers."</i
                                >
                            </p>
                            <cite>Charles W. Eliot</cite>
                        </blockquote>
                    </header>

                    <br />

                    <h2 class="h2">Most Favorite</h2>
                    <!-- Products -->
                    <section class="tiles" style="margin-left: 20px">>
                        <c:forEach items="${favebooks}" var="book">
                            <article class="style1">
                                <span class="image">
                                    <img src="${book.image}" alt="" style="height: 391px;"/>
                                </span>
                                <a href="BookDetail?id=${book.id}">
                                    <h2>${book.title}</h2>
                                    <h3 style="font-size: 0.85em;"><i>${book.author.name}</i></h3>
                                            <c:if test="${book.issale()}">
                                        <p>
                                            <del>$${book.price}</del> 
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
                    <p class="text-center">
                        <a href="./Book?order=fav"
                           >More Books &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>

                    <br />
                    <h2 class="h2">In Sales </h2>
                    <!-- Products -->
                    <section class="tiles" style="margin-right: 30px">
                        <div class= "" style = "display: flex ">
                            <c:forEach items="${salebooks}" var="book">
                                <article class="style1">
                                    <span class="image">
                                        <img src="${book.image}" alt="" style="max-height: 391px"/>
                                    </span>
                                    <a href="BookDetail?id=${book.id}">
                                        <h2>${book.title}</h2>
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
                        </div> 
                    </section>
                    <p class="text-center">
                        <a href="./Sale"
                           >More Books &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>

                    <br />
                    <h2 class="h2">Latest Books</h2>
                    <!-- Products -->
                    <section class="tiles" style="margin-left: 15px">

                        <c:forEach items="${allbooks}" var="book">
                            <article class="style1" style="width: calc(17% - 2.5em);
                                     margin: 4em 0 0 4em;">
                                <span class="image">
                                    <img src="${book.getImage()}" alt="" style="height: 250px "/>
                                </span>
                                <a href="BookDetail?id=${book.id}">
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
                    <p class="text-center">
                        <a href="./Book"
                           >More Books &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>

                    <br />

                    <h2 class="h2">Original Novels</h2>
                    <section class="tiles" style="margin-left: 15px">

                        <c:forEach items="${novels}" var="book">
                            <article class="style1" style="width: calc(17% - 2.5em);
                                     margin: 4em 0 0 4em;">
                                <span class="image">
                                    <img src="${(! empty book.image)?book.image:("images/novel-sample.png")}" alt="" style="height: 250px "/>
                                </span>
                                <a href="BookDetail?id=${book.id}">
                                    <h2 style="overflow: hidden;text-overflow: ellipsis;">${book.title}</h2>
                                    <h3 style="font-size: 0.85em;"><i>${book.author.name}</i></h3>
                                            
                                </a>
                            </article>
                        </c:forEach>
                    </section>
                    <p class="text-center">
                        <a href="./Book?type=novel"
                           >Read More &nbsp;<i class="fa fa-long-arrow-right"></i
                            ></a>
                    </p>
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
                                    DE210, FBT University</a>
                            </li>
                            <li>
                                <span class="fa fa-mail-forward"></span>
                                <a href="mailto:vinhnthe163219@fpt.edu.vn">
                                    Our mail</a>
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
