<%-- 
    Document   : register
    Created on : Sep 8, 2022, 9:26:36 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Join us</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
    </head>
    <body>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <h1>User Registration</h1>
            </div>
        </div><form action="Signup" method="POST">
        <div class="container">
            <div class="row justify-content-center">
                
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="login-wrap p-4 p-md-5">

                                <input type="hidden" name="origin" value="${origin}">
                                <div>
                                    <label for="email">Email</label>
                                    <input type="email" name="email"value="${in4.getEmail()}" required>
                                </div>
                                <div>
                                    <label  for="username">Username</label>
                                    <input type="text" name="username"  value="${in4.getUsername()}" required>
                                </div>
                                <div>
                                    <label for="password">Password</label>
                                    <input name="password" type="password" required>
                                </div>
                                <div>
                                    <label for="phone">Phone</label>
                                    <input type="text" name="phone" value="${in4.getPhone()}" required>
                                </div>
                                <% if (request.getAttribute("error") != null) {%>
                                <div class="w-100">
                                    <%=request.getAttribute("error")%>
                                </div>
                                <%}%>

                            </div>

                        </div>
                    </div>
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="login-wrap p-4 p-md-5">

                                <div>
                                    <label for="name">Full Name</label>
                                    <input type="text" name="name"value="${in4.getName()}" required>
                                </div>
                                <div style="margin: 2em 0 1em;">
                                    <input id="male" type="radio" name="gender" value="Male">
                                    <label for="male">Male</label>
                                    <input id="female" type="radio" name="gender" value="Female">
                                    <label for="female">Female</label>
                                </div>
                                <div>
                                    <label for="birthday">Birthday</label>
                                    <input type="date" name="birthday" required>
                                </div>
                                <div style="margin: 2em 0 1em;">
                                    <button type="submit">Register</button>
                                </div>

                            </div>
                        </div>
                    </div>
                
            </div>
    </div></form>
    <script src="assets/js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
