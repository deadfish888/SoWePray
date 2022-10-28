<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Book</title>
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
                    <h1 style="margin: 0 0 0 0;">${book.title}
                        <c:if test="${book.issale()}">
                            <span class="pull-right">
                                <del>$${book.price}</del> 
                                $5.00
                            </span>
                        </c:if> 
                        <c:if test="${!book.issale()}">
                            <span class="pull-right">$${book.price}</span>
                        </c:if>
                    </h1>
                    <c:forEach items="${book.category}" var="category">
                        <h4 style="margin: 0 0 0 0; display: inline-block;"><a href="./Book?categoryId=${category.id}"><span class="badge badge-pill badge-secondary">${category.name}</span></a></h4>
                            </c:forEach>

                    <h2><a href="./Author?id=${book.author.id}"> ${book.author.name}</a> </h2>

                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.image}" class="img-fluid" alt="${book.image}">
                                <form action="BookPreread" method="GET">
                                    <div style ="text-align: center ">
                                        <input type="hidden" name="id" value="${book.id}">
                                        <c:if test="${! empty requestScope.chaps && !requestScope.own}">
                                            <input type="submit" class="primary" value="Preread"> 
                                        </c:if>

                                    </div>
                                </form>
                                <div style="text-align: center;">
                                    <span class="fa fa-eye"></span>
                                    <span class="title">${book.views}</span><br><!-- comment -->
                                    <span class="fa fa-star"></span><span class="title"> ${book.rating}</span>
                                </div>

                            </div>

                            <div class="col-md-7">
                                <p>
                                    ${book.description}
                                </p>
                                <div class="row">        
                                    <c:if test="${sessionScope.user != null}">
                                        <c:if test="${requestScope.own}">
                                            <form action="BookReading" method="get">
                                                <div class="col-sm-4">
                                                    <input type="hidden" name="id" value="${book.id}">
                                                    <input type="submit" class="primary" value="Read">
                                                </div>
                                            </form>
                                        </c:if>
                                        <c:if test="${!own && (book.price ne 0)}">
                                            <div class="col-sm-2">
                                                <input type="button" class="primary btn-primary" data-toggle="modal" data-target="#purchase" value="Buy"/>
                                            </div>
                                        </c:if>
                                        <c:if test="${!own && (book.price eq 0)}">
                                            <form action="User/Purchase" method="get">
                                                <div class="col-sm-4">
                                                    <input type="hidden" name="bookId" value="${book.id}">
                                                    <input type="hidden" name="amount" value="${book.price}">
                                                    <input type="hidden" name="bookTitle" value="${book.title}"/>
                                                    <input type="submit" class="primary" value="Get">
                                                </div>
                                            </form>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sessionScope.user == null}">
                                        <form action="Login" method="GET">
                                            <div class="col-sm-4">
                                                <input type="hidden" name="origin" value="./BookDetail?id=${book.id}">
                                                <input type="submit" class="primary" value="Buy">
                                            </div>
                                        </form>
                                    </c:if>

                                    <div class="modal fade" id="purchase" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <form action="User/Purchase" method="post" id="purchaseForm" name="purchaseForm" onsubmit="return validatePassword()">
                                                    <div class="modal-header">
                                                        <h3 class="modal-title">Purchase</h3>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="wrapper row">
                                                            <table style="width: 80%; margin: auto">
                                                                <tr>
                                                                    <th>
                                                                        Book
                                                                    </th>
                                                                    <td>
                                                                        ${book.title}
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>
                                                                        Price
                                                                    </th>
                                                                    <td>
                                                                        <c:if test="${book.issale()}">
                                                                            $5.00
                                                                        </c:if>
                                                                        <c:if test="${!book.issale()}">
                                                                            ${book.price}
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th>
                                                                        Password
                                                                    </th>
                                                                    <td>
                                                                        <input type="password" name="password"/>
                                                                        <div style="color: red" id="purchase-pass-noti"></div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer" style="text-align: center">
                                                        <button type="button" class="primary btn-primary text-center" data-dismiss="modal" style="width: auto; padding: 0 1em">Cancel</button>
                                                        <input type="hidden" id="pass" value="${sessionScope.user.password}"/>
                                                        <c:if test="${book.issale()}">
                                                            <input type="hidden" name="amount" value="5"/>
                                                        </c:if>
                                                        <c:if test="${!book.issale()}">
                                                            <input type="hidden" name="amount" value="${book.price}"/>

                                                        </c:if>
                                                        <input type="hidden" name="bookId" value="${book.id}"/>
                                                        <input type="hidden" name="bookTitle" value="${book.title}"/>
                                                        <input type="submit" class="primary text-center" value="Confirm"/>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <c:if test="${check==true}">
                                        <form action="Fav" method="POST">
                                            <div class="col-sm-4">
                                                <input type="submit" class="primary" value="Delete Favourite">                                 
                                                <input type="hidden" name="bId" value="${book.getId()}">
                                            </div>
                                        </form>
                                    </c:if> 
                                    <c:if test="${check==false}">
                                        <form action="Favourite" method="POST">
                                            <div class="col-sm-4">
                                                <input type="submit" class="primary" value="Add to Favorite">                                 
                                                <input type="hidden" name="bId" value="${book.getId()}">
                                            </div>
                                        </form>
                                    </c:if>
                                    <form action="Report" method="POST">
                                        <div class="col-sm-4"> 
                                            <input type="submit" class="primary" value="Report">                                 
                                            <input type="hidden" name="bId" value="${book.id}">
                                        </div>   
                                    </form>      
                                </div>

                                <c:choose >
                                    <c:when test="${sessionScope.user!=null}" > 
                                        <div class="row">
                                            <form action="Rating" method="POST">        
                                                <div class="rate">
                                                    <input type="hidden" name="bId" value="${book.id}">
                                                    <input type="radio" id="star5" name="getRate" value="5" />
                                                    <label for="star5" title="text">5</label>
                                                    <input type="radio" id="star4" name="getRate" value="4" />
                                                    <label for="star4" title="text">4</label>
                                                    <input type="radio" id="star3" name="getRate" value="3" />
                                                    <label for="star3" title="text">3</label>
                                                    <input type="radio" id="star2" name="getRate" value="2" />
                                                    <label for="star2" title="text">2</label>
                                                    <input type="radio" id="star1" name="getRate" value="1" />
                                                    <label for="star1" title="text">1</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="submit" class="primary" value="Rate"></div>
                                            </form>   
                                        </div>
                                    </c:when>
                                </c:choose>    
                            </div>

                        </div>           
                    </div>
                    <br>
                    <br>

                    <div class="container-fluid">
                        <h3 class="">Table of Contents</h3>
                        <div class="accordion col-md-7" id="accordionExample">
                            <c:forEach items="${requestScope.vols}" var="vol">
                                <div class="card">
                                    <div class="card-header" id="heading${vol.id}">
                                        <h5 class="mb-0">
                                            <button class="btn btn-link" type="button" 
                                                    data-toggle="collapse" data-target="#collapse${vol.id}" 
                                                    aria-expanded="true" aria-controls="collapse${vol.id}">
                                                ${vol.title}
                                            </button>
                                        </h5>
                                    </div>
                                    <div id="collapse${vol.id}" class="collapse" aria-labelledby="heading${vol.id}" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <c:forEach items="${requestScope.chaps}" var="chap">
                                                <c:if test="${chap.volumeId == vol.id}">
                                                    <c:choose>
                                                        <c:when test="${(! empty sessionScope.user && requestScope.own) || !empty sessionScope.admin}">
                                                            <a href="BookReading?id=${book.id}&cid=${chap.id}"><p><i class="fa fa-unlock"></i> ${chap.title}</p></a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="BookPreread?id=${book.id}"><p><i class="fa fa-lock"></i> ${chap.title}</p></a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>  
                    </div>
                    <div class="container-fluid mt-5">
                        <h3>${(! empty requestScope.comments)? requestScope.comments.size() : "0"} comment(s)</h3>
                        <div class="col-12">
                            <form role="form" action="Comment" method="get">
                                <input type="hidden" name="bookId" value="${book.id}"> 
                                <div class="form-group">
                                    <textarea class="form-control" name="comment" placeholder="Add a comment..."></textarea>
                                </div>
                                <input type="submit" value="Post">
                                
                            </form> 
                            <table class="table">
                                <c:forEach items="${requestScope.comments}" var="comment">

                                    <tr>
                                        <th style="width: 200px" scope="row">
                                            ${comment.user.name}
                                        </th>
                                        <td style="" style="height: 100px"><c:choose>
                                                <c:when test="${comment.status == false}">
                                                    <del>This comment has been banned.<del>
                                                </c:when>
                                                <c:otherwise>${comment.comment}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="" style="height: 100px">
                                            <c:choose>
                                                <c:when test="${!empty sessionScope.admin}">
                                                    <a class="fa fa-times" type="button"  data-bs-toggle="modal" data-bs-target="#staticBackdrop-${comment.id}">
                                                    </a>
                                                    <!-- Modal -->
                                                    <div class="modal" id="staticBackdrop-${comment.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="staticBackdropLabel">CONFIRMATION</h5>
                                                            </div>
                                                            <div class="modal-body">
                                                                <h6>Are you sure to ban this comment?</h6>                                                              
                                                            </div>
                                                            <div class="modal-footer">
                                                                <form method="get" action="./BanComment">
                                                                    <input type="hidden" name="id" value="${comment.id}">
                                                                    <input type="hidden" name="bid" value="${book.id}">
                                                                    <button type="button" data-bs-dismiss="modal" style="background-color: #ffffff; margin-left: 0">Close</button>
                                                                    <button type="submit" style="background-color: #ffffff; margin-right: 0">YES, BAN IT</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <form id="${comment.id}" action="ReportComment" method="get">
                                                        <p><i class="fa fa-flag" aria-hidden="true" onclick="document.getElementById('${comment.id}').submit()"></i></p>
                                                        <!--      <input type="submit" class="primary" display="hidden" value="Report">                          -->
                                                        <input type="hidden" name="bId" value="${book.id}">
                                                        <input type="hidden" name="cId" value="${comment.id}">

                                                    </form>

                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>

                                </c:forEach>
                            </table>
                        </div>
                    </div>

                    <div class="container-fluid mt-5">
                        <h2 class="h2">Similar Products</h2>

                        <!-- Products -->
                        <section class="tiles">
                            <div class= "" style = "display: flex ">
                                <c:forEach items="${requestScope.sames}" var="same">
                                    <article class="style1">
                                        <span class="image">
                                            <img src="${same.image}" alt="${same.image}" style="height: 290px;" />
                                        </span>
                                        <a href="BookDetail?id=${same.id}">
                                            <h2>${same.title}</h2>

                                            <c:if test="${same.issale()}">
                                                <p>
                                                    <del>$${same.price}</del> 
                                                    <strong>$5.00</strong>
                                                </p>
                                            </c:if>
                                            <c:if test="${!same.issale()}">
                                                <p><strong>$${same.price}</strong></p>
                                            </c:if>
                                        </a>
                                    </article>
                                </c:forEach></div>
                        </section>
                    </div>

                </div>
            </div>

            <!-- Footer -->
            <footer id="footer">
                <div class="inner">
                    <section>
                        <h2>Contact Info</h2>
                        <ul class="alt">
                            <li><span class="fa fa-github"></span> <a href="https://github.com/nekon0/SoWePray">Our Project</a></li>
                            <li><span class="fa fa-map-pin"></span> <a href="https://goo.gl/maps/ojwCjTqRteiA4B9U7"> DE336, FBT University</a></li>
                        </ul>
                    </section>

                    <ul class="copyright">
                        <li> HLV </li>
                    </ul>
                </div>
            </footer>

        </div>

        <!-- Scripts -->
        <script src="/Bookie/manage/assets/plugins/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="/Bookie/manage/assets/plugins/bootstrap/dist/js/bootstrap.bundle.js"></script>
       <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>
        
        
        <!--Custom JavaScript -->
        
        
    </body>
</html>