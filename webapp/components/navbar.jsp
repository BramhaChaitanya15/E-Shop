<%@page import="com.mycompany.eshop.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eshop.helper.FactoryProvider"%>
<%@page import="com.mycompany.eshop.dao.ProductDao"%>
<%@page import="com.mycompany.eshop.entities.Category"%>
<%@page import="com.mycompany.eshop.entities.Product"%>

<!-- navbar page(part1) for the website -->

<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
    <div class="container-fluid">
        <!-- logo on navbar -->
        <a class="navbar-brand" href="index.jsp">
            <img src="img/logo copy.PNG" width="80px" height="30px" alt="logo"/>
        </a>
        <!-- toggler icon for small screens on navbar -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <!-- home link on navbar -->
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp"><span class="fa fa-home" style="font-size: 20px;"></span> Home <span class="sr-only">(current)</span></a>     
                </li>

                <!-- categories dropdown on navbar -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-list"></i> Categories
                    </a>

                    <%
                        String cat = request.getParameter("category");
                        ProductDao dao = new ProductDao(FactoryProvider.getFactory());

                        List<Product> list = null;
                        if (cat == null || cat.trim().equals("all")) {
                            list = dao.getAllProducts();

                        } else {

                            int cid = Integer.parseInt(cat.trim());
                            list = dao.getAllProductsByCatId(cid);

                        }

                        CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                        List<Category> clist = cdao.getCategories();
                    %>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <% for (Category c : clist) {
                        %>
                        <a href="index.jsp?category=<%= c.getCategoryId()%>" class="dropdown-item" href="#"><%= c.getCategoryTitle()%></a>                   
                        <%    }
                        %>   
                    </div>
                </li>

                <!-- about us link on navbar -->
                <li class="nav-item active">
                    <a class="nav-link" href="about.jsp"><span class="fa fa-address-card" style="font-size: 20px;"></span> About Us <span class="sr-only">(current)</span></a>     
                </li>

            </ul>


