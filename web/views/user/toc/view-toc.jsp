<%-- 
    Document   : view-toc
    Created on : Oct 13, 2022, 7:57:45 PM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/views/base/userHeadImport.jsp"/>
        <title>Series ${book.title}</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="${context}/images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id} ${sessionScope.user.is_super() eq 3?"- <i class=\"fa fa-dollar\"></i>":""}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="../Profile">My profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="../Security">Security</a>
                    </li>
                    <li class="active sidebar-item">
                        My Novels
                    </li>
                    <li class="sidebar-item">
                        <a href="../Payment">Payment</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="#">Support</a>
                    </li>
                </ul>
            </nav>
            <div class="right-aside col-md-10" style="display: block">
                <!-- Menu -->
                <div class="" style="padding: 0; display: block">
                    <header id="header" style="padding: 0;padding-top: 1.1em">
                        <div>
                            <!-- Logo -->
                            <a href="${context}/Home" class="logo" style="margin-bottom: 1.1em">
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
                    <jsp:include page="/views/base/menu.jsp" />
                </div>

                <div>
                    <div class="text-center">
                        <h2>Series ${book.title}</h2>
                    </div>
                    <div class="container rounded py-3">
                        <div class="row col-12">
                            <jsp:include page="/views/user/toc/toc.jsp"/>
                            <c:if test="${requestScope.chap != null}">
                                <div class="col-lg-8 col-xlg-9 col-md-7">
                                    <div class="card">
                                        <div class="card-body">
                                            <h3 class="card-title mt-2"> 
                                                Chapter ${chap.no}
                                            </h3>
                                            <h6>
                                                <c:if test="${message !=null}">
                                                    ${message}
                                                </c:if>
                                            </h6>
                                            <table class="table">
                                                <tr>
                                                    <th scope="row">
                                                        Name
                                                    </th>
                                                    <td>
                                                        ${chap.title}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        Status
                                                    </th>
                                                    <td>
                                                        ${chap.status ? "Done" : "Not Done"}
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <p><strong>Content</strong></p>
                                                        <c:forEach items="${requestScope.content}" var="para">
                                                            <p style="margin-bottom: 1em">${para}</p>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div class="row mt-3">
                                                <div class="col-3">
                                                    <form method="get" action="./EditChapter" >
                                                        <input type="hidden" name="id" value="${chap.id}">
                                                        <button type="submit" name="service" value="edit">Edit</button>
                                                    </form>
                                                </div>
                                                <div class="col-3">
                                                    <c:if test="${!empty issold && !issold}">
                                                        <!-- Button trigger modal -->
                                                        <button type="button" data-toggle="modal" data-target="#exampleModalCenter">
                                                            Delete
                                                        </button>
                                                    </c:if>
                                                    <!-- Modal -->
                                                    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalCenterTitle">Alert</h5>
                                                                </div>
                                                                <div class="modal-body">
                                                                    Delete this chapter?
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <form method="get" action="./DeleteChapter">
                                                                        <input type="hidden" name="cid" value="${chap.id}">
                                                                        <input type="hidden" name="id" value="${book.id}">
                                                                        <button type="button" data-dismiss="modal">Close</button>
                                                                        <input id="bootstrap-overrides" type="submit" class="btn btn-danger" name="service" value="Delete">
                                                                    </form>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                    </div>
                </div>


            </div></div>
            <!-- Scripts -->
            <jsp:include page="/views/base/userFootImport.jsp"/>

    </body>
</html>
