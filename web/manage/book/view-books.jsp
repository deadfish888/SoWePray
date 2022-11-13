<%-- 
    Document   : book
    Created on : Sep 22, 2022, 10:48:25 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="Model.*"%>
<%@page import="context.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book Management</title>
        <link rel="stylesheet" href="/Bookie/manage/html/css/style.min.css">


    </head>

    <body>
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->
        <div class="preloader">
            <div class="lds-ripple">
                <div class="lds-pos"></div>
                <div class="lds-pos"></div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
             data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
            <!-- Topbar header - style you can find in pages.scss -->
            <jsp:include page="/manage/base/header.jsp"/>
            <!-- Left Sidebar - style you can find in sidebar.scss  -->
            <jsp:include page="/manage/base/sidebar.jsp"/>
            <!-- ============================================================== -->
            <!-- End Left Sidebar - style you can find in sidebar.scss  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Page wrapper  -->
            <!-- ============================================================== -->
            <div class="page-wrapper">
                <!-- ============================================================== -->
                <!-- Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <div class="page-breadcrumb">
                    <div class="row align-items-center">
                        <div class="col-md-6 col-8 align-self-center">
                            <h3 class="page-title mb-0 p-0">Book Management</h3>
                            <div class="d-flex align-items-center">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/Bookie/Home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Book Management</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                        <!--                        <div class="col-md-6 col-4 align-self-center">
                                                    <div class="text-end upgrade-btn">
                                                        <a href="https://www.wrappixel.com/templates/materialpro/"
                                                           class="btn btn-danger d-none d-md-inline-block text-white" target="_blank">Upgrade to
                                                            Pro</a>
                                                    </div>
                                                </div>-->
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End Bread crumb and right sidebar toggle -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Container fluid  -->
                <!-- ============================================================== -->
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- Column -->
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Books List</h4>
                                <div class="col-12">	
                                    <form id="frm" action="./Book" method="get">
                                        <div class="row col-12">
                                            <div class="col-2"><!-- comment -->
                                                <div class="left-filter">
                                                    <a class="btn btn-purple" href="./AddBook">Add Book</a>
                                                </div>
                                            </div>
                                            <div class="col-2 ms-auto">
                                                <select class="form-select" name="genreId" style="display: inline; width: 150px;" onchange="genre()">
                                                    <option id="opt1" value="">All</option>
                                                    <c:forEach items="${categories}" var="item">
                                                        <option value="${item.id}">${item.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-4">
                                                <input name="search" class="form-control" type="text" placeholder="Search by Title" aria-label="Search">
                                            </div>
                                            <div class="col-2">
                                                <div class="btn-group" role="group" onclick="typeB()">
                                                    <input type="radio" class="btn-check" name="type" id="btnradio1" autocomplete="off" value="book" checked>
                                                    <label class="btn btn-outline-primary" for="btnradio1">Book</label>

                                                    <input type="radio" class="btn-check" name="type" id="btnradio2" autocomplete="off" value="novel">
                                                    <label class="btn btn-outline-primary" for="btnradio2">Novel</label>

                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-3" style="z-index: 1; position: relative; display: inline-block">
                                    <select id="sapxep" onchange="sapxep(this)">
                                        <option value="latest">Latest Updated</option>
                                        <option value="fav">Favorite</option>
                                        <option value="view">View</option>
                                        <option value="rate">Rating</option>
                                        <option value="price">Price</option>
                                    </select>
                                </div>
                                <div class="table-responsive">
                                    <table class="table user-table " id="tablepro">
                                        <thead>
                                            <tr style="cursor: pointer; font-size: 15px;  text-align: center;">
                                                <th>ID</th>
                                                <th>Title</th>
                                                <th>Author</th>
                                                <th style="width: 150px;">Image</th>
                                                <th>Genre</th>
                                                <th>View</th>
                                                <th style="width: 100px;">Price</th>
                                                <th>Update</th>
                                                <th>TOC</th>
                                                <th>Enable</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="book" items="${books}">
                                                <tr>
                                                    <td><a href="./BookDetail?id=${book.id}">${book.id}</a></td>
                                                    <td>${book.title}
                                                        <br><i class="fa fa-star"></i>${book.rating}
                                                        <br><i class="fa fa-eye"></i>${book.views}
                                                    </td>
                                                    <td>${book.author.name}</td>
                                                    <td style="width: 150px;"><img  src="${!empty book.image?book.image:"../images/novel-sample.png"}" width="100px"></td>
                                                    <td>
                                                        <c:forEach items="${book.category}" var="category">
                                                            <span class="badge rounded-pill bg-secondary" style="font-size: 80%;font-weight: 400;">${category.name}</span>
                                                        </c:forEach>
                                                    </td>
                                                    <td>${book.views}</td>
                                                    <td>$${book.getPrice()}<br>${book.issale()?"In sale":""}</td>
                                                    <td>
                                                            <a class="btn btn-primary" href="./UpdateBook?id=${book.id}" ${book.author.userId!=0? "hidden":""}><i class="fa fa-pen-square" aria-hidden="true"></i></a>
                                                        </td>
                                                    <td><a class="btn btn-secondary" href="./Book/TOC?id=${book.id}"><i class="fa fa-angle-right" aria-hidden="true"></i></a></td>
                                                    <td>
                                                        <form action="./ChangeStatus" method="get">
                                                            <input  type="hidden" name="id" value="${book.id}">
                                                            <a><button class="btn ${book.status()?"btn-danger":"btn-primary"}" type="submit">
                                                                    <i class="fa-solid ${book.status()?"fa-ban":"fa-up-long"}"></i>
                                                                </button>
                                                            </a>

                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="sp" class="pagination-arena " style="margin-left: 40%">
                                    <ul class="pagination">
                                        <li class="page-item" >
                                            <a href="Book?page=${1}" class="page-link" data="${1}"
                                               style="${page<3?"display:none":""}">
                                                <i class="fa fa-angle-double-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <li class="page-item" >
                                            <a href="Book?page=${page-1}" class="page-link" style="${page<3?"display:none":""}"
                                               data="${page-1}">
                                                <i class="fa fa-angle-left" aria-hidden="true" ></i>
                                            </a>
                                        </li>
                                        <c:forEach begin="${1}" end="${numPage}" var="item">
                                            <li class="page-item ${item==page?"active":""}">
                                                <a href="Book?page=${item}" data="${item}"
                                                   class="page-link " style="${(page-1>item || page+1<item ) ?"display:none;":""}"
                                                   >${item}</a></li>
                                            </c:forEach>
                                        <li >
                                            <a href="Book?xpage=${page+1}" data="${page+1}"
                                               class="page-link" style="${page+2>numPage?"display:none":""}">
                                                <i class="fa fa-angle-right" aria-hidden="true"  ></i>
                                            </a>
                                        </li>
                                        <li class="page-item" >
                                        <a href="Book?page=${numPage}" class="page-link" data="${numPage}"
                                           style="${page+2>numPage?"display:none":""}">
                                            <i class="fa fa-angle-double-right" aria-hidden="true" ></i>
                                        </a>
                                    </li>
                                    </ul>
                                </div> 
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                <!-- ============================================================== -->
            </div>
            <!-- End Container fluid  -->
            <!-- footer -->
            <footer class="footer">                                 
                <span class="fa fa-github"></span>
                <a href="https://github.com/nekon0/SoWePray">Our Project</a> 
            </footer>
            <!-- End footer -->
        </div>
        <!-- End Page wrapper  -->
    </div>
    <!-- End Wrapper -->
    <!-- All Jquery -->
    <script src="https://kit.fontawesome.com/a65741f09b.js" crossorigin="anonymous"></script>
    <script src="/Bookie/manage/assets/plugins/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.js"></script>
    <script src="/Bookie/manage/html/js/app-style-switcher.js"></script>
    <!--Wave Effects -->
    <script src="/Bookie/manage/html/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="/Bookie/manage/html/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="/Bookie/manage/html/js/custom.js"></script>
    <script>
                                        var element = document.getElementById("book-management");
                                        element.classList.add("selected");
                                        element = document.getElementById("book-management-a");
                                        element.classList.add("active");
                                        const url_string = window.location.href;
                                        const url = new URL(url_string);
                                        var search = location.search.substring(1);
                                        var type = url.searchParams.get("type");
                                        if (type == "novel") {
                                            document.getElementById("btnradio2").checked = true;
                                        }
                                        function typeB() {
                                            $("#frm").submit();
                                        }
                                        function sapxep(elm) {
                                            const params = new URLSearchParams(search);
                                            const type = elm.value;
                                            params.set('order', type);
                                            const href = new URLSearchParams(params).toString();
                                            window.location = "Book?" + href;
                                        }
                                        var sapxep_t = url.searchParams.get("order");
                                        if (sapxep_t != null) {
                                            $('#sapxep option').filter(function () {
                                                return $(this).val().indexOf(sapxep_t) != -1;
                                            }).attr('selected', true);
                                        }
                                        const paginationLinks = document.querySelectorAll(".page-link");
                                        if (paginationLinks) {
                                            paginationLinks.forEach(item => {
                                                const params = new URLSearchParams(search);
                                                const page = item.getAttribute("data");
                                                params.set('page', page);
                                                const href = new URLSearchParams(params).toString();
                                                item.setAttribute("href", "?" + href);
                                            });
                                        }
    </script>
</body>

</html>

