<!-- navbar page(part2) for the website -->

<%@page import="com.mycompany.eshop.entities.User"%>
<%
    User user1 = (User) session.getAttribute("current-user");
%>
<ul class="navbar-nav ml-auto">

    <li class="nav-item active">
        <a class="nav-link" href="cart.jsp">
            <span class="fa fa-cart-plus" style="font-size: 20px;"></span> 
            <span class="cart-items"> (0) </span> Cart </a>
    </li>

    <%
        if (user1 == null) {
    %>

    <li class="nav-item active">
        <a class="nav-link" href="login.jsp"><span class="fa fa-user-circle" style="font-size: 20px;"></span> Login </a>
    </li>
    <li class="nav-item active">
        <a class="nav-link" href="register.jsp"><span class="fa fa-user-plus" style="font-size: 20px;"></span> Register </a>
    </li>

    <%
    } else {
    %>

    <li class="nav-item active">
        <a class="nav-link" href="<%=  user1.getUserType().equals("admin") ? "admin.jsp" : "normal.jsp"%>">
            <img src="components/getuserimage.jsp?id=<%=user1.getUserId()%>" class="img-fluid rounded-circle" width="25px" height="25px"/> <%= " " + user1.getFirstName()%> 
        </a>
    </li>

    <li class="nav-item active">
        <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out" style="font-size: 20px;"></span> Logout </a>
    </li>

    <%
        }
    %>
</ul>
</div>
</div>
</nav>