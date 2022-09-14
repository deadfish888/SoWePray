<%-- 
    Document   : Profile
    Created on : Sep 12, 2022, 1:02:02 PM
    Author     : fpt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>MY PROFILE</h1>
        <div id = 'infomation'>
            <table>
                <tr>
                    <th>
                        Name
                    </th>
                    <td>
                        ${sessionScope.user.name}
                    </td>
                </tr>
                <tr>
                    <th>
                        Email
                    </th>
                    <td>
                        ${sessionScope.user.email}
                    </td>
                </tr>
                <tr>
                    <th>
                        Birth
                    </th>
                    <td>
                        ${sessionScope.user.birth}
                    </td>
                    <th>
                        Gender
                    </th>
                    <td>
                        ${sessionScope.user.gender}
                    </td>
                </tr>
                <tr>
                    <th>
                        Phone number
                    </th>
                    <td>
                        ${sessionScope.user.phone}
                    </td>
                </tr>
                <tr>
                    <th>
                        Address
                    </th>
                    <td>
                        ${sessionScope.user.address}
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>
