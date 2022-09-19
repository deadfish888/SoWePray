<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="menu">
    <h2>
        <c:choose>
            <c:when test="${!empty sessionScope.user}">
            Welcome ${sessionScope.user.name}
        </c:when>
        <c:when test="${!empty sessionScope.admin}">
            Welcome ${sessionScope.admin.name}
        </c:when>
        <c:otherwise>
            Welcome to BOOKIE
        </c:otherwise>
        </c:choose>
        
    </h2>
    <ul>
        <li><a href="<%=request.getContextPath()%>/Home">Home</a></li>

        <li><a href="<%=request.getContextPath()%>/Book">Library</a></li>

        <c:if test="${!empty sessionScope.user}">
            <li><a href="<%=request.getContextPath()%>/User/Profile">My profile</a></li>
            <li><a href="<%=request.getContextPath()%>/Bookshelf">Bookshelf</a></li>
            <li><a href="<%=request.getContextPath()%>/Favor">Favor</a></li>
            <li><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
        </c:if>
        <li><a href="<%=request.getContextPath()%>/about.jsp">About</a></li>
        <c:if test="${!empty sessionScope.admin}">
            <li class="nav-item"><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
        </c:if>                

        <c:if test="${empty sessionScope.user and empty sessionScope.admin}">
            <li class="nav-item"><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>
        </c:if>
        
    </ul>
</nav>