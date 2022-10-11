<%-- 
    Document   : WorkDetail
    Created on : Oct 11, 2022, 10:34:13 PM
    Author     : ACER
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../assets/js/ProfileScript.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../assets/css/main.css" />
        <link href="../assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <title>Create Your Novel</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="../images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">My profile</a>
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
                    <li class="sidebar-item">
                        <a href="#">Support</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10" style="display: block">
                <!-- Header -->
                <!--            <div class="topbar">-->

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
                <!--            </div>-->

                <div>
                    <div class="text-center">
                        <h2>Series of ${sessionScope.user.name}</h2>
                    </div>
                    <div class="container border rounded py-3">
                        <h2 class="card-title">Series ${book.title}</h2>
                        <div class="table-responsive">
                            <form action="./${service}Novel" method="post">
                                <input type="hidden"  name="id" value="${(book.id!=null)?book.id: ""}">
                                <div class="form-group">
                                    <label for="exampleSelect1" class="control-label">Title</label>
                                    <input class="form-control" type="text" name="title" required value="${book.title}">
                                </div>

                                <div class="form-group">
                                    <label class="control-label">Category</label>
                                    <div class="row">
                                        <c:forEach items="${categories}" var="category">
                                            <div class="form-check form-check-inline col-3 mx-0" >
                                                <input name="categoryId" class="form-check-input" type="checkbox" id="inlineCheckbox${category.id}" value="${category.id}"
                                                       <c:forEach items="${book.category}" var="cateBook">
                                                           ${cateBook.id==category.id ? "checked" :""}
                                                       </c:forEach>   >
                                                <label class="form-check-label" for="inlineCheckbox${category.id}">${category.name}</label>
                                            </div>
                                        </c:forEach> 
                                    </div>
                                </div>
                                <c:if test="${sessionScope.user.is_super() == 3}">
                                    <div class="form-group col-md-4">
                                        <label class="control-label ">Price (per chapter)</label>
                                        $<input class="form-control" type="text" name="price" pattern="[+-]?([0-9]*[.])?[0-9]+" required value="${book.getPrice()}">

                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Sale</label>
                                        <input type="checkbox" name="issale" value="true" ${book.issale()?"checked":""}>
                                    </div>
                                </c:if>
                                <div class="form-group">
                                    <label class="control-label">Summary</label>
                                    <textarea class="form-control" name="description" style="white-space: pre-line;" rows="5">${book.getDescription()}</textarea>
                                </div>
                                <div class="form-group">
                                    <label class="control-label" >Image (Enter Link)</label>
                                    <input class="form-control" type="text" name="image" required value="${book.getImage()}">
                                    <input name="proimage" id="image" value="${book.getImage()}" type="hidden" >
                                    <img  src="${book.getImage()}" id="demoimg${book.id}" style="margin-top: 5px;" height="100">
                                </div>
                                <div class="col-md-10">
                                    <div class="left-filter"> 
                                        <input class="btn ${service=="Create"?"btn-primary":"btn-outline-danger"}" name="in" type="submit" value="${service}">
                                    </div>
                                    <c:if test="${message !=null}">
                                        ${message}
                                    </c:if>
                                </div>
                            </form>
                        </div>
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
    </body>
</html>
