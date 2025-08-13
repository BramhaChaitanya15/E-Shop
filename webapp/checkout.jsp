<%
    /*checking for login user*/
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("warMessage", "You are not logged in !! Login first to access checkout page...");
        response.sendRedirect("login.jsp");
        return;
    }
    int nop = Integer.parseInt(request.getParameter("noOfProducts"));
%>
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
                <div class="col-md-6 mb-5">
                    <!--cart-->
                    <div class="card">
                        <div class="card-header custom-bg text-white">
                            <h3 class="text-center mb-5">Your selected items</h3>
                        </div>
                        <div class="card-body">

                            <!-- dynamic selected product details from java script -->
                            <div class="payment-body">

                            </div>

                        </div>
                    </div>
                </div>
                <!-- user details -->
                <div class="col-md-6 mb-5">
                    <!-- user -->
                    <div class="card">
                        <div class="card-header custom-bg text-white">
                            <h3 class="text-center mb-5">Your Details for Order</h3>
                        </div>
                        <div class="card-body">

                            <!-- form to save user details for the order -->
                            <form action="OrderServlet?operation=initiate" method="post">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input value="<%= user.getUserEmail()%>" type="email" name="user_email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="name">Your name</label>
                                    <input value="<%= user.getFirstName() + " " + user.getLastName()%>" name="name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>

                                <div class="form-group">
                                    <label for="name">Your contact</label>
                                    <input value="<%= user.getUserPhone()%>" type="text" name="user_phone" class="form-control" id="phone" aria-describedby="emailHelp" placeholder="Enter contact number">
                                </div>

                                <div class="form-group">
                                    <label for="exampleFormControlTextarea1" >Your shipping address</label>
                                    <textarea class="form-control" name="user_address" id="address" placeholder="Enter your address" rows="3"><%= user.getUserAddress()%></textarea>
                                </div>

                                <div class="form-group">
                                    <textarea class="form-control" name="totalprice" id="totalprice" rows="1" hidden="true"></textarea>
                                </div>

                                <div class="form-group">
                                    <textarea class="form-control" name="nop" id="nop" rows="1" hidden="true"></textarea>
                                </div>
                                <%for (int i = 0; i < nop; i++) {%>
                                <div class="form-group">
                                    <textarea class="form-control" name="pid<%=i%>" id="pid<%=i%>" rows="1" hidden="true"></textarea>
                                </div>
                                <div class="form-group">
                                    <textarea class="form-control" name="pq<%=i%>" id="pq<%=i%>" rows="1" hidden="true"></textarea>
                                </div>

                                <%}%>

                                <div class="form-group container text-center">
                                    <button class="btn btn-outline-success order-btn" onclick="paymentStart()">Order Now</button>
                                    <button type="button" class="btn btn-outline-primary" onclick="goToIndex()">Continue Shopping</button>
                                </div>

                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
