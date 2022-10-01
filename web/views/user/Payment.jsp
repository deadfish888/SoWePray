<%-- 
    Document   : Payment
    Created on : Sep 26, 2022, 12:49:58 AM
    Author     : fpt
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
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <title>Payment</title>
    </head>
    <body>
        <div class="wrapper">
            <nav id="sidebar" class="bg-dark col-md-2 text-light" style="display: block; float: left; padding: 5px">
                <div style="display: block; margin: auto; text-align: center; margin-top: 2em">
                    <canvas id="myCanvas" width="100em" height="100em" style="border:2px solid #fff; display: block; margin: auto">
                        Your browser does not support the HTML5 canvas tag.</canvas>
                    <div class="sidebar-header">
                        <h3 class="" style="margin-bottom: 0">Hi, ${sessionScope.user.username}</h3>
                        <p>UserID: ${sessionScope.user.id}</p>
                    </div>

                </div>

                <ul class="list-unstyled components" style="padding: 0.5em; font-size: 1.4em">
                    <li class="sidebar-item">
                        <a href="./Profile">Security</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="./Security">Security</a>
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
                        <h1>PAYMENT</h1>
                    </div>
                    <div>
                        <h2>My wallet</h2>
                        <!-- An so du tai khoan, khi click vao icon hinh con mat se hien ra -->
                        <a onclick="changeIcon(this)" id="myBtn">
                            <span class="SPN" data-text="Balance: $${sessionScope.user.paymentAccount.balance}">Balance: ****.**</span>
                            <i id="faPlus" class='bx bx-hide'></i> 
                        </a>
                    </div>
                    <div>
                        <h2>Payment method</h2>
                        <!-- Hien thi danh sach transaction cua user nay -->
                        <table class="text-center" style="width: 90%; margin: auto">
                            <tr>
                                <th style="padding: 0" class="text-center">Name</th>
                                <th style="padding: 0" class="text-center">Account number</th>
                                <th style="padding: 0.5em 0" class="text-center" style="width: 10%">Remove</th>
                            </tr>
                            <c:forEach var="paymentMethod" items="${requestScope.payMedList}">
                                <tr>
                                    <td>
                                        ${paymentMethod.name}
                                    </td>
                                    <td>
                                        ${paymentMethod.paymentAccount.accountNumber}
                                    </td>
                                    <td>
                                        <a data-toggle="modal" 
                                           data-target="#removePaymentMethod" 
                                           title="Remove this payment method"
                                           href="#removePaymentMethod"
                                           onclick="setRemovePaymentId(${paymentMethod.paymentId})">
                                            <i id="garbage-can" class='fa fa-trash-o'></i> 
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <div class="modal fade" id="removePaymentMethod" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form action="RemovePayment" method="post" id="removePaymentForm" name="removeForm" onsubmit="return validatePassword()">
                                        <div class="modal-header">
                                            <h3 class="modal-title">Remove payment method</h3>
                                        </div>
                                        <div class="modal-body">
                                            <div class="wrapper row">
                                                <table>
                                                    <tr>
                                                        <th>
                                                            Password
                                                        </th>
                                                        <td>
                                                            <input type="password" name="password"/>
                                                            <div style="color: red" id="pass-noti"></div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="text-align: center">
                                            <button type="button" data-dismiss="modal">Cancel</button>
                                            <input type="hidden" id="pass" value="${sessionScope.user.password}"/>
                                            <input type="hidden" id="removedPaymentId" name="removedPaymentId" value=""/>
                                            <input type="submit" value="Confirm"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <br/><button class="text-center" value="addMethod" style="display: block;margin: auto" data-toggle="modal" 
                                     data-target="#addPaymentMethod" >Add payment</button>
                        <span style="color: red">${requestScope.addErrorNoti}</span>

                        <div class="modal fade" id="addPaymentMethod" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form action="AddPayment" method="post" id="addPaymentForm" name="addForm" onsubmit="return validateAddPassword()">
                                        <div class="modal-header">
                                            <h3 class="modal-title">Add payment method</h3>
                                        </div>
                                        <div class="modal-body">
                                            <div class="wrapper row">
                                                <table>
                                                    <tr>
                                                        <th>
                                                            Account number
                                                        </th>
                                                        <td>
                                                            <input type="number" name="accountNumber" required/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>
                                                            Payment name
                                                        </th>
                                                        <td>
                                                            <input type="text" name="paymentName"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th>
                                                            Password
                                                        </th>
                                                        <td>
                                                            <input type="password" name="password"/>
                                                            <div style="color: red" id="add-pass-noti"></div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="text-align: center">
                                            <button type="button" data-dismiss="modal">Cancel</button>
                                            <input type="hidden" id="pass" value="${sessionScope.user.password}"/>
                                            <input type="submit" value="Confirm"/>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
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
                                        <c:if test="${transaction.status == 0}">Fail</c:if>
                                        <c:if test="${transaction.status == 1}">Pending</c:if>
                                        <c:if test="${transaction.status == 2}">Success</c:if>
                                        </td>
                                        <td>
                                        ${transaction.description}
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
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
