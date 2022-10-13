<%-- 
    Document   : Bookshelf
    Created on : Oct 13, 2022, 9:03:38 PM
    Author     : fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<script src="assets/js/ProfileScript.js" type="text/javascript"></script>-->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <!--<link href="assets/css/style-profile.css" rel="stylesheet" type="text/css"/>-->
        <title>JSP Page</title>
    </head>
    <body>
        <div class = "wrapper">
            
            <div class="right-aside col-md-10" style="display: block">
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
                    <div id="userInfo">
                        
                    </div>
                    <div id="bookshelf">
                        
                    </div>
        </div>
    </body>
</html>
