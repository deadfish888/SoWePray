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
        <link rel="stylesheet" href="assets/css/font-awesome.min.css" />
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
                                <h4 class="mb-0">Type</h4>
                                <div class="form-group mb-3 col-3">
                                    <select id="inputState" name="type" class="form-control" >
                                        <option value="all">All</option>
                                        <option value="book" selected>Our Book</option>
                                        <option value="novel">Original Novel</option>
                                    </select>
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
                            <div class="col-3" style="z-index: 1; position: relative; display: inline-block">
                                <select id="sapxep" onchange="sapxep(this)">
                                    <option value="latest">Latest Updated</option>
                                    <option value="fav">Favorite</option>
                                    <option value="view">View</option>
                                    <option value="rate">Rating</option>
                                    <option value="price">Price</option>
                                </select>
                            </div>
                            <div class="col-2" style="z-index: 1; position: relative;display: inline-block;margin-left: 55%">
                                <select id="pageSize" onchange="dsize(this)">
                                    <option value="12">12</option>
                                    <option value="16">16</option>
                                    <option value="20">20</option>
                                    <option value="24">24</option>
                                    <option value="30">30</option>
                                </select>
                            </div>
                            <section class="tiles">
                                <c:forEach items="${books}" var="book">
                                    <article id="bootstrap-overrides" class="style1" style="">
                                        <span class="image">
                                            <img src="${(!empty book.image)?book.image:"images/novel-sample.png"}" alt="" style="height: 230px;"/>
                                        </span>
                                        <a href="BookDetail?id=${book.id}" alt="${book.title}">
                                            <h2 style="overflow: hidden;text-overflow: ellipsis;font-size: 0.85em;">${book.title}</h2>
                                            <h3 style="font-size: 0.7em;"><i>${book.author.name}</i></h3>
                                                    <c:if test="${book.author.userId == 0}">
                                                        <c:if test="${book.issale()}">
                                                    <p>
                                                        <del>$${book.getPrice()}</del> 
                                                        <strong>$${5.00}</strong>
                                                    </p>
                                                </c:if>
                                                <c:if test="${!book.issale()}">
                                                    <p><strong>$${book.getPrice()}</strong></p>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${ book.author.userId != 0}">
                                                <c:if test="${book.issale()}">
                                                    <p>
                                                        <strong>$${book.getPrice()}</strong>
                                                    </p>
                                                </c:if>
                                            </c:if>
                                        </a>
                                    </article>
                                </c:forEach>
                            </section>
                            <div class="${numPage <= 1 ? "hidden" : ""}" style="margin-left: 40%">
                                <ul class="pagination">
                                    <li class="page-item pl-0" >
                                        <a href="Book?page=${1}" class="page-link" data="${1}"
                                           style="${page<3?"display:none":""}">
                                            <i class="fa fa-angle-double-left" aria-hidden="true" ></i>
                                        </a>
                                    </li>
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
                                    <li class="page-item pl-0" >
                                        <a href="Book?page=${numPage}" class="page-link" data="${numPage}"
                                           style="${page+2>numPage?"display:none":""}">
                                            <i class="fa fa-angle-double-right" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-3">

                            <div class="font-medium bg-white border py-2 px-3 mb-3">
                                <h3 class="section-title">Type</h3><!-- comment -->
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item" style="padding: 0.2rem 1rem;">
                                        <a href="./Book?type=all" class="page-link-type" data="all">All</a>
                                    </li>
                                    <li class="list-group-item" style="padding: 0.2rem 1rem;">
                                        <a href="./Book?type=book" class="page-link-type" data="book">Our Book</a>
                                    </li>
                                    <li class="list-group-item" style="padding: 0.2rem 1rem;">
                                        <a href="./Book?type=novel" class="page-link-type" data="novel">Original Novel</a>
                                    </li>
                                </ul>
                            </div>
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
            function setCookie(cname, cvalue, exdays) {
                        const d = new Date();
                        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
                        let expires = "expires=" + d.toUTCString();
                        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
                    }

                    function getCookie(cname) {
                        let name = cname + "=";
                        let ca = document.cookie.split(';');
                        for (let i = 0; i < ca.length; i++) {
                            let c = ca[i];
                            while (c.charAt(0) == ' ') {
                                c = c.substring(1);
                            }
                            if (c.indexOf(name) == 0) {
                                return c.substring(name.length, c.length);
                            }
                        }
                        return "";
                    }
                                    const url_string = window.location.href;
                                    const url = new URL(url_string);
                                    var qtype = url.searchParams.get("type");
                                    const paginationLinks = document.querySelectorAll(".page-link");
                                    var search = location.search.substring(1);
                                    if (paginationLinks) {
                                        paginationLinks.forEach(item => {
                                            const params = new URLSearchParams(search);
                                            const page = item.getAttribute("data");
                                            params.set('page', page);
                                            const href = new URLSearchParams(params).toString();
                                            item.setAttribute("href", "?" + href);
                                        });
                                    }
                                    const typeLinks = document.querySelectorAll(".page-link-type");
                                    if (typeLinks) {
                                        typeLinks.forEach(item => {
                                            const params = new URLSearchParams(search);
                                            const type = item.getAttribute("data");
                                            params.set('type', type);
                                            params.delete('page');
                                            const href = params.toString();
                                            item.setAttribute("href", "?" + href);
                                            if (qtype == null)
                                                qtype = "book";
                                            if (qtype == type) {
                                                item.style.fontWeight = "900";
                                            }
                                        });
                                    }
                                    function sapxep(elm) {
                                        const params = new URLSearchParams(search);
                                        const type = elm.value;
                                        params.set('order', type);
                                        const href = new URLSearchParams(params).toString();
                                        window.location = "Book?" + href;
                                    }
                                    var sapxep_t = url.searchParams.get("order");
                                    if (sapxep_t !=null){
                                        $('#sapxep option').filter(function () {
                                        return $(this).val().indexOf(sapxep_t) != -1;
                                    }).attr('selected', true);
                                    }
                                    var pageSize = getCookie("pageSize") || "16";
                                     $('#pageSize option').filter(function () {
                                        return $(this).val().indexOf(pageSize) != -1;
                                    }).attr('selected', true);
                                    function dsize(elm){
                                        setCookie("pageSize",elm.value,365);
                                        location.reload();
                                    }
                                    
        </script>
    </body>
</html>

