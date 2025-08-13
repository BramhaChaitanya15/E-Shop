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
            int pageCount = 5;
            int pageNo = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
            int start = pageNo * pageCount;
            /* end implimenting pagination page count */

 /* creating dao objects */
            CategoryDao catdao1 = new CategoryDao(FactoryProvider.getFactory());
            ProductDao prodao = new ProductDao(FactoryProvider.getFactory());
            /* getting categories */
            List<Category> l = catdao1.getCategoriesPerPage(start);
            List<Category> all = catdao1.getCategories();
            List<Product> plist = null;
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

                <!-- table to show category details -->
                <table class="table table-striped">
                    <thead class="custom-bg text-white">
                        <tr>
                            <th scope="col">Id : </th>
                            <th scope="col">Category Title : </th>                               
                            <th scope="col">Category Description : </th>                               
                            <th scope="col"></th>                               
                        </tr>
                    </thead>
                    <tbody>
                        <%for (Category c : l) {%>
                        <tr>
                            <th scope="row"><%= c.getCategoryId()%></th>
                            <td><%= c.getCategoryTitle()%></td>
                            <td><%= c.getCategoryDescription()%></td>                                        
                            <td>
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#<%= c.getCategoryTitle()%>">
                                    Edit Category
                                </button>
                            </td>                                        
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <!-- end of table to show category details -->

            <!-- modal to edit category details -->
            <%for (Category c : l) {%>
            <!-- editing Modal -->
            <div class="modal fade" id="<%= c.getCategoryTitle()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header custom-bg">
                            <h5 class="modal-title text-white" id="exampleModalLabel">Edit<%=" " + c.getCategoryTitle() + " "%>Category</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="AdminOperationServlet" method="post">
                                <input type="hidden" name="operation" value="editcategory"/>
                                <div class="form-group">
                                    <input type="hidden" class="form-control" id="cat_id" name="cat_id" value="<%= c.getCategoryId()%>">
                                </div>

                                <div class="form-group">
                                    <label class="font-weight-bold" for="cat_title">Category Title: </label>
                                    <input type="text" class="form-control" id="cat_title" name="cat_title" value="<%= c.getCategoryTitle()%>">
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold" for="cat_desc">Category Description: </label>
                                    <textarea class="form-control" id="cat_desc" name="cat_desc" rows="3"><%= c.getCategoryDescription()%></textarea>
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
        <!-- end of modal to edit category details -->

        <!-- pagination -->
        <div class="container text-center mt-5">
            <h6 class="text-white">Page no.</h6>
            <% for (int i = 0; i <= x / pageCount; i++) {%>
            <span class="border border-success bg-light">
                <a class="text-white" href="admincategories.jsp?pgno=<%= i%>">
                    <img src="img/numbers/<%=i + 1%>.png" height="50" width="50" alt="<%=i + 1%>">
                </a>
            </span>
            <%}%>  
        </div>
    </body>
</html>
