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
        <title>Library</title>
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
                width: calc(20% - 2.5em);
                margin: 4em 0 0 4em;
            }
            .section-title{
                background-color: #f5f5f5;
                border: 1px solid #d4dae2;
                border-radius: 4px;
                display: inline-block;
                padding: 4px 10px;
                margin-bottom: 0;
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
                    <h1>Library</h1>
                    <div class="image main">
                        <img
                            src="images/banner-image-6-1920x500.jpg"
                            class="img-fluid"
                            alt=""
                            />
                    </div>
                    <form action="Book" method="get">
                        <div class="mb-3 mt-0 col-10 row" style="margin:0 auto;">
                            <div class="col-10">
                            <input name="search" class="form-control" type="text" placeholder="Search by Title" aria-label="Search">
                            </div>
                            <div class="col-2">
                                <input type="submit" value="Search">
                            </div>
                        </div>
                        <p  class="text-right">
                            <a data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                                <i class="fa fa-filter"></i> Advanced Search
                            </a>
                        </p>
                        <div class="collapse" id="collapseExample">
                            <div class="card card-body">
                                <h4 class="mb-0">Author</h4>
                                <div class="mb-3 col-3">
                                    <input type="text" class="form-control" name="author" placeholder="Can be left blank...">
                                </div>
                                <h4>Genre</h4>
                                <div class="row">
                                <c:forEach items="${categories}" var="category">
                                    <div class="form-check form-check-inline col-3 mx-0" >
                                        <input name="categoryId" class="form-check-input" type="checkbox" id="inlineCheckbox${category.id}" value="${category.id}">
                                        <label class="form-check-label" for="inlineCheckbox${category.id}">${category.name}</label>
                                    </div>
                                </c:forEach> 
                                </div>
                            </div>
                        </div>
                    </form>
                    <!-- Products -->
                    <div class="row">
                        <div class="col-9">
                            <section class="tiles">
                                <c:forEach items="${books}" var="book">
                                    <article id="bootstrap-overrides" class="style1" style="">
                                        <span class="image">
                                            <img src="${book.getImage()}" alt="" style="height: 230px;"/>
                                        </span>
                                        <a href="BookDetail?id=${book.id}" alt="${book.title}">
                                            <h2 style="overflow: hidden;text-overflow: ellipsis;font-size: 0.85em;">${book.title}</h2>
                                            <h3 style="font-size: 0.7em;"><i>${book.author.name}</i></h3>
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
                            <div class="${numPage <= 1 ? "hidden" : ""}" style="margin-left: 40%">
                                <ul class="pagination">
                                    <li class="page-item pl-0" >
                                        <a href="Book?page=${page-1}" class="page-link" data="${page-1}"
                                           style="${page<3?"display:none":""}">
                                            <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="${1}" end="${numPage}" var="item">
                                        <li class=" page-item ${item==page?"active":""} pl-0">
                                            <a href="Book?page=${item}" class="page-link " data="${item}"
                                               style="${(page-1>item || page+1<item ) ?"display:none;":""}"
                                               >${item}</a></li>
                                        </c:forEach>
                                    <li class="page-item pl-0">
                                        <a href="Book?page=${page+1}" class="page-link " data="${page+1}"
                                           style="${page+2>numPage?"display:none":""}">
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-3">

                            <div class="font-medium bg-white border py-2 px-3">
                                <h3 class="section-title">Genre</h3>
                                <div>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item" style="padding: 0.2rem 1rem;">
                                            <a href="./Book" class="">
                                                All
                                            </a>
                                        </li>
                                        <c:forEach items="${categories}" var="category">
                                            <li class="list-group-item" style="padding: 0.2rem 1rem;">
                                                <a href="./Book?categoryId=${category.id}" class="">
                                                    ${category.name}
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

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
        <script>
            const paginationLinks = document.querySelectorAll(".page-link");
            if (paginationLinks) {
                paginationLinks.forEach(item => {
                    var search = location.search.substring(1);
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

