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
                    <h1> ${book.getTitle()} </h1>
                    <h2> ${book.getAuthor()} </h2>
                    <div class="container-fluid">
                        <div class="row" style="width: 1200px; text-align: justify;">
                            <div class="col-md-3">
                                <img src="${book.getImage()}" class="img-fluid" alt="${book.getImage()}">
                                <div style="text-align: center;">
                                    <span class="fa fa-eye"></span>
                                </div>
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
    <li><input type="checkbox" id="checkboxOne" value="report1"><label for="checkboxOne">Rainbow Dash</label></li>
    <li><input type="checkbox" id="checkboxTwo" value="report2" checked><label for="checkboxTwo">Cotton Candy</label></li>
    <li><input type="checkbox" id="checkboxThree" value="report3" checked><label for="checkboxThree">Rarity</label></li>
    <li><input type="checkbox" id="checkboxFour" value="report4"><label for="checkboxFour">Moondancer</label></li>
    <li><input type="checkbox" id="checkboxFive" value="report5"><label for="checkboxFive">Surprise</label></li>
    <li><input type="checkbox" id="checkboxSix" value="report6" checked><label for="checkboxSix">Twilight
                    Sparkle</label></li>
    <li><input type="checkbox" id="checkboxSeven" value="report7"><label for="checkboxSeven">Fluttershy</label></li>
    <li><input type="checkbox" id="checkboxEight" value="Derpy Hooves"><label for="checkboxEight">Derpy Hooves</label></li>
    <li><input type="checkbox" id="checkboxNine" value="Princess Celestia"><label for="checkboxNine">Princess
                    Celestia</label></li>
    <li><input type="checkbox" id="checkboxTen" value="Gusty"><label for="checkboxTen">Gusty</label></li>
    <li><input type="submit" /></li>
    <li><button type="submit" class="btn btn-primary">Send Report</button></li>
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

