<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${book.title}</title>
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
                        <span class="pull-right"><a href="./Book?type=novel">ORIGINAL</a></span>
                    </h1>

                    <c:forEach items="${book.category}" var="category">
                        <h4 style="margin: 0 0 0 0; display: inline-block;"><a href="./Book?categoryId=${category.id}&type=novel"><span class="badge badge-pill badge-secondary">${category.name}</span></a></h4>
                            </c:forEach>

                    <h2><a href="./Author?id=${book.author.id}"> ${book.author.name}</a> </h2>

                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${(! empty book.image)? book.image : "images/novel-sample.png"}" class="img-fluid" alt="${book.image}">
                                <form action="BookPreread" method="GET">
                                    <div style ="text-align: center ">
                                        <input type="hidden" name="id" value="${book.id}">
                                        <c:if test="${! empty requestScope.chaps && !requestScope.own && sessionScope.user.id ne book.author.userId}">
                                            <input type="submit" class="primary" value="Preread"> 
                                        </c:if>

                                    </div>
                                </form>
                                <div style="text-align: center;">
                                    <span class="fa fa-eye"></span>
                                    <span class="title">${book.views}</span><br><!-- comment -->
                                    <span class="fa fa-star"></span><span class="title"> ${book.rating}</span>
                                    /<span class="title"> ${numrate} </span>ratings
                                    <c:choose >
                                        <c:when test="${sessionScope.user.is_super()>0}" > 
                                            <div class="row" style="margin:auto">
                                                <form id="ratingfrm" action="Rating" method="POST">        
                                                    <div class="rate">
                                                        <input type="hidden" name="bId" value="${book.id}">
                                                        <input type="radio" id="star5" name="getRate" value="5" required/>
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
                                                </form>   
                                            </div>
                                        </c:when>
                                    </c:choose> 
                                </div>

                            </div>

                            <div class="col-md-7">
                                <p>
                                    ${book.description}
                                </p>
                                <div class="row m-3 text-center">
                                    <div class="col-sm-3">
                                        <c:if test="${sessionScope.user != null}">
                                            <c:if test="${requestScope.own || sessionScope.user.id eq book.author.userId}">
                                                <form action="BookReading" method="get">
                                                    <input type="hidden" name="id" value="${book.id}">
                                                    <input type="submit" class="primary" value="Read">
                                                </form>
                                            </c:if>
                                            <c:if test="${!own && (book.issale()) && sessionScope.user.id ne book.author.userId}">
                                                <input type="button" class="primary btn-primary" data-toggle="modal" data-target="#purchase" value="Buy (All)"/>
                                            </c:if>
                                            <c:if test="${!own && (!book.issale()) && sessionScope.user.id ne book.author.userId}">
                                                <form action="User/Purchase" method="get">
                                                    <input type="hidden" name="bookId" value="${book.id}">
                                                    <input type="hidden" name="amount" value="0">
                                                    <input type="hidden" name="bookTitle" value="${book.title}"/>
                                                    <input type="submit" class="primary" value="Get">
                                                </form>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${sessionScope.user == null}">
                                            <form action="Login" method="GET">
                                                <input type="hidden" name="origin" value="./BookDetail?id=${book.id}">
                                                <input type="submit" class="primary" value="Buy">
                                            </form>
                                        </c:if>
                                    </div>
                                    <div class="modal fade" id="purchase" tabindex="-1" role="dialog" aria-hidden="true">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <form action="User/Purchase" method="post" id="purchaseForm" name="purchaseForm" onsubmit="return validatePassword('purchaseForm')">
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
                                                                        ${bookProduct.price}
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
                                                        <input type="hidden" name="amount" value="${bookProduct.price}"/>
                                                        <input type="hidden" name="bookId" value="${book.id}"/>
                                                        <input type="hidden" name="bookTitle" value="${book.title}"/>
                                                        <input type="submit" class="primary text-center" value="Confirm"/>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-3" style="padding: 10px 0">
                                        <c:if test="${check==true}">
                                            <form id="favfrm" action="Fav" method="POST">
                                                <a>
                                                    <i id="fav" class="fa fa-heart" style="font-size: xx-large" ></i>
                                                </a>
                                                <span> ${numfav}</span>                                
                                                <input type="hidden" name="bId" value="${book.getId()}">
                                            </form>
                                        </c:if> 
                                        <c:if test="${check==false}">
                                            <form id="favfrm" action="Favourite" method="POST">
                                                <!--                                                <input type="submit" class="far " value="Add to Favorite">-->
                                                <a>
                                                    <i id="fav" class="fa fa-heart-o " style="font-size: xx-large" ></i>
                                                </a><span> ${numfav}</span>  
                                                <input type="hidden" name="bId" value="${book.getId()}">
                                            </form>
                                        </c:if>
                                    </div>
                                    <div class="col-sm-1" style="padding: 10px 0">                    
                                        <form id="reportfrm" action="Report" method="POST">

                                            <a>
                                                <i id="refav" class="fa fa-warning" style="font-size: xx-large" ></i>
                                            </a>
                                            <input type="hidden" name="bId" value="${book.id}">
                                        </form> 
                                    </div>  
                                </div>

                                <div style="color: red">
                                    ${sessionScope.error}
                                </div>
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
                                            <c:forEach items="${requestScope.chapterProductList}" var="chapProduct">
                                                <c:if test="${chapProduct.chapter.volumeId == vol.id && chapProduct.chapter.isStatus()}">
                                                    <c:choose>
                                                        <c:when test="${!book.issale()}">
                                                            <a href="BookReading?id=${book.id}&cid=${chapProduct.chapter.id}">
                                                                <p><i class="fa fa-unlock"></i> ${chapProduct.chapter.title}</p>
                                                            </a>
                                                        </c:when>
                                                        <c:when test="${!empty sessionScope.admin || (! empty sessionScope.user && (requestScope.own || productOwnList.contains(chapProduct) || !book.issale()) || sessionScope.user.id eq book.author.userId)}">
                                                            <a href="BookReading?id=${book.id}&cid=${chapProduct.chapter.id}">
                                                                <p><i class="fa fa-unlock"></i> ${chapProduct.chapter.title}</p>
                                                            </a>
                                                        </c:when>
                                                        <c:when test="${empty sessionScope.user && empty sessionScope.admin}">
                                                            <a href="Login">
                                                                <p><i class="fa fa-lock"></i> ${chapProduct.chapter.title}</p>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a data-toggle="modal" data-target="#cpurchase${chapProduct.chapter.id}"><p><i class="fa fa-lock"></i> ${chapProduct.chapter.title}</p></a>
                                                            <div class="modal fade" id="cpurchase${chapProduct.chapter.id}" tabindex="-1" role="dialog" aria-hidden="true">
                                                                <div class="modal-dialog modal-lg">
                                                                    <div class="modal-content">
                                                                        <form action="User/PurchaseChapter" method="post" id="cpurchase${chapProduct.chapter.id}Form" name="purchaseForm" onsubmit="return validatePassword('cpurchase${chapProduct.chapter.id}Form')">
                                                                            <div class="modal-header">
                                                                                <h3 class="modal-title">Purchase</h3>
                                                                            </div>
                                                                            <div class="modal-body">
                                                                                <div class="wrapper row">
                                                                                    <table style="width: 80%; margin: auto">
                                                                                        <tr>
                                                                                            <th>
                                                                                                Chapter ${chapProduct.chapter.no}
                                                                                            </th>
                                                                                            <td>
                                                                                                ${chapProduct.chapter.title}
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <th>
                                                                                                Price
                                                                                            </th>
                                                                                            <td>
                                                                                                ${chapProduct.price}
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
                                                                                <input type="hidden" name="amount" value="${chapProduct.price}"/>
                                                                                <input type="hidden" name="productId" value="${chapProduct.productId}"/>
                                                                                <input type="submit" class="primary text-center" value="Confirm"/>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
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
                            <table class="table" style="margin-top: 10px">
                                <style>
                                    form {
                                        margin-bottom: 0px;
                                    }
                                    table{
                                        margin-bottom: 0px;
                                    }
                                    p{
                                        margin-bottom: 5px;
                                    }
                                    #bootstrap-overrides{
                                        font-size: 0.8em;
                                        font-weight: 900;
                                        height: 3.5em;
                                        letter-spacing: 0.35em;
                                        line-height: 3.45em;
                                        overflow: hidden;
                                        padding: 0 1.25em 0 1.6em;
                                        text-align: center;
                                        text-decoration: none;
                                        text-overflow: ellipsis;
                                        text-transform: uppercase;
                                        white-space: nowrap;
                                        width: auto;
                                    }
                                    .current{
                                        border-left: 2px #585858 ridge;
                                    }
                                </style>
                                <c:forEach items="${requestScope.comments}" var="comment">

                                    <c:if test="${comment.getSonOf()==0}">       
                                        <tr id="cmt${comment.id}">
                                            <th style="width: 200px" scope="row">
                                                ${comment.user.name}
                                            </th>
                                            <td >
                                                <c:choose>
                                                    <c:when test="${comment.isStatus() == false}">
                                                        <i>This comment has been banned.</i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p style="white-space: pre-line">${comment.comment}</p>
                                                        <div class="row">
                                                            <div class="col-md-3 small">
                                                                <c:if test="${comment.getEditedAt()==null}">${comment.getCreatedAt()}</c:if>
                                                                <c:if test="${comment.getEditedAt()!=null}">Edited ${comment.getEditedAt()}</c:if>
                                                                </div>                                
                                                            <c:if test="${comment.getUserId()!=sessionScope.user.getId()}">
                                                                <div class ="col-md-3 small">
                                                                    <a class="visible-toolkit-item do-reply" href="#ReplyComment${comment.getId()}" data-toggle="collapse"
                                                                       aria-expanded="false" aria-controls="Reply">Reply</a>
                                                                </div>

                                                                <div class="collapse col-12" id="ReplyComment${comment.getId()}">
                                                                    <form action="Reply" method="get">
                                                                        <input type="text" class="form-control" name="reply" ${empty sessionScope.user ? "":"required"}/>
                                                                        <input type="submit" value="Reply">
                                                                        <input type="hidden" id="sId" name="sId" value="${comment.getId()}"> 
                                                                        <input type="hidden" id="rId" name="rId" value="${comment.getId()}"> 
                                                                        <input type="hidden" id="uId" name="uId" value="${sessionScope.user.getId()}">
                                                                        <input type="hidden" id="bId" name="bId" value="${requestScope.book.id}">
                                                                    </form>
                                                                </div>   
                                                            </c:if>
                                                            <c:if test="${comment.getUserId()==sessionScope.user.getId()}">
                                                                <div class="col-md-1 small">
                                                                    <a class="visible-toolkit-item do-reply" href="#EditComment${comment.getId()}" data-toggle="collapse"
                                                                       aria-expanded="false" aria-controls="EditComment">Edit</a>
                                                                </div>
                                                                <div class="col-md-2 small">
                                                                    <a class="visible-toolkit-item do-reply" data-toggle="modal" data-target="#DeleteComment${comment.getId()}">Delete</a>
                                                                </div>

                                                                <div class="collapse col-12" id="EditComment${comment.getId()}">
                                                                    <form action="Update" method="get">
                                                                        <input type="text" class="form-control" name="newComment"/>
                                                                        <input type="submit" value="Edit">
                                                                        <input type="hidden" id="cId" name="cId" value="${comment.getId()}"> 
                                                                        <input type="hidden" id="uId" name="uId" value="${sessionScope.user.getId()}">
                                                                        <input type="hidden" id="bId" name="bId" value="${requestScope.book.id}">
                                                                    </form>
                                                                </div>
                                                                <form method="post" action="Update">
                                                                    <input type="hidden" name="bId" value="${requestScope.book.id}"/>
                                                                    <input type="hidden" name="uId" value="${sessionScope.user.id}"/>
                                                                    <input type="hidden" name="cId" value="${comment.getId()}">
                                                                    <div class="modal fade" id="DeleteComment${comment.getId()}" tabindex="-1" 
                                                                         role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                                                            <div class="modal-content">
                                                                                <div class="modal-header">
                                                                                    <h5 class="modal-title" id="exampleModalCenterTitle">Alert</h5>
                                                                                </div>
                                                                                <div class="modal-body">
                                                                                    Delete this comment ... ?
                                                                                </div>
                                                                                <div class="modal-footer">
                                                                                    <button type="button" id="bootstrap-overrides" data-dismiss="modal">Cancel</button>
                                                                                    <input  type="submit" class="btn btn-danger" name="service" value="Delete">

                                                                                </div>
                                                                            </div>
                                                                        </div>    
                                                                    </div>  
                                                                </form>  
                                                            </c:if>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>

                                                <table style="margin-top: 20px;">
                                                    <c:forEach items="${comment.replies}" var="reply">

                                                        <tr id="cmt${reply.id}">
                                                            <th style="width: 150px" scope="row">
                                                                ${reply.user.name}
                                                            </th>
                                                            <td >
                                                                <c:if test="${reply.isStatus() == false}">
                                                                    <i>This comment has been banned.</i>
                                                                </c:if>
                                                                <c:if test="${reply.isStatus() == true}">
                                                                    <p style="white-space: pre-line">@${reply.replyName} ${reply.comment}</p>
                                                                    <div class="row">
                                                                        <div class="col-md-4 small">
                                                                            <c:if test="${reply.getEditedAt()==null}">${reply.getCreatedAt()}</c:if>
                                                                            <c:if test="${reply.getEditedAt()!=null}">Edited ${reply.getEditedAt()}</c:if>
                                                                            </div>                                
                                                                        <c:if test="${reply.getUserId()!=sessionScope.user.getId()}">
                                                                            <div class ="col-md-3 small">
                                                                                <a class="visible-toolkit-item do-reply" href="#ReplyComment${reply.getId()}" data-toggle="collapse"
                                                                                   aria-expanded="false" aria-controls="Reply">Reply</a>
                                                                            </div>

                                                                            <div class="collapse col-12" id="ReplyComment${reply.getId()}">
                                                                                <form action="Reply" method="get">
                                                                                    <input type="text" class="form-control" name="reply" ${empty sessionScope.user ? "":"required"}/>
                                                                                    <input type="submit" value="Reply">
                                                                                    <input type="hidden" id="cId" name="sId" value="${comment.getId()}"> 
                                                                                    <input type="hidden" id="cId" name="rId" value="${reply.getId()}"> 
                                                                                    <input type="hidden" id="uId" name="uId" value="${sessionScope.user.getId()}">
                                                                                    <input type="hidden" id="bId" name="bId" value="${requestScope.book.id}">
                                                                                </form>
                                                                            </div>   
                                                                        </c:if>
                                                                        <c:if test="${reply.getUserId()==sessionScope.user.getId()}">
                                                                            <div class="col-md-1 small">
                                                                                <a class="visible-toolkit-item do-reply" href="#EditComment${reply.getId()}" data-toggle="collapse"
                                                                                   aria-expanded="false" aria-controls="EditComment">Edit</a>
                                                                            </div>
                                                                            <div class="col-md-2 small">
                                                                                <a class="visible-toolkit-item do-reply" data-toggle="modal" data-target="#DeleteComment${reply.getId()}">Delete</a>
                                                                            </div>

                                                                            <div class="collapse col-12" id="EditComment${reply.getId()}">
                                                                                <form action="Update" method="get">
                                                                                    <input type="text" class="form-control" name="newComment"/>
                                                                                    <input type="submit" value="Edit">
                                                                                    <input type="hidden" id="cId" name="cId" value="${reply.getId()}"> 
                                                                                    <input type="hidden" id="uId" name="uId" value="${sessionScope.user.getId()}">
                                                                                    <input type="hidden" id="bId" name="bId" value="${requestScope.book.id}">
                                                                                </form>
                                                                            </div>
                                                                            <form method="post" action="Update">
                                                                                <input type="hidden" name="bId" value="${requestScope.book.id}"/>
                                                                                <input type="hidden" name="uId" value="${sessionScope.user.id}"/>
                                                                                <input type="hidden" name="cId" value="${reply.getId()}">
                                                                                <div class="modal fade" id="DeleteComment${reply.getId()}" tabindex="-1" 
                                                                                     role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                                                                        <div class="modal-content">
                                                                                            <div class="modal-header">
                                                                                                <h5 class="modal-title" id="exampleModalCenterTitle">Alert</h5>
                                                                                            </div>
                                                                                            <div class="modal-body">
                                                                                                Delete this comment ... ?
                                                                                            </div>
                                                                                            <div class="modal-footer">
                                                                                                <button type="button" id="bootstrap-overrides" data-dismiss="modal">Cancel</button>
                                                                                                <input  type="submit" class="btn btn-danger" name="service" value="Delete">

                                                                                            </div>
                                                                                        </div>
                                                                                    </div>    
                                                                                </div>  
                                                                            </form>  
                                                                        </c:if>
                                                                    </div>

                                                                </c:if>
                                                            </td>
                                                            <td style="height: 100px">
                                                                <c:choose>
                                                                    <c:when test="${!empty sessionScope.admin}">
                                                                        <c:if test="${reply.isStatus() == true}">
                                                                            <a class="fa fa-times" type="button"  data-bs-toggle="modal" data-bs-target="#staticBackdrop-${reply.id}">
                                                                            </a>
                                                                        </c:if>
                                                                        <!-- Modal -->
                                                                        <div class="modal" id="staticBackdrop-${reply.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
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
                                                                                            <input type="hidden" name="id" value="${reply.id}">
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
                                                                        <c:if test="${reply.isStatus() == true}">
                                                                            <form id="${reply.id}" action="ReportComment" method="get">
                                                                                <p><i class="fa fa-flag" aria-hidden="true" onclick="document.getElementById('${reply.id}').submit()"></i></p>
                                                                                <!--      <input type="submit" class="primary" display="hidden" value="Report">                          -->
                                                                                <input type="hidden" name="bId" value="${book.id}">
                                                                                <input type="hidden" name="cId" value="${reply.id}">

                                                                            </form>
                                                                        </c:if>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            </td>
                                                        </tr>

                                                    </c:forEach>
                                                </table>
                                            </td>
                                            <td style="" style="height: 100px">
                                                <c:choose>
                                                    <c:when test="${!empty sessionScope.admin}">
                                                        <c:if test="${comment.isStatus() == true}">
                                                            <a class="fa fa-times" type="button"  data-bs-toggle="modal" data-bs-target="#staticBackdrop-${comment.id}">
                                                            </a>
                                                        </c:if>
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
                                                        <c:if test="${comment.isStatus() == true}">
                                                            <form id="${comment.id}" action="ReportComment" method="get">
                                                                <p><i class="fa fa-flag" aria-hidden="true" onclick="document.getElementById('${comment.id}').submit()"></i></p>
                                                                <!--      <input type="submit" class="primary" display="hidden" value="Report">                          -->
                                                                <input type="hidden" name="bId" value="${book.id}">
                                                                <input type="hidden" name="cId" value="${comment.id}">

                                                            </form>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:if> 
                                </c:forEach>
                            </table>
                        </div>
                    </div>

                    <div class="container-fluid mt-5">
                        <h2 class="h2">Similar Products</h2>

                        <!-- Products -->
                        <section class="tiles">
                            <c:forEach items="${sames}" var="book">
                                <article class="style1" style="width: calc(20% - 2.5em);margin: 4em 0 0 4em;">
                                    <span class="image">
                                        <img src="${(!empty book.image)?book.image:"images/novel-sample.png"}" alt="" style="height: 281px;"/>
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
                                    </a>
                                </article>
                            </c:forEach>
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
            <%request.getSession().removeAttribute("error");%>

        </div>

        <!-- Scripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>
        <script>
                                                                    function validatePassword(formId) {
                                                                        let pass = document.forms[formId]["pass"].value;
                                                                        let x = document.forms[formId]["password"].value;
                                                                        if (pass !== x) {
                                                                            document.getElementById("purchase-pass-noti").innerHTML = "Wrong password";
                                                                            return false;
                                                                        }
                                                                    }
                                                                    const url_string = window.location.href;
                                                                    const url = new URL(url_string);
                                                                    var cmtId = url.searchParams.get("cmtId");
                                                                    if (cmtId != null) {
                                                                        var id = document.getElementById("cmt" + cmtId);
                                                                        id.scrollIntoView({block: "center"});
                                                                        id.classList.add("current");
                                                                    }
                                                                    $("#fav").on('click', function () {
                                                                        $("#favfrm").submit();
                                                                    });
                                                                    $("#refav").on('click', function () {
                                                                        $("#reportfrm").submit();
                                                                    });
                                                                    $("#buy").on('click', function () {
                                                                        $("#getfrm").submit();
                                                                    });
                                                                    $("#read").on('click', function () {
                                                                        $("#readfrm").submit();
                                                                    });
                                                                    $("#ratingfrm").on('click', function () {
                                                                        $("#ratingfrm").submit();
                                                                    });
        </script>
    </body>
</html>