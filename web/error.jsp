<%-- 
    Document   : error
    Created on : Oct 19, 2022, 4:48:29 PM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="context" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bookie</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <noscript><link rel="stylesheet" href="assets/css/noscript.css"/></noscript>
        <style>
            .vertical-center {
                margin: 0;
                position: absolute;
                top: 48%;
                left: 26%;
                -ms-transform: translateY(-50%);
                transform: translateY(-50%);
            }
            #countUp {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100%;

                .number {
                    font-size: 4rem;
                    font-weight: 500;

                    + .text {
                        margin: 0 0 1rem;
                    }
                }

                .text {
                    font-weight: 300;
                    text-align: center;
                }
            }
            body {
                background-image: url("images/nebula.jpg");
                background-size: cover;
                background-repeat: no-repeat;
                min-height: 100vh;
                min-width: 100vw;
                font-family: "Roboto Mono", "Liberation Mono", Consolas, monospace;
                color: rgba(255,255,255,.87);
            }

            .mx-auto {
                margin-left: auto;
                margin-right: auto;
            }
            html, body {
                width: 100%;
                height: 100%;
            }
            .container,
            .container > .row,
            .container > .row > div {
                height: 100%;
            }
        </style>
    </head>
    <body style="">
        <div class="container">
            <div class="row">
                <div class="xs-12 md-6 mx-auto">
                    <div id="countUp">
                        <div class="number" data-count="404">404 NOT FOUND</div>
                        <div class="text">BẠN NHÌN THẤY GÌ KHÔNG? LÀ MÀN HÌNH ĐÓ!</div>
                        <a id="ac" onclick="goback()" class="text btn btn-danger">BACK</a>
                    </div>
                </div>
            </div>
        </div>            



    </body>
    <script>
        function goback(){
            history.back();
        }
    </script>
</html>
