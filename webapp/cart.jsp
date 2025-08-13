<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>
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
            <div class="row mt-5">                
                <!-- cart details -->
                <div class="col">
                    <!--cart-->
                    <div class="card">
                        <div class="card-header custom-bg text-white">
                            <h3 class="text-center mb-5">Your selected items</h3>
                        </div>
                        <div class="card-body">

                            <!-- dynamic cart body from java script -->
                            <div class="cart-body">

                            </div>

                        </div>
                        <div class="card-footer text-center">
                            <!-- button to go to checkout page -->
                            <button class="btn btn-primary checkout-btn" onclick="goToCheckout()">
                                Checkout
                            </button>
                            <!-- button to go to index page -->
                            <button type="button" class="btn btn-outline-primary" onclick="goToIndex()">
                                Continue Shopping
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<!--toast-->

<div id="toast">This is our custom Toast text</div>