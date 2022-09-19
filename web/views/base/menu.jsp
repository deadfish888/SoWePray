<nav id="menu">
    <h2>
        <% 
        if(session.getAttribute("user")!=null){ 
        %>
        <a href="">Welcome ${sessionScope.user.getName()}</a>
        <% } else if (session.getAttribute("admin")!=null){ 
        %>
        <a href="./manage/ADprofile.jsp">Welcome ${sessionScope.admin.getName()}</a>
        <% } else { %>
        <a href="">Menu</a>
        <% }%>
    </h2>
    <ul>
        <li><a href="./Home">Home</a></li>



        <li><a href="./Book">Library</a></li>

        <% 
            if(session.getAttribute("user")!=null){ 
        %>
        <li><a href="">Bookshelf</a></li>

        <li><a href="">Favorite</a></li>

        <li><a href="about.jsp">About</a></li>

        <li><a href="Logout"><i class="fa fa-sign-out"></i>Logout</a></li>

        <%  
            } else if(session.getAttribute("admin")!=null){ 
        %>
        <li><a href="about.jsp">About</a></li>

        <li><a href="Logout"><i class="fa fa-sign-out"></i>Logout</a></li>

        <% 
            } else { 
        %>
        <li><a href="about.jsp">About</a></li>

        <li><a href="Login?origin=./Home"><i class="fa fa-sign-in"></i>Login</a></li>

        <% }%>


    </ul>
</nav>