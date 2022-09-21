<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="menu">
    <h2>
        <c:choose>
            <c:when test="${!empty sessionScope.user}">
                Welcome ${sessionScope.user.name}
            </c:when>
            <c:when test="${!empty sessionScope.admin}">
                <a href="./Edit">Welcome ${sessionScope.admin.name}</a>
            </c:when>
            <c:when test="${!empty sessionScope.adminS}">
                <a href="./Edit">Welcome ${sessionScope.adminS.name}</a>
            </c:when>    
            <c:otherwise>
                Welcome to BOOKIE
            </c:otherwise>
        </c:choose>

    </h2>
    <ul>
        <li><a href="<%=request.getContextPath()%>/Home">Home</a></li>

        <li><a href="<%=request.getContextPath()%>/Book">Library</a></li>
        <li><a href="<%=request.getContextPath()%>/about.jsp">About</a></li>
            <c:choose>
                <c:when test="${!empty sessionScope.user}">
                <li><a href="<%=request.getContextPath()%>/User/Profile">My profile</a></li>
                <li><a href="<%=request.getContextPath()%>/Bookshelf">Bookshelf</a></li>
                <li><a href="<%=request.getContextPath()%>/Favor">Favor</a></li>
                <li><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                </c:when>
                <c:when test="${!empty sessionScope.admin}">
                <li><a href="<%=request.getContextPath()%>/User/Profile">My profile</a></li>
                <li><a href="<%=request.getContextPath()%>/Bookshelf">Bookshelf</a></li>
                <li><a href="<%=request.getContextPath()%>/Favor">Favor</a></li>
                <li class="nav-item"><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                </c:when>
                <c:when test="${!empty sessionScope.adminS}">
                <li class="nav-item"><a href="<%=request.getContextPath()%>/Logout"><i class="fa fa-sign-out"></i>Logout</a></li>
                </c:when>    
                <c:otherwise>
                <li class="nav-item"><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>          
                </c:otherwise>
            </c:choose>

    </ul>
</nav>