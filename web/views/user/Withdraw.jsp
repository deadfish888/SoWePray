<%-- 
    Document   : Recharge
    Created on : Oct 26, 2022, 2:45:03 AM
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
        <title>Withdraw</title>
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
                        <h1>WITHDRAW</h1>
                    </div>
                    <div style="margin: 10px 5em">
                        <form action="Deposit" method="post">
                            <div id="step-1">
                                <div>Step 1: Enter the amount you want to withdraw.</div>
                                <div class="text-center">
                                    Amount: &emsp; <input type="number" name="amount" step="0.01" value="${amount}" required min="0.1" max="${sessionScope.user.paymentAccount.balance}"/>
                                </div>
                            </div>
                            <div id="step-2">
                                <div>
                                    Step 2: Enter your bank and account number <br/>
                                    <!-- Or upload qr image? -->
                                    Bank: &emsp; 
                                    <select>
                                        <option>
                                            BIDV
                                        </option>
                                        <option>
                                            TP Bank
                                        </option>
                                        <option>
                                            BM Bank
                                        </option>
                                        <option>
                                            Vietcombank
                                        </option>
                                        <option>
                                            Techcombank
                                        </option>
                                        <option>
                                            Agribank
                                        </option>
                                    </select>
                                    Account number: &emsp; <input type="number" name="AccountNumber" required/>
                                </div>
                                <div class="text-center">
                                    <img src="${context}/images/qr code (not value).png" alt="QR Code"/>

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
                                <button type="submit" style="float: right">Submit</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>


        </div>
        <!-- Scripts -->

        <jsp:include page="/views/base/userFootImport.jsp"/>
    </body>
</html>
