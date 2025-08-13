<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About Us</title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <!-- include directive to include navbar.jsp file
        which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/navbar2.jsp" %>

        <div class="container-fluid">
            <!-- card for about us page -->
            <div class="card mt-3 mb-5">
                <div class="card-header about-bg">
                    <div class="row">
                        <div class="col-md-4 ml-auto mt-3">
                            <img src="img/logo.png" width="150" height="60" alt="logo"/>
                        </div>
                        <div class="col-md-4 text-center">
                            <h1 style="font-family: 'Brush Script MT', cursive; color: #996600; font-size: 80px;">About Us</h1>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <div class="card panel-bg">
                                    <div class="row">
                                        <div class="col-md-3 mt-2 mb-2 text-center">
                                            <img src="img/trust_marks/Fee_Shipping_Badge.png" width="85" height="85" alt="logo"/>
                                        </div>
                                        <div class="col-md-3 mt-2 mb-2 text-center">
                                            <img src="img/trust_marks/Premium_Quality_Badge.png" width="105" height="85" alt="logo"/>
                                        </div>
                                        <div class="col-md-3 mt-2 mb-2 text-center">
                                            <img src="img/trust_marks/Money-back_Guarantee_Badge.png" width="85" height="85" alt="logo"/>
                                        </div>
                                        <div class="col-md-3 mt-2 mb-2 text-center">
                                            <img src="img/trust_marks/Secure_Payment_Badge.png" width="85" height="85" alt="logo"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-7">
                                <!-- card for our goals -->
                                <div class="card bg-warning text-center">
                                    <br>
                                    <h3>Our Goal : </h3>
                                    <p>
                                        We are here to provide online products at a very affordable price,<br>
                                        with a variety of products and convenient methods of payments,<br>
                                        by your fingertips, at your doorsteps.
                                    </p>
                                    <br>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <!-- card for visions -->
                                <div class="card bg-success text-white text-center">
                                    <br>
                                    <h3>Vision : </h3>
                                    <p>
                                        Our future scope aims at a serving you better with every <br>
                                        passing hour. All the positive and negative reviews are most<br>
                                        welcome.
                                    </p>
                                    <br>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-4 mt-4">
                                <!-- card for targets -->
                                <div class="card bg-light text-center ">
                                    <br><br>
                                    <h3>Target : </h3>
                                    <p>
                                        We have Products of multiple Categories,<br>
                                        such as laptops, mobile phones, etc.,<br>
                                        which can be visited by a colossal <br>
                                        number of customers simultaneously.
                                    </p>
                                    <br><br>
                                </div>
                            </div>
                            <div class="col-md-8 mt-2">
                                <div class="row-md-8">
                                    <!-- card for core values -->
                                    <div class="card bg-primary text-white text-center">
                                        <br>
                                        <h3>Core Value : </h3>
                                        <p>
                                            We offer generous discount on every products, along with free shipping.
                                        </p>
                                        <br>
                                    </div>
                                </div>
                                <div class="row-md-8 mt-3">
                                    <!-- card for history -->
                                    <div class="card bg-danger text-white text-center">
                                        <br>
                                        <h3>History : </h3>
                                        <p>
                                            This website was created on November,2022 keeping in mind to keep growing a an online marketing giant.
                                        </p>
                                        <br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end of about us card  -->
                <!-- contact and other links
                links can be added to the href elements of <a> tags -->
                <div class="card-footer about-bg">
                    <div class="container-fluid">
                        <div class="row ml-2">
                            <h4>Our Contacts:</h4>
                        </div>
                        <div class="row ml-5">
                            <p>For any querries contact us at the given links below...</p>
                        </div>
                        <div class="dropdown-divider"></div>
                        <div class="row mt-3">
                            <div class="col ml-auto text-center">
                                <a href="#" class="badge badge-success"><i class="fa fa-whatsapp fa-2x text-white"></i> +91 7004291095</a>
                            </div>
                            <div class="col ml-auto text-center">
                                <a href="#" class="badge badge-primary"><i class="fa fa-facebook-official fa-2x text-white"></i> E-shop Official</a>
                            </div>
                            <div class="col ml-auto text-center">
                                <a href="#" class="badge badge-danger"><i class="fa fa-instagram fa-2x text-white"></i> _E_Shop_Official</a>
                            </div>
                            <div class="col ml-auto text-center">
                                <a href="#" class="badge badge-primary"><i class="fa fa-twitter-square fa-2x text-white"></i> @E_Shop</a>
                            </div>
                        </div>
                        <div class="dropdown-divider"></div>
                        <div class="container text-right">
                            <h4>Trust Mark : <img src="img/trust_marks/VeriSign.png" width="150" height="60" alt="VeriSign..."></h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
