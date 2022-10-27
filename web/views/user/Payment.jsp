<%-- 
    Document   : Payment
    Created on : Sep 26, 2022, 12:49:58 AM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/views/base/userHeadImport.jsp"/>
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Your Payment</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <img src="${context}/images/default.png" width="100em" height="100em" class="rounded mx-auto d-block" alt="..." style="border:2px solid #fff; display: block; margin: auto">
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">My Profile</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Novels">My Novels</a>
                    </li>
                    <li class="active sidebar-item">
                        Payment
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
                        <h1>PAYMENT</h1>
                    </div>
                    <div style="margin-bottom: 5em">
                        <h2>My wallet</h2>
                        <!-- An so du tai khoan, khi click vao icon hinh con mat se hien ra -->
                        <div style="width: 90%; margin: auto">
                            <a onclick="changeIcon(this)" id="myBtn">
                                <span class="SPN" data-text="Balance: $${sessionScope.user.paymentAccount.balance}">Balance: ****.**</span>
                                <i id="faPlus" class='bx bx-hide'></i> 
                            </a>
                            <button style="margin-left: 1em; float: right"><a href="Deposit">Deposit</a></button>
                            <button style="margin-left: 1em; float: right"><a href="Withdraw">Withdraw</a></button> <br/>
                            <span style="color: red">${requestScope.walletNoti}</span>

                        </div>
                    </div>

                    <div style="margin-bottom: 5em">
                        <h2>Transaction history</h2>
                        <!-- Hien thi danh sach transaction cua user nay -->

                        <table class="text-center" style="width: 90%; margin: auto">
                            <tr>
                                <th style="padding: 0" class="text-center">Index</th>
                                <th style="padding: 0" class="text-center">Amount</th>
                                <th style="padding: 0" class="text-center">Balance</th>
                                <th style="padding: 0" class="text-center">Time</th>
                                <th style="padding: 0" class="text-center">Status</th>
                                <th style="padding: 0" class="text-center">Description</th>
                                <th style="padding: 0" class="text-center">Report</th>
                            </tr>
                            <%int index = 0;%>
                            <c:forEach items="${requestScope.transList}" var="transaction">
                                <tr>
                                    <%index++;%>
                                    <td>
                                        <%=index%>
                                    </td>
                                    <td style="color: <c:if test="${transaction.type == 1 || transaction.type == 4}">green</c:if>
                                        <c:if test="${transaction.type == 2 || transaction.type == 3}">red</c:if>">
                                        <c:if test="${transaction.type == 1 || transaction.type == 4}">+ </c:if>
                                        <c:if test="${transaction.type == 2 || transaction.type == 3}">- </c:if>
                                        $${transaction.amount}
                                    </td>
                                    <td>
                                        ${transaction.balanceAfter}
                                    </td>
                                    <td>
                                        ${transaction.transactionTime}
                                    </td>
                                    <td>
                                        <c:if test="${transaction.status == 1}">Fail</c:if>
                                        <c:if test="${transaction.status == 2}">Pending</c:if>
                                        <c:if test="${transaction.status == 3}">Success</c:if>
                                        </td>
                                        <td>
                                        ${transaction.description}
                                    </td>
                                    <td>
                                        <button name="report" style="border: 0; background: none">
                                            <a><i class="fa fa-warning"></i></a>
                                        </button></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
            </div>


        </div>
        <!-- Scripts -->

        <jsp:include page="/views/base/userFootImport.jsp"/>
    </body>
</html>
