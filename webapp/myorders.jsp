<%@page import="com.mycompany.eshop.dao.OrderDetailsDao"%>
<%@page import="com.mycompany.eshop.entities.OrderDetails"%>
<%@page import="com.mycompany.eshop.dao.OrderDao"%>
<%@page import="com.mycompany.eshop.entities.Orders"%>
<%@page import="com.mycompany.eshop.entities.User"%>
<%
    /*protecting page from unauthorised access*/
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("errorMessage", "You are not logged in !! Login first...");
        response.sendRedirect("login.jsp");
        return;

    }

    int i = 0;

    /* creating dao objects */
    OrderDao odao = new OrderDao(FactoryProvider.getFactory());
    OrderDetailsDao oddao = new OrderDetailsDao(FactoryProvider.getFactory());

    /* getting order details */
    List<Orders> olist = odao.getOrderDetailsByUserId(user);
    List<OrderDetails> odlist = null;

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Orders of <%=user.getFirstName()%></title>
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
        <!-- back button -->
        <%if (user.getUserType().equals("admin")) {%>
        <div class="container-fluid mt-2 mb-2" onclick="goToAdmin()">
            <button class="btn btn-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i></button>
        </div>
        <%} else if (user.getUserType().equals("normal")) {%>
        <div class="container-fluid mt-2 mb-2" onclick="goToNormal()">
            <button class="btn btn-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i></button>
        </div>
        <%}%>
        <div class="container-fluid">
            <div class="card">
                <%if (olist.size() == 0) {%>
                <div class="custom-bg text-white text-center">
                    <h2>No Orders Made Yet...</h2>
                </div>
                <%} else {%>
                <!-- table to show orders -->
                <table class="table">
                    <thead class="custom-bg text-white">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name On Order</th>
                            <th scope="col">Order Id</th>
                            <th scope="col">Total Amount</th>
                            <th scope="col">Receipt</th>
                            <th scope="col">Payment Type</th>
                            <th scope="col">Product Names</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%for (Orders o : olist) {
                                i++;
                                odlist = oddao.getOrderDetailsByOrderId(o.getOrderId());%>
                        <tr>
                            <th scope="row"><%=i%></th>
                            <td><%=o.getUserName()%></td>
                            <td><%=o.getOrderId()%></td>
                            <td>&#8377;<%=o.getAmount()%></td>
                            <td><%=o.getReceipt()%></td>
                            <td><%for (OrderDetails od : odlist) {%><%=od.getpayment_type()%><br>
                                <%if (odlist.size() > 1) {%>
                                <div class="dropdown-divider"></div>
                                <%    }
                                    }%>
                            </td>
                            <td><%for (OrderDetails od : odlist) {%><%=od.getpId().getpName()%><br>
                                <%if (odlist.size() > 1) {%>
                                <div class="dropdown-divider"></div>
                                <%    }
                                    }%>
                            </td>
                            <td><%for (OrderDetails od : odlist) {%><%=od.getProduct_quantity()%><br>
                                <%if (odlist.size() > 1) {%>
                                <div class="dropdown-divider"></div>
                                <%    }
                                    }%>
                            </td>
                            <td><%for (OrderDetails od : odlist) {%>&#8377;<%=od.getpId().getpPrice()%><br>
                                <%if (odlist.size() > 1) {%>
                                <div class="dropdown-divider"></div>
                                <%    }
                                    }%>
                            </td>
                        </tr>
                        <%}
                            }%>
                    </tbody>
                </table>
                <!-- end of table to show orders -->
            </div>
        </div>
    </body>
</html>
