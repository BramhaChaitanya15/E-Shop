<%@page import="com.mycompany.eshop.helper.Helper"%>
<%
    /*protecting admin user page from unauthorised access*/
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("errorMessage", "You are not logged in !! Login first...");
        response.sendRedirect("login.jsp");
        return;

    } else {

        if (user.getUserType().equals("normal")) {

            session.setAttribute("errorMessage", "You are not admin ! Do not access this page...");
            response.sendRedirect("normal.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Category Edit Page</title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %> 
    </head>
    <body>
        <%/* implimenting pagination page count */
            int x = 0;
            int pageCount = 9;
            int pageNo = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
            int start = pageNo * pageCount;
            /* end implimenting pagination page count */

 /* creating dao objects */
            CategoryDao catdao1 = new CategoryDao(FactoryProvider.getFactory());
            ProductDao udao1 = new ProductDao(FactoryProvider.getFactory());

            /* getting categories */
            List<Category> cl = catdao1.getCategories();
            List<Product> all = udao1.getAllProducts();
            List<Product> l = udao1.getProductForPage(start);

            x = all.size();
        %>
        <!-- include directive to include navbar.jsp file
       which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/navbar2.jsp" %>

        <!-- back button -->
        <div class="container-fluid mt-2" onclick="goToAdmin()">
            <button class="btn btn-primary"><i class="fa fa-arrow-left" aria-hidden="true"></i></button>
        </div>

        <div class="container-fluid mt-3">
            <!-- include dynamic message alerts -->
            <%@include file="components/message.jsp" %>
        </div>

        <div class="container-fluid mt-4">
            <div class="card text-center">

                <!-- table to show product details -->
                <table class="table table-striped">
                    <thead class="custom-bg text-white">
                        <tr>
                            <th scope="col">Id:</th>
                            <th scope="col">Product Title:</th>                               
                            <th scope="col">Product Description:</th>                               
                            <th scope="col">Product Price:</th>                               
                            <th scope="col">Product Discount:</th>                               
                            <th scope="col">Product Quantity:</th>                               
                            <th scope="col"></th>                               
                        </tr>
                    </thead>
                    <tbody>
                        <%for (Product p : l) {%>
                        <tr>
                            <th scope="row"><%= p.getpId()%></th>
                            <td><%= p.getpName()%></td>
                            <td><%= Helper.get10Words(p.getpDesc())%></td>                                        
                            <td>&#8377;<%= p.getpPrice()%></td>                                        
                            <td><%= p.getpDiscount()%></td>                                        
                            <td><%= p.getpQuantity()%></td>                                        
                            <td>
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#<%= p.getpName()%>">
                                    Edit Product
                                </button>
                            </td>                                        
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <!-- end of table to show product details -->

            <!-- modal to edit product details -->
            <%for (Product p : l) {%>
            <!-- editing Modal -->
            <div class="modal fade" id="<%= p.getpName()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header custom-bg">
                            <h5 class="modal-title text-white" id="exampleModalLabel">Edit<%=" " + p.getpName()%></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="AdminOperationServlet" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="operation" value="editproduct"/>
                                <div class="form-group">
                                    <input type="hidden" class="form-control" id="pro_id" name="pro_id" value="<%= p.getpId()%>">
                                </div>

                                <div class="form-group">
                                    <label class="font-weight-bold" for="pro_title">Product Title: </label>
                                    <input type="text" class="form-control" id="pro_title" name="pro_title" value="<%= p.getpName()%>">
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold" for="pro_desc">Product Description: </label>
                                    <textarea class="form-control" id="pro_desc" name="pro_desc" rows="5"><%= p.getpDesc()%></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold" for="pro_title">Product Price: </label>
                                    <input type="text" class="form-control" id="pro_price" name="pro_price" value="<%= p.getpPrice()%>">
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold" for="pro_title">Product Discount: </label>
                                    <input type="text" class="form-control" id="pro_discount" name="pro_discount" value="<%= p.getpDiscount()%>">
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold" for="pro_title">Product Quantity: </label>
                                    <input type="text" class="form-control" id="pro_quantity" name="pro_quantity" value="<%= p.getpQuantity()%>">
                                </div>
                                <div class="form-group">
                                    <label for="pPic" class="font-weight-bold">Change Primary Picture of the product :</label>  
                                    <br>
                                    <input type="file" id="pPic" name="pPic"/>
                                </div>
                                <div class="form-group">
                                    <label for="pPic2" class="font-weight-bold">Add Images for Product :</label>  
                                    <br>
                                    <input type="file" id="pPic2" name="pPic2"/>
                                </div>
                                <!--product category-->
                                <div class="form-group">
                                    <label class="font-weight-bold">Product Category</label>
                                    <select name="catId" class="form-control" id="catId">
                                        <option value="<%= p.getCategory().getCategoryId()%>" selected="true" style="background: #e2e2e2;"> <%= p.getCategory().getCategoryTitle()%> </option>
                                        <%
                                            for (Category c : cl) {
                                        %>
                                        <option value="<%= c.getCategoryId()%>"> <%= c.getCategoryTitle()%> </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-group text-center">
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
        <!-- end of modal to edit product details -->

        <!-- pagination -->
        <div class="container text-center mt-5">
            <h6 class="text-white">Page no.</h6> 
            <% for (int i = 0; i <= x / pageCount; i++) {%>
            <span class="border border-success bg-light">
                <a class="text-white" href="adminproducts.jsp?pgno=<%= i%>">
                    <img src="img/numbers/<%=i + 1%>.png" height="50" width="50" alt="<%=i + 1%>">
                </a>
            </span>
            <%}%>  
        </div>
    </body>
</html>
