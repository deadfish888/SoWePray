<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />

<nav id="menu">
    <h2>
        <c:choose>
            <c:when test="${!empty sessionScope.user}">
                Welcome ${sessionScope.user.name}
            </c:when>
            <c:when test="${!empty sessionScope.admin}">
                <a href="./Edit">Welcome ${sessionScope.admin.name}</a>
            </c:when>

            <c:otherwise>
                Welcome to BOOKIE
            </c:otherwise>
        </c:choose>

    </h2>
    <ul>
        <li><a href="${context}/Home">Home</a></li>

        <li><a href="${context}/Book">Library</a></li>

        <c:choose>
            
                <c:when test="${!empty sessionScope.user.is_super()}">
                <li><a href="${context}/User/Profile">My profile</a></li>
                <li><a href="${context}/User/Bookshelf">Bookshelf</a></li>
                </c:when>
            </c:choose>



        <li><a href="${context}/about.jsp">Rule</a></li>

        <c:if test="${!empty sessionScope.user && empty sessionScope.admin}">
            <li><a href="${context}/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
            </c:if>
            <c:if test="${!empty sessionScope.admin}">
            <li class="nav-item"><a href="${context}/Admin/DashBoard"><i class="fa fa-cog"></i>Setting</a></li>
            <li class="nav-item"><a href="${context}/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
            </c:if>

        <c:if test="${empty sessionScope.user and empty sessionScope.admin}">
            <li class="nav-item"><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>
            </c:if>

    </ul>
</nav>