<%@ page session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>You lost?</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="assets/css/style.css">

    </head>
    <body>
        <section class="ftco-section">
            <div class="row justify-content-center">
                <div class="col-md-6 text-center mb-5">
                    <h2 class="heading-section"><a href="/Bookie/Home"><span class="fa fa-book"></span>Bookie</a></h2>
                </div>
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="img" style="background-image: url(images/slider-image-3-1920x700.jpg);"></div>
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4">Take back your account</h3>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${requestScope.token != null}">
                                        <div class="form-group mt-3">
                                            <input type="text" name="newpass" id="myInput" class="form-control" required value="${requestScope.newpassword}">
                                            <label class="form-control-placeholder" for="newpass" >Your new password</label>
                                        </div>
                                            <c:if test="${requestScope.Message != null}">
                                                <div class="w-100">
                                                    <c:out value="${requestScope.Message}"/>
                                                </div>
                                            </c:if>
                                        <div class="form-group">
                                            <button type="submit" class="form-control btn btn-primary rounded submit px-3" onclick="copyToClipboard()"><span class="fa fa-copy"></span>Copy to Clipboard</button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <form action="Forgot" method="POST" class="signin-form">
                                            <input type="hidden" name="origin" value="${origin}">
                                            <div class="form-group mt-3">
                                                <input type="text" name="email" class="form-control" required value="">
                                                <label class="form-control-placeholder" for="email" >Email</label>
                                            </div>
                                            <c:if test="${requestScope.Message != null}">
                                                <div class="w-100">
                                                    <c:out value="${requestScope.Message}"/>
                                                </div>
                                            </c:if>
                                            <div class="form-group">
                                                <button type="submit" class="form-control btn btn-primary rounded submit px-3">Reset Password</button>
                                            </div>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                                <p class="text-center">Already have an account? <a href="Login?origin=${origin}">Sign in</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="assets/js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/js/main.js"></script>

    </body>
</html>

