/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.eshop.servlets;

import com.mycompany.eshop.dao.OrderDao;
import com.mycompany.eshop.dao.OrderDetailsDao;
import com.mycompany.eshop.dao.ProductDao;
import com.mycompany.eshop.entities.OrderDetails;
import com.mycompany.eshop.entities.Orders;
import com.mycompany.eshop.entities.Product;
import com.mycompany.eshop.entities.User;
import com.mycompany.eshop.helper.FactoryProvider;
import com.mycompany.eshop.helper.Helper;
import com.razorpay.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, RazorpayException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            //geting order operation
            String op = request.getParameter("operation");

            /*initiate order*/
            if ("initiate".equals(op)) {
                String username = request.getParameter("name");
                String userEmail = request.getParameter("user_email");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");
                int totalAmount = Integer.parseInt(request.getParameter("totalprice"));
                int nop = Integer.parseInt(request.getParameter("nop"));

                RazorpayClient client = new RazorpayClient("rzp_test_UmNsh5miTyVaNR", "EaaEVrPGVx65dKXAj6kzgCyx");

                //generating random recipt
                String receipt = "txn_" + Helper.getRandomNumberString();

                //JSON object to store the RazorPay order data
                JSONObject ob = new JSONObject();
                ob.put("amount", totalAmount * 100);
                ob.put("currency", "INR");
                ob.put("receipt", receipt);

                //creating order
                Order order = client.Orders.create(ob);

                String status = order.get("status");
                int amount = order.get("amount");
                String orderId = order.get("id");
                String orderReceipt = order.get("receipt");

                //update database
                Orders orders = new Orders();
                OrderDetails orderDetails = new OrderDetails();
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("current-user");

                orders.setAmount(amount / 100);
                orders.setOrderId(orderId);
                orders.setPaymentId(null);
                orders.setStatus(status);
                orders.setReceipt(orderReceipt);
                orders.setUser(user);
                orders.setUserName(username);

                OrderDao odao = new OrderDao(FactoryProvider.getFactory());
                int oid = odao.saveOrder(orders);

                OrderDetailsDao oddao = new OrderDetailsDao(FactoryProvider.getFactory());

                for (int i = 0; i < nop; i++) {
                    int pid = Integer.parseInt(request.getParameter("pid" + i));
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    Product p = pdao.getProductById(pid);
                    int pQuantity = Integer.parseInt(request.getParameter("pq" + i));
                    orderDetails.setoId(orders);
                    orderDetails.setOrder_Id(orderId);
                    orderDetails.setProduct_quantity(pQuantity);
                    orderDetails.setpId(p);
                    orderDetails.setUser_email(userEmail);
                    orderDetails.setUser_phno(userPhone);
                    orderDetails.setShipping_address(userAddress);
                    oddao.saveOrder(orderDetails);
                }

                //end update database
                /*once order is initiated and created the payment 
                will be confirmed by the user by online or COD 
                to the payment confirm page*/
                if ("created".equals(status)) {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("orderid", orderId);
                    httpSession.setAttribute("status", status);
                    httpSession.setAttribute("amount", amount);
                    httpSession.setAttribute("name", username);
                    httpSession.setAttribute("email", userEmail);
                    httpSession.setAttribute("phone", userPhone);
                    httpSession.setAttribute("address", userAddress);
                    httpSession.setAttribute("nop", nop);
                    out.println(order);
                    response.sendRedirect("paymentconfirm.jsp");
                }
            } else if ("update".equals(op)) {
                /*update Order details to the database once the payment option is selected*/
                String oid = request.getParameter("oid");
                String payId = request.getParameter("payId");
                String payType = request.getParameter("payment_type");
                int nop = Integer.parseInt(request.getParameter("nop"));

                OrderDao odao = new OrderDao(FactoryProvider.getFactory());
                Orders order = odao.getOrderByOrderId(oid);

                if (!"null".equals(payId)) {
                    order.setStatus("paid");
                    order.setPaymentId(payId);
                } else {
                    order.setStatus("COD");
                }
                odao.updateOrder(order);

                OrderDetailsDao oddao = new OrderDetailsDao(FactoryProvider.getFactory());
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

                for (int i = 0; i < nop; i++) {
                    List<OrderDetails> osd = oddao.getOrderDetailsByOrderId(oid);

                    OrderDetails od = osd.get(i);

                    od.setpayment_type(payType);

                    oddao.updateOrderDetails(od);

                    Product p = (Product) od.getpId();
                    int pq = p.getpQuantity();
                    int opq = od.getProduct_quantity();
                    int newPq = pq - opq;
                    p.setpQuantity(newPq);
                    pdao.updateProduct(p);
                    int pid = p.getpId();
                }

                if ("paid".equals(order.getStatus())) {

                    HttpSession httpSession = request.getSession();

                    //removing session attributes once data
                    //is saved in the database
                    httpSession.removeAttribute("status");
                    httpSession.removeAttribute("amount");
                    httpSession.removeAttribute("proId");
                    httpSession.removeAttribute("status");
                    httpSession.removeAttribute("amount");
                    httpSession.removeAttribute("id");
                    httpSession.removeAttribute("orderid");
                    httpSession.removeAttribute("nop");

                    httpSession.setAttribute("successMessage", "Payment success and product will be delivered soon...");
                    response.sendRedirect("index.jsp");
                    return;
                } else if ("COD".equals(order.getStatus())) {

                    HttpSession httpSession = request.getSession();

                    //removing session attributes once data
                    //is saved in the database
                    httpSession.removeAttribute("status");
                    httpSession.removeAttribute("amount");
                    httpSession.removeAttribute("proId");
                    httpSession.removeAttribute("status");
                    httpSession.removeAttribute("amount");
                    httpSession.removeAttribute("id");
                    httpSession.removeAttribute("orderid");
                    httpSession.removeAttribute("nop");

                    //message...
                    httpSession.setAttribute("successMessage", "Order success and product will be delivered soon...");
                    response.sendRedirect("index.jsp");
                    return;
                } else {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("errorMessage", "Something went Wrong, we will contact you soon !!!");
                    response.sendRedirect("index.jsp");
                    return;
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (RazorpayException ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (RazorpayException ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
