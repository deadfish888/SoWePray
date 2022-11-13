<%-- 
    Document   : Recharge
    Created on : Oct 26, 2022, 2:45:03 AM
    Author     : fpt
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <jsp:include page="/views/base/userHeadImport.jsp"/>
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <script src="https://www.google.com/recaptcha/api.js"></script>
        <style>
            .g-recaptcha {
                display: inline-block;
                margin: auto;
            }
        </style>
        <title>Withdraw</title>
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
                        <h1>WITHDRAW</h1>
                    </div>
                    <div style="margin: 10px 5em">
                        <form action="Withdraw" method="post">
                            <div id="step-1">
                                <div>Step 1: Enter the amount you want to withdraw.</div>
                                <div class="text-center">
                                    Amount: &emsp; <input type="number" name="amount" step="0.01" value="${amount}" required min="0.1" max="${sessionScope.user.paymentAccount.balance}"/>
                                </div>
                            </div>
                            <div id="step-2">
                                <div>Step 2: Enter your bank and account number <br/>
                                    <!-- Or upload qr image? -->
                                    <div class="text-center">
                                        <div style="display: inline-block">
                                            Bank:&emsp; 
                                            <select name="bank">
                                                <option>BIDV</option>
                                                <option>TP Bank</option>
                                                <option>MB Bank</option>
                                                <option>Vietcombank</option>
                                                <option>Techcombank</option>
                                                <option>Agribank</option>
                                            </select>
                                            Account number: &emsp; <input type="number" name="accountNumber" required/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="step-3" style="clear: both;">
                                <div>
                                    Step 3: Check the below reCAPTCHA, click "Confirm" button and wait for admin's approval. <br/>
                                    We will respond to you as quickly as possible.
                                </div>
                                <div class="text-center">
                                    <div class="g-recaptcha text-center" data-sitekey="6LfpnrEiAAAAAEOoMb6jEkwi6PxfbU5A6j4fBvTb"></div>
                                </div>

                                <button type="button" data-toggle="modal" data-target="#withdraw" style="float: right">Submit</button>
                                <button type="button" style="float: right; margin-right: 5px"><a href="Payment">Cancel</a></button>
                            </div>
                            <div class="modal fade" id="withdraw" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h3 class="modal-title">Withdraw</h3>
                                        </div>
                                        <div class="modal-body">
                                            <div class="wrapper row">
                                                <table style="width: 80%; margin: auto">
                                                    <tr>
                                                        <th>
                                                            Password
                                                        </th>
                                                        <td>
                                                            <input type="password" name="password"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="modal-footer" style="text-align: center">
                                            <button type="button" class="primary btn-primary text-center" data-dismiss="modal" style="width: auto; padding: 0 1em">Cancel</button>
                                            <input type="submit" class="primary text-center" value="Confirm"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>                                                            
                        <div style="color: red">
                            ${sessionScope.error}
                        </div>
                        <%request.getSession().removeAttribute("error");%>


                    </div>
                </div>
            </div>


        </div>
        <!-- Scripts -->

        <jsp:include page="/views/base/userFootImport.jsp"/>
    </body>
</html>
