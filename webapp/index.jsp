<%@page import="com.mycompany.eshop.helper.Helper"%>
<%@page import="com.mycompany.eshop.entities.Category"%>
<%@page import="com.mycompany.eshop.dao.CategoryDao"%>
<%@page import="com.mycompany.eshop.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eshop.dao.ProductDao"%>
<%@page import="com.mycompany.eshop.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-shop_home</title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %> 

        <script>
            //making product card to redirect to product page
            $(document).ready(() => {
                $(document.body).on('click', '.card-header[data-clickable=true]', (e) => {
                    var href = $(e.currentTarget).data('href');
                    window.location = href;
                });
                $(document.body).on('click', '.card-body[data-clickable=true]', (e) => {
                    var href = $(e.currentTarget).data('href');
                    window.location = href;
                });
                $(document.body).on('click', '.card-footer[data-clickable=true]', (e) => {
                    var href = $(e.currentTarget).data('href');
                    window.location = href;
                });
                $(document.body).on('click', '.pimg[data-clickable=true]', (e) => {
                    var href = $(e.currentTarget).data('href');
                    window.location = href;
                });
            });
        </script>

    </head>
    <body>
        <!-- include directive to include navbar.jsp file
        which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <!-- product search bar -->
        <ul class="navbar-nav text-center">

            <input class="form-control mr-sm-2" type="text" id="search" placeholder="Search Products or Categories" size="40">
            <button class="btn btn-success my-2 my-sm-0" onclick="searchfunc()"><span class="fa fa-search" ></span> Search</button>

        </ul>
        <%@include file="components/navbar2.jsp" %>
        <%
            /*FactoryProvider.getFactory comes from com.mycompany.eshop.helper package
            and creates a SessionFactory object */
            FactoryProvider.getFactory();

        %>
        <div class="container-fluid">
            <!-- include dynamic message alerts -->
            <%@include file="components/message.jsp" %>
            <div class="row mt-3 mx-2">

                <%  /* implimenting pagination page count */
                    int x = 0;
                    int pageCount = 9;
                    int pageNo = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
                    int start = pageNo * pageCount;
                    /* end implimenting pagination page count */

 /* getting category id from url for showing products based on categories */
                    String cat1 = request.getParameter("category");
                    /* creating dao objects */
                    ProductDao dao1 = new ProductDao(FactoryProvider.getFactory());
                    CategoryDao cdao1 = new CategoryDao(FactoryProvider.getFactory());
                    /* getting categories */
                    List<Category> clist1 = cdao1.getCategories();

                    /* getting products */
                    List<Product> list1 = null;
                    List<Product> totalList = dao1.getAllProducts();
                    /* showing products based on categories */
                    if (cat1 == null || cat1.trim().equals("all")) {
                        list1 = dao1.getProductForPage(start);
                        x = totalList.size();
                    } else {
                        int cid1 = Integer.parseInt(cat.trim());
                        list1 = dao.getAllProductsByCatId(cid1);
                    }

                %>

                <!--show categories-->
                <div class="col-md-2">
                    <div class="list-group mt-4">

                        <span id="categoryList" class="list-group-item list-group-item-action custom-bg active">
                            <i class="fa fa-list-alt"></i> Categories
                        </span>
                        <a href="index.jsp?category=all" id="categoryList" class="list-group-item list-group-item-action">
                            All Products
                        </a>
                        <% for (Category c : clist1) {
                        %>
                        <a href="index.jsp?category=<%= c.getCategoryId()%>" id="categoryList" class="list-group-item list-group-item-action"><%= c.getCategoryTitle()%></a>
                        <%    }
                        %>

                    </div>
                </div>
                <!--end show categories-->

                <!--show Products-->
                <div class="col-md-10">
                    <div class="container-fluid">
                        <!--row-->
                        <div class="row mt-4">
                            <!--col:12-->
                            <div class="col-md-12">
                                <div class="search-product container-fluid d-none">

                                </div>
                                <div class="card-columns" id="product-cards">

                                    <%
                                        for (Product p : list1) {
                                            if (p.getpQuantity() != 0) {
                                    %>

                                    <!--product card-->
                                    <div class="card product-card">

                                        <div class="card-header panel-bg" data-clickable="true" data-href="product.jsp?product_id=<%= p.getpId()%>">
                                            <h4 class="card-title"><%= p.getpName()%></h4>
                                        </div>

                                        <div class=" pimg container text-center" data-clickable="true" data-href="product.jsp?product_id=<%= p.getpId()%>">
                                            <img src="components/getproductimage.jsp?id=<%= p.getpId()%>" style="max-height: 200px;max-width: 100%;width: auto; " class="card-img-top m-2" alt="...">
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <div class="card-body" data-clickable="true" data-href="product.jsp?product_id=<%= p.getpId()%>">

                                            <p class="card-text">
                                                <%= Helper.get10Words(p.getpDesc())%>
                                            </p>

                                        </div>

                                        <div class="card-footer panel-bg text-center">
                                            <button class="btn btn-primary text-white" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>',<%= p.getPriceAfterApplyingDiscount()%>, <%= p.getpQuantity()%>, 1)">Add to Cart</button>
                                            <button class="btn btn-outline-success" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>',<%= p.getPriceAfterApplyingDiscount()%>, <%= p.getpQuantity()%>, 1), goToCheckout()"> 
                                                &#8377; <%= p.getPriceAfterApplyingDiscount()%>/- 
                                                <span class="text-secondary discount-label">  &#8377; <%= p.getpPrice()%></span> ,
                                                <span class="text-secondary"><%= p.getpDiscount()%>% off </span>
                                            </button>
                                        </div>

                                    </div>
                                    <%      }
                                        }

                                        if (list1.size() == 0) {
                                            out.println("<h3>No item in this category</h3>");
                                        }
                                    %>                               
                                </div>
                                <%if (cat1 == null || cat1.trim().equals("all")) {%>
                                <div class="container text-center" id="page">
                                    <h6 class="text-white">Page no.</h6>
                                    <% for (int i = 0; i <= x / pageCount; i++) {%>
                                    <span class="border border-success bg-light">
                                        <a class="text-white" href="index.jsp?pgno=<%= i%>">
                                            <img src="img/numbers/<%=i + 1%>.png" height="50" width="50" alt="<%=i + 1%>">
                                        </a>
                                    </span>
                                    <%}%>  
                                </div>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end show Products-->
            </div>
        </div>
        <!-- script for searching products -->
        <script>
            function searchfunc() {
                //get element that is being searched
                let filter = document.getElementById('search').value.toUpperCase().trim();

                //arrays for storing database details
                let proName = [];
                let pn = [];
                let proId = [];
                let pid = [];
                let proPrice = [];
                let pprice = [];
                let calcPrice = [];
                let calprice = [];
                let proDiscount = [];
                let pdiscount = [];
                let proQuantity = [];
                let pquantity = [];

                let catName = [];
                let cn;
                let catId = [];
                let cid;
                //storing data in arrays
            <%for (Product p : totalList) {%>
                proId.push("<%=p.getpId()%>");
                proName.push("<%=p.getpName()%>");
                proPrice.push("<%=p.getpPrice()%>");
                calcPrice.push("<%=p.getPriceAfterApplyingDiscount()%>");
                proDiscount.push("<%=p.getpDiscount()%>");
                proQuantity.push("<%=p.getpQuantity()%>");
            <%}%>

            <% for (Category c : clist1) {%>
                catName.push("<%=c.getCategoryTitle()%>");
                catId.push("<%=c.getCategoryId()%>");
            <%}%>

                //loop for transversing arrays
                for (var i = 0; i < catName.length; i++) {
                    let name = catName[i].toUpperCase();
                    //condition to find a match
                    if (name.indexOf(filter) > -1 && filter !== "") {
                        cid = catId[i];
                        cn = catName[i];
                        window.location.replace("index.jsp?category=" + cid);
                    } else {
                        $('.search-product').removeClass('d-none');
                        $('.search-product').html(`<h3> No items here </h3>`);
                    }
                }

                //loop for transversing arrays
                for (var i = 0; i < proName.length; i++) {
                    let name = proName[i].toUpperCase();
                    //condition to find a match
                    if (name.indexOf(filter) > -1 && filter !== "") {
                        pn.push(proName[i]);
                        pid.push(proId[i]);
                        pprice.push(proPrice[i]);
                        pdiscount.push(proDiscount[i]);
                        calprice.push(calcPrice[i]);
                        pquantity.push(proQuantity[i]);

                        $('#product-cards').addClass('d-none');
                        $('#page').addClass('d-none');
                        $('.search-product').removeClass('d-none');
                    } else {
                        $('.search-product').removeClass('d-none');
                        $('.search-product').html(`<h3> No items here </h3>`);
                    }
                }
                let searchCard = `<div class="card-columns search-cards">`;
                //dynamically inserting searched data to the index page
                for (var i = 0; i < pn.length; i++) {

                    searchCard += `<div class="card product-card">
                    
                                        <div class="card-header panel-bg" data-clickable="true" data-href="product.jsp?product_id=` + pid[i] + `">
                                            <h4 class="card-title">` + pn[i] + `</h4>
                                        </div>

                                        <div class=" pimg card-body container text-center" data-clickable="true" data-href="product.jsp?product_id=` + pid[i] + `">
                                            <img src="components/getproductimage.jsp?id=` + pid[i] + `" style="max-height: 200px;max-width: 100%;width: auto; " class="card-img-top m-2" alt="...">
                                        </div>
        
                                        <div class="card-footer panel-bg text-center">
                                            <button class="btn btn-primary text-white" onclick="add_to_cart(` + pid[i] + `,` + pn[i] + `,` + calprice[i] + `,` + pquantity[i] + `, 1` + `)">Add to Cart</button>
                                            <button class="btn btn-outline-success" onclick="add_to_cart(` + pid[i] + `,` + pn[i] + `,` + calprice[i] + `,` + pquantity[i] + `, 1` + `), goToCheckout()"> 
                                                &#8377; ` + calprice[i] + `/- 
                                                <span class="text-secondary discount-label">  &#8377; ` + pprice[i] + `</span> ,
                                                <span class="text-secondary">` + pdiscount[i] + `% off </span>
                                            </button>
                                        </div>
                                    </div>`;
                }
                searchCard += `</div>`;
                if (pn.length !== 0) {
                    $('.search-product').html(searchCard);
                } else {
                    $('.search-product').html(`<h3> No items here </h3>`);
                }
            }
        </script>
        <!--toast-->
        <div id="toast">This is our custom Toast text</div>
    </body>
</html>
