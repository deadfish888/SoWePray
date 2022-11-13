<%-- 
    Document   : userHeadImport
    Created on : Oct 14, 2022, 3:08:33 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="${context}/assets/js/ProfileScript.js" type="text/javascript"></script>
        <link rel="stylesheet" href="${context}/assets/bootstrap/css/bootstrap.min.css" />
        <link rel="stylesheet" href="${context}/assets/css/main.css" />
        <link href="${context}/assets/css/style-profile.css" rel="stylesheet" type="text/css"/>
        <style>
            .section-title{
                background-color: #f5f5f5;
                border: 1px solid #d4dae2;
                border-radius: 4px;
                display: inline-block;
                padding: 4px 10px;
            }
            #bootstrap-overrides{
                font-size: 0.8em;
                font-weight: 900;
                height: 3.5em;
                letter-spacing: 0.35em;
                line-height: 3.45em;
                overflow: hidden;
                padding: 0 1.25em 0 1.6em;
                text-align: center;
                text-decoration: none;
                text-overflow: ellipsis;
                text-transform: uppercase;
                white-space: nowrap;
            }
            .wrapper{
                min-height: 100vh;
            }
        </style>
    </head>
</html>
