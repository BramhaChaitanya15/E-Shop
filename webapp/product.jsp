<%@page import="com.mycompany.eshop.dao.ProductImageDao"%>
<%@page import="com.mycompany.eshop.entities.ProductImage"%>
<%/* get product id from url */
    int pId = Integer.parseInt(request.getParameter("product_id"));

    /* creatin dao objects */
    ProductDao pdao2 = new ProductDao(FactoryProvider.getFactory());
    ProductImageDao pidao = new ProductImageDao(FactoryProvider.getFactory());
    /* getting product and product images */
    Product p1 = pdao2.getProductById(pId);
    List<ProductImage> pilist = pidao.getAllProductImgById(pId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p1.getpName()%></title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %> 
        <!-- css for product page -->
        <link rel="stylesheet" href="css/product.css"/>
    </head>
    <body>
        <!-- include directive to include navbar.jsp file
        which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/navbar2.jsp" %>
        <div class="container-fluid mb-5">
            <div class="row mt-5">
                <!-- product image column -->
                <div class="col-md-5">
                    <div class="card">
                        <!-- bootstrap carousel for showing product images -->
                        <div id="carouselProductIndicators" class="carousel slide" data-ride="carousel">
                            <div class="card-body">
                                <div class="container">
                                    <div class="carousel-inner">
                                        <%                                    for (int i = 0; i < pilist.size(); i++) {
                                                if (i == 0) {
                                        %>
                                        <div class="carousel-item text-center active">
                                            <img src="components/getallproductimage.jsp?id=<%= pilist.get(0).getProductImgId()%>" style="max-height: 230px;max-width: 100%;width: auto;">
                                        </div>
                                        <%      } else {%>
                                        <div class="carousel-item text-center">
                                            <img src="components/getallproductimage.jsp?id=<%= pilist.get(i).getProductImgId()%>" style="max-height: 230px;max-width: 100%;width: auto;">
                                        </div>
                                        <%      }
                                            }
                                        %>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="container-fluid mt-4">
                                        <div class="carousel-indicators btm-slider">
                                            <%
                                                for (int i = 0; i < pilist.size(); i++) {
                                                    if (i == 0) {
                                            %>
                                            <span data-target="#carouselProductIndicators" data-slide-to="0" class="active">
                                                <img src="components/getallproductimage.jsp?id=<%= pilist.get(0).getProductImgId()%>">
                                            </span>
                                            <%      } else {%>

                                            <span data-target="#carouselProductIndicators" data-slide-to="<%= i%>">
                                                <img src="components/getallproductimage.jsp?id=<%= pilist.get(i).getProductImgId()%>">
                                            </span>

                                            <%      }
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>

                                <a class="carousel-control-prev" href="#carouselProductIndicators" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselProductIndicators" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </div>
                        <!-- end of bootstrap carousel for showing product images -->
                        <!-- card footer having add to cart and buy now buttons -->
                        <div class="card-footer">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item text-center">
                                    <h3>Product Quantity: </h3>
                                    <div class="scroller">
                                        <span class="text-secondary minus">-</span>
                                        <span class="text-primary num" id="num">1</span>
                                        <span class="text-secondary plus">+</span>
                                    </div>
                                </li>
                                <li class="list-group-item text-center">
                                    <button class="btn btn-primary text-white" onclick="addToCart(<%= p1.getpId()%>, '<%= p1.getpName()%>',<%= p1.getPriceAfterApplyingDiscount()%>, <%= p1.getpQuantity()%>)">
                                        Add to Cart
                                    </button>
                                    <button class="btn btn-outline-success" onclick="addToCart(<%= p1.getpId()%>, '<%= p1.getpName()%>',<%= p1.getPriceAfterApplyingDiscount()%>, <%= p1.getpQuantity()%>), goToCheckout()"> 
                                        Buy Now
                                    </button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- end of product image card -->
                </div>
                <!-- end product image column -->
                <!-- product details column -->
                <div class="col-md-7">
                    <div class="card">
                        <div class="card-header text-center custom-bg text-white">
                            <h2><%= p1.getpName()%></h2>
                        </div>
                        <div class="card-body">    
                            <ul class="list-group list-group-flush">                            
                                <li class="list-group-item">
                                    <h3>Product Price: </h3>
                                    <h4>&#8377; <%= p1.getPriceAfterApplyingDiscount()%>/- </h4>
                                    <small class="text-secondary discount-label">  &#8377; <%= p1.getpPrice()%></small> ,
                                    <span class="text-success"><%= p1.getpDiscount()%>% off </span>
                                    <br>
                                    <%if (p1.getpQuantity() <= 5) {%>
                                    <span class="text-danger">Hurry Up only<%= " " + p1.getpQuantity() + " "%>left!</span>
                                    <span class="text-danger" id="q" hidden="true"><%= p1.getpQuantity()%></span>
                                    <%} else {%>
                                    <span class="text-primary">In Stock :</span>
                                    <span class="text-primary" id="q"><%=p1.getpQuantity()%></span>
                                    <%}%>
                                </li>
                                <li class="list-group-item">
                                    <h3>Product Description: </h3>
                                    <p><%= p1.getpDesc()%></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- end product details column -->
            </div>
        </div>                       
        <!--toast-->

        <div id="toast">This is our custom Toast text</div>
    </body>
</html>
