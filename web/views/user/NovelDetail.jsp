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
        <style>
            .section-title{
                background-color: #f5f5f5;
                border: 1px solid #d4dae2;
                border-radius: 4px;
                display: inline-block;
                padding: 4px 10px;
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
            }
        </style>
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
                        <h3 class="section-title">Series ${book.title}</h3>
                        <div class="table-responsive">
                            <form action="./${service}Novel" method="post">
                                <input type="hidden"  name="id" value="${(book.id!=null)?book.id: ""}">
                                <div class="form-group row col-12">
                                    <label for="exampleSelect1" class="col-sm-2 col-form-label">Title</label>
                                    <div class="col-sm-10">
                                        <input class="form-control" type="text" name="title" required value="${book.title}">
                                    </div>
                                </div>

                                <div class="form-group row col-12">
                                    <label class="col-sm-2 col-form-label">Category</label>
                                    <div class="col-sm-10">
                                        <div class="row">
                                            <c:forEach items="${categories}" var="category">
                                                <div class="browsers form-check form-check-inline col-4 mx-0" >
                                                    <input name="categoryId" class="form-check-input" type="checkbox" id="inlineCheckbox${category.id}" value="${category.id}" required=""
                                                           <c:forEach items="${book.category}" var="cateBook">
                                                               ${cateBook.id==category.id ? "checked" :""}
                                                           </c:forEach>   >
                                                    <label class="form-check-label" for="inlineCheckbox${category.id}">${category.name}</label>
                                                </div>
                                            </c:forEach> 
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.user.is_super() >= 3}">
                                    <div class="form-group row col-12">
                                        <label class="col-sm-2 col-form-label">Price ($/thousand words)</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" name="price" pattern="[+-]?([0-9]*[.])?[0-9]+" required value="${! empty book.getPrice() ? book.price : 0}">
                                        </div>
                                    </div>
                                    <div class="form-group row col-12">
                                        <label class="col-sm-2 col-form-label" for="sale">Paid</label>
                                        <div class="col-sm-2">
                                            <input class="form-check-input" id="sale" type="checkbox" name="issale" value="true" ${book.issale()?"checked":""}>
                                            <label class="form-check-label" for="sale">.</label>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="form-group row col-12">
                                    <label class="col-sm-2 col-form-label">Summary</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" name="description" style="white-space: pre-line;min-height: 10em" rows="5">${book.getDescription()}</textarea>
                                    </div>
                                </div>
                                <div class="form-group row col-12">
                                    <label class="col-sm-2 col-form-label" >Image</label>
                                    <div class="col-sm-10">
                                        <input class="form-control" type="text" name="image" value="${book.getImage()}">
                                        <input name="proimage" id="image" value="${book.getImage()}" type="hidden" >
                                        <img  src="${book.getImage()}" id="demoimg${book.id}" style="margin-top: 5px;" height="100">
                                    </div>
                                </div>
                                <div class="row col-12">
                                    <div class="col-2"> 
                                        <input class="btn ${service=="Create"?"btn-primary":"btn-success"}" name="in" type="submit" value="${service}">
                                    </div>

                                    <c:if test="${message !=null}">
                                        ${message}
                                    </c:if>
                                    <c:if test="${!empty issold && !issold}">
                                        <div class="col-2"> 
                                            <button type="button" data-toggle="modal" data-target="#exampleModalCenter">Delete</button>
                                            <!--<a id="bootstrap-overrides" class="btn btn-danger" href="./Status?id=${book.id}&service=Delete" >Delete</a>-->
                                        </div>

                                    </c:if>
                                </div>
                            </form>
                            <form action="./Status" method="get">
                                <input type="hidden" name="id" value="${book.id}">
                                <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalCenterTitle">Alert</h5>
                                            </div>
                                            <div class="modal-body">
                                                All information of series ${book.title} will be deleted forever!
                                                Are you sure want to delete series ${book.title} ?
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" data-dismiss="modal">Close</button>
                                                <input id="bootstrap-overrides" type="submit" class="btn btn-danger" name="service" value="Delete">
                                            </div>
                                        </div>
                                    </div>
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
        <script>
            $(function () {
                var requiredCheckboxes = $('.browsers :checkbox[required]');
                requiredCheckboxes.change(function () {
                    if (requiredCheckboxes.is(':checked')) {
                        requiredCheckboxes.removeAttr('required');
                    } else {
                        requiredCheckboxes.attr('required', 'required');
                    }
                });
            });
        </script>
    </body>
</html>
