<%/* getting order details from order servlet */
    String status = (String) session.getAttribute("status");
    int amount = (int) session.getAttribute("amount");
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String address = (String) session.getAttribute("address");
    String id = (String) session.getAttribute("orderid");
    int nop = (int) session.getAttribute("nop");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Payment Conformation Page</title>
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
        <div class="container-fluid mt-3 mb-5">
            <!-- card for user order details -->
            <div class="card">
                <div class="card-body">
                    <table class="table">
                        <thead class="custom-bg text-white">
                            <tr>
                                <th scope="col">Field: </th>
                                <th scope="col">Value: </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">Name: </th>
                                <td><%= name%></td>
                            </tr>
                            <tr>
                                <th scope="row">Email: </th>
                                <td><%= email%></td>
                            </tr>
                            <tr>
                                <th scope="row">Phone</th>
                                <td><%= phone%></td>
                            </tr>
                            <tr>
                                <th scope="row">Address: </th>
                                <td><%= address%></td>
                            </tr>
                        </tbody>
                    </table>                      
                </div>
            </div>
            <!-- card for product order details -->
            <div class="card">
                <div class="card-body">
                    <div class="payment-body">

                    </div>
                </div>
            </div>
            <!-- card for order buttons -->
            <div class="card">
                <div class="container text-center mt-3">
                    <button class="btn btn-primary btn-lg btn-block" id="cod-button">
                        <i class="fa fa-money"></i> Cash On Delivery
                    </button>
                </div>
                <div class="container text-center mt-3 mb-3">
                    <button class="btn btn-success btn-lg btn-block" id="rzp-button1">
                        <i class="fa fa-credit-card"></i> Pay Now
                    </button>
                </div>
            </div>
        </div>
        <!-- script for razorpay API -->
        <script>
            if ("<%= status%>" === "created") {
                let options = {
                    key: "rzp_test_UmNsh5miTyVaNR",
                    amount:<%=amount%>,
                    currency: "INR",
                    name: "E-Shop",
                    decsription: "Payment for checkout",
                    image: "http://localhost:8080/E-shop/img/logo%20copy.PNG",
                    order_id: "<%= id%>",
                    handler: function (response) {
                        console.log(response.razorpay_payment_id);
                        console.log(response.razorpay_order_id);
                        console.log(response.razorpay_signature);
                        console.log("payment success!");
                        swal({
                            title: "Success!",
                            text: "Payment Success!!",
                            icon: "success",
                            type: "success"
                        }).then(function () {
                            localStorage.clear();
                            updateCart();
                            window.location = "OrderServlet?operation=update&oid=<%= id%>&payId=" + response.razorpay_payment_id + "&nop=" + <%=nop%> + "&payment_type=online";
                        });
                    },
                    "prefill": {
                        "name": "<%= name%>",
                        "email": "<%= email%>",
                        "contact": "<%= phone%>"
                    },
                    "notes": {
                        "address": "E-Shop"

                    },
                    "theme": {
                        "color": "#d45359"
                    }
                };
                var rzp = new Razorpay(options);

                rzp.on('payment.failed', function (response) {
                    consloe.log(response.error.code);
                    consloe.log(response.error.description);
                    consloe.log(response.error.source);
                    consloe.log(response.error.step);
                    consloe.log(response.error.reason);
                    consloe.log(response.error.metadata.order_id);
                    consloe.log(response.error.metadata.payment_id);
                    swal({
                        title: "Opps !!",
                        text: "Payment Failed...!!",
                        icon: "error",
                        type: "error"
                    }).then(function () {
                        window.location = "index.jsp";
                    });
                });

                document.getElementById('rzp-button1').addEventListener("click", function (e) {
                    rzp.open();
                    e.preventDefault();
                });

                document.getElementById('cod-button').addEventListener("click", function () {
                    swal({
                        title: "Success!",
                        text: "Order Success!! Product will be delivered soon",
                        icon: "success",
                        type: "success"
                    }).then(function () {
                        localStorage.clear();
                        updateCart();
                        window.location = "OrderServlet?operation=update&oid=<%= id%>&payId=null" + "&nop=" + <%=nop%> + "&payment_type=COD";
                    });
                });
            }
        </script>
    </body>
</html>
