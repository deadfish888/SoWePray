<%-- 
    Document   : report
    Created on : Sep 30, 2022, 2:07:49 PM
    Author     : ttaad
--%>


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
                    <h1> ${book.title} </h1>
                    <h2> ${book.getAuthor().name} </h2>
                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.getImage()}" class="img-fluid" alt="${book.getImage()}">
                                
                            </div>
                            <div class="col-md-7">
                                <p>
                                    Flagged books and authors are reviewed by Admin 24 hours a day, 
                                    7 days a week to determine whether they violate Community Guidelines. 
                                    Accounts are penalized for Community Guidelines violations,
                                    and serious or repeated violations can lead to account termination.
                                </p>   
                                
                                <ul class="ks-cboxtags">
                                    <form action="Report" method="GET">
                                        <input type="hidden" name="bookId" value="${book.id}">
                                        <li><input type="checkbox" id="checkboxOne" name="report" value="1"><label for="checkboxOne">Sexual Content</label></li>
                                        <li><input type="checkbox" id="checkboxTwo" name="report" value="2" ><label for="checkboxTwo">Violent or repulsive content</label></li>
                                        <li><input type="checkbox" id="checkboxThree" name="report" value="3" ><label for="checkboxThree">Hateful or abusive content</label></li>
                                        <li><input type="checkbox" id="checkboxFour" name="report" value="4"><label for="checkboxFour">Harassment or bullying</label></li>
                                        <li><input type="checkbox" id="checkboxFive" name="report" value="5"><label for="checkboxFive">Harmful or dangerous acts</label></li>
                                        <li><input type="checkbox" id="checkboxSix" name="report" value="6"><label for="checkboxSix">Child abuse</label></li>
                                        <li><input type="checkbox" id="checkboxSeven" name="report" value="7"><label for="checkboxSeven">Promotes terrorism</label></li>
                                        <li><input type="checkbox" id="checkboxEight" name="report" value="8"><label for="checkboxEight">Spam or misleading</label></li>
                                        <li><input type="checkbox" id="checkboxNine" name="report" value="9"><label for="checkboxNine">Infringes my rights</label></li>
                                        <li><input type="checkbox" id="checkboxTen" name="report" value="10"><label for="checkboxTen">Captions issue</label></li>
                                        <li><textarea id="id" name="note" rows="5" cols="10" placeholder="Issue details..." required="true"></textarea></li>
                                        <li><input type="submit" class="primary" value="Send Report"></li>
                                    </form>
                                </ul>
                            </div>
                             
                        </div>           
                    </div>
                    <br>
                    <br>
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
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.scrolly.min.js"></script>
        <script src="assets/js/jquery.scrollex.min.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>

