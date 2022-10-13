<%-- 
    Document   : Bookshelf
    Created on : Oct 13, 2022, 9:03:38 PM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<script src="../assets/js/ProfileScript.js" type="text/javascript"></script>-->
        <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
        <style>
            .tabs {
                /*border-top-right-radius: 10px;*/
                display: flex;
                /*background: #e2e2e2;*/
                flex-wrap: wrap;
            }
            input[type="checkbox"] + label:before, input[type="radio"] + label:before {
                display: none;
            }
            input[type="checkbox"] + label, input[type="radio"] + label {
                padding: 0.5em 2em;
                border-bottom: 0;
                color: #fff;
            }
            .tabs input[type="radio"] {
                display: none;
            }
            .tabs label {
                margin: 0;
                padding: 15px;
                border-bottom: 0;
                background: #585858;
                font-weight: bold;
                text-align: center;
            }

            .tabs label:last-of-type {
                border-top-right-radius: 10px;
            }
            .tabs label:first-of-type {
                border-top-left-radius: 10px;
            }

            .tabs .tab {
                width: 100%;
                padding: 20px 0 0 20px;
                background: #fff;
                order: 1;
                display: none;
            }
            .tabs .tab h2 {
                font-size: 3em;
            }

            .tabs input[type='radio']:checked + label + .tab {
                display: block;
            }

            .tabs input[type="radio"]:checked + label {
                /*border-top-right-radius: 10px;*/
                border: 2px solid;
                font-weight: bold;
                border-bottom: 0;
                color: #585858;
                background: #fff;
            }
        </style>
    </head>
    <body>
        <div class = "wrapper">

            <div class="col-md-12" style="display: block">
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

                <div id="userInfo" class="text-center">
                    <img src="../images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="User avatar" style="border:2px solid #fff; display: block; margin: auto">
                    <div>
                        ${sessionScope.user.username}
                    </div>
                    <div>
                        <span class="m-0" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-book" style="margin-right:0.5em;">  Books</span><br/>
                            ${requestScope.bookList.size()}
                        </span>
                        <span class="m-0 border-left border-right" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-heart" style="margin-right:0.5em;">  Favorites</span><br/>
                            ${requestScope.favorCount}
                        </span>
                        <span class="m-0" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-pen-nib" style="margin-right:0.5em;">  Creations</span><br/>

                            ${requestScope.novelList.size()}
                        </span>
                    </div>
                </div>

                <div id="bookshelf" class="col-11 tabs p-0" style="margin:auto;margin-top: 20px;">
                    <input type="radio" id="tabBook" name="tabs" checked="checked">
                    <label for="tabBook">My books</label>
                    <div id="myBook" class="tab" style="border:solid 2px">
                        <section class="tiles">
                            <c:forEach items="${bookList}" var="book">
                                <article id="bootstrap-overrides" class="style1" style="width: 170px; margin: 2em; display: inline-block">
                                    <span class="image">
                                        <img src="${book.getImage()}" alt="" style="height: 230px;"/>
                                    </span>
                                    <a href="../BookDetail?id=${book.id}" alt="${book.title}">
                                        <h2 style="overflow: hidden;text-overflow: ellipsis;font-size: 0.85em;">${book.title}</h2>
                                        <h3 style="font-size: 0.7em;"><i>${book.author.name}</i></h3>

                                    </a>
                                </article>
                            </c:forEach>
                        </section>
                    </div>
                    <input type="radio" id="tabFavor" name="tabs">
                    <label for="tabFavor">My favorite books</label>
                    <div id="myFavor" class="tab" style="border:solid 2px;">
                        <!-- Tam thoi de trong menu -->
                    </div>
                    <input type="radio" id="tabNovel" name="tabs">
                    <label for="tabNovel">My creations</label>
                    <div id="myNovel" class="tab" style="border:solid 2px">

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
            const url_string = window.location.href;
            const url = new URL(url_string);
            const search = url.searchParams.get("search");
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
            const params1 = new URLSearchParams('abc=foo&def=%5Basf%5D&xyz=5&def=dude');
            console.log(params1.toString());
        </script>
    </body>
</html>
