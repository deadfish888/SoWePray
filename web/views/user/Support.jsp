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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>Support</title>
    </head>
    <body>
        <div class = "wrapper">

            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="../images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item ">
                        <a href="./Profile">My Profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Novels">My Novels</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Payment">Payment</a>
                    </li>
                    <li class="active sidebar-item">
                        Support
                    </li>
                </ul>   
            </nav>
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


                <div id="userInfo" class="text-center" >
                    <div>
                        <span class="m-0" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-book" style="margin-right:0.5em;">  Books</span><br/>
                            ${requestScope.bookCount}
                        </span>
                        <span class="m-0 border-left border-right" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-heart" style="margin-right:0.5em;">  Favorites</span><br/>
                            ${requestScope.favorCount}
                        </span>
                        <span class="m-0" style="padding: 0 2em; display: inline-block">
                            <span class="fas fa-pen-nib" style="margin-right:0.5em;">  Creations</span><br/>

                            ${requestScope.novelCount}
                        </span>
                    </div>
                </div>

                <div class="bookshelf col-md-10 m-auto" id="bookshelf">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link <c:if test="${tab eq 'books'}">active</c:if>" data-toggle="tab" href="#book">My books</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <c:if test="${tab eq 'favorites'}">active</c:if>" data-toggle="tab" href="#favorite">My favorite books</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <c:if test="${tab eq 'novels'}">active</c:if>" data-toggle="tab" href="#creation">My creations</a>
                            </li>
                        </ul>

                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane container <c:if test="${tab eq 'books'}">active</c:if> <c:if test="${tab ne 'books'}">fade</c:if>" id="book">
                                <br><!-- comment -->
                                <section class="tiles m-0">
                                    <div class="container border rounded py-3">
                                        <h3 class="section-title">Ticket </h3>
                                        <div class="table-responsive">
                                            <form action="" method="post">
                                                <div class="form-group row col-12">
                                                    <label for="exampleSelect1" class="col-sm-2 col-form-label">Title</label>
                                                    <div class="col-sm-10">
                                                        <input class="form-control" type="text" name="title" required value="">
                                                    </div>
                                                </div>

                                                <div class="form-group row col-12">
                                                    <label class="col-sm-2 col-form-label">Category</label>
                                                    <div class="col-sm-10">
                                                        <div class="row">
                                                             
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group row col-12">
                                                    <label class="col-sm-2 col-form-label">Summary</label>
                                                    <div class="col-sm-10">
                                                        <textarea class="form-control" name="description" style="white-space: pre-line;min-height: 10em" rows="5">${book.getDescription()}</textarea>
                                                    </div>
                                                </div>
                                                <div class="form-group row col-12">
                                                    <label class="col-sm-2 col-form-label" >Image</label>
                                                    <div class="col-sm-10">
                                                        <input class="form-control" type="text" name="image" }">
                                                        <input name="proimage" id="image" value="" type="hidden" >
                                                        <img  src="" id="demoimg" style="margin-top: 5px;" height="100">
                                                    </div>
                                                </div>
                                                <div class="row col-12">
                                                    <div class="col-2"> 
                                                        <input class="btn ${service=="Create"?"btn-primary":"btn-success"}" name="in" type="submit" value="hehx`">
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                            </section>

                            
                        </div>
                        <div class="tab-pane container <c:if test="${tab eq 'favorites'}">active</c:if> <c:if test="${tab ne 'favorites'}">fade</c:if>" id="favorite">
                                <section class="tiles m-0">
                                <c:forEach items="${favorList}" var="book">
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

                            <div class="${favorTotalPage <= 1 ? "hidden" : ""}" style="margin-left: 40%">
                                <ul class="pagination">
                                    <li class="page-item pl-0" >
                                        <a href="?favorPage=${favorPageIndex-1}" class="page-link" data="${favorPageIndex-1}"
                                           style="${favorPageIndex<3?"display:none":""}">
                                            <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="${1}" end="${favorTotalPage}" var="item">
                                        <li class=" page-item ${item==favorPageIndex?"active":""} pl-0">
                                            <a href="?favorPage=${item}" class="page-link" data="${item}"
                                               style="${(favorPageIndex-1>item || favorPageIndex+1<item ) ?"display:none;":""}"
                                               >${item}</a></li>
                                        </c:forEach>
                                    <li class="page-item pl-0">
                                        <a href="?favorPage=${favorPageIndex+1}" class="page-link" data="${favorPageIndex+1}"
                                           style="${favorPageIndex+2>favorTotalPage?"display:none":""}">
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-pane container <c:if test="${tab eq 'novels'}">active</c:if> <c:if test="${tab ne 'novels'}">fade</c:if>" id="creation">
                                <section class="tiles m-0">
                                <c:forEach items="${novelList}" var="book">
                                    <article id="bootstrap-overrides" class="style1" style="width: 170px; margin: 2em; display: inline-block">
                                        <span class="image">
                                            <img src="${(!empty book.getImage())?book.image:"../images/novel-sample.png"}" alt="" style="height: 230px;"/>
                                        </span>
                                        <a href="../BookDetail?id=${book.id}" alt="${book.title}">
                                            <h2 style="overflow: hidden;text-overflow: ellipsis;font-size: 0.85em;">${book.title}</h2>
                                            <h3 style="font-size: 0.7em;"><i>${book.author.name}</i></h3>
                                        </a>
                                    </article>
                                </c:forEach>
                            </section>

                            <div class="${novelTotalPage <= 1 ? "hidden" : ""}" style="margin-left: 40%">
                                <ul class="pagination">
                                    <li class="page-item pl-0" >
                                        <a href="./Bookshelf#creation?novelPage=${novelPageIndex-1}" class="page-link" data="${novelPageIndex-1}"
                                           style="${novelPageIndex<3?"display:none":""}">
                                            <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                    <c:forEach begin="${1}" end="${novelTotalPage}" var="item">
                                        <li class=" page-item ${item==novelPageIndex?"active":""} pl-0">
                                            <a href="./Bookshelf#creation?novelPage=${item}" class="page-link" data="${item}"
                                               style="${(novelPageIndex-1>item || novelPageIndex+1<item ) ?"display:none;":""}"
                                               >${item}</a></li>
                                        </c:forEach>
                                    <li class="page-item pl-0">
                                        <a href="./Bookshelf#creation?novelPage=${novelPageIndex+1}" class="page-link" data="${novelPageIndex+1}"
                                           style="${novelPageIndex+2>novelTotalPage?"display:none":""}">
                                            <i class="fa fa-angle-right" aria-hidden="true"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>

                <!--                <div id="bookshelf" class="col-11 tabs p-0" style="margin:auto;margin-top: 20px;">
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
             Tam thoi de trong menu 
        </div>
        <input type="radio" id="tabNovel" name="tabs">
        <label for="tabNovel">My creations</label>
        <div id="myNovel" class="tab" style="border:solid 2px">

        </div>

    </div>

</div>-->
            </div>
        </div>

        <!-- Scripts -->

        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/jquery.scrolly.min.js"></script>
        <script src="../assets/js/jquery.scrollex.min.js"></script>
        <script src="../assets/js/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>

        <script>
//                const url_string = window.location.href;
//                const url = new URL(url_string);
//                const search = url.searchParams.get("search");
//                const paginationLinks = document.querySelectorAll(".page-link");
//                if (paginationLinks) {
//                    paginationLinks.forEach(item => {
//                        var search = location.search.substring(1);
//                        const params = search ? JSON.parse('{"' + decodeURI(search).replace(/"/g, '\\"')
//                                .replace(/&/g, '","').replace(/=/g, '":"') + '"}') : {};
//                        const page = item.getAttribute("data");
//                        params.page = page;
//                        const href = new URLSearchParams(params).toString();
//                        item.setAttribute("href", "?" + href);
//                    });
//                }
//                const params1 = new URLSearchParams('abc=foo&def=%5Basf%5D&xyz=5&def=dude');
//                console.log(params1.toString());
        </script>
    </body>
</html>
