<%@page import="com.mycompany.eshop.dao.UserDao"%>

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
        <title>Admin User View Page</title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %> 
    </head>
    <body>
        <%/* implimenting pagination page count */
            int x = 0;
            int pageCount = 8;
            int pageNo = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
            int start = pageNo * pageCount;
            /* end implimenting pagination page count */

 /* creating dao objects */
            UserDao udao1 = new UserDao(FactoryProvider.getFactory());
            /* getting categories */
            List<User> l = udao1.getAllUsersPerPage(start);
            List<User> all = udao1.getAllUsers();

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
        <div class="container-fluid mt-4">
            <!-- include dynamic message alerts -->
            <%@include file="components/message.jsp" %>
            <div class="card mt-3 text-center">

                <!-- table to show user details -->
                <table class="table table-striped">
                    <thead class="custom-bg text-white">
                        <tr>
                            <th scope="col">Id : </th>
                            <th scope="col">User Name : </th>
                            <th scope="col">Email : </th>
                            <th scope="col">Phone No. : </th>
                            <th scope="col">User Type : </th>                               
                            <th scope="col"></th>                               
                        </tr>
                    </thead>
                    <tbody>
                        <%for (User u : l) {%>
                        <tr>
                            <th scope="row"><%= u.getUserId()%></th>
                            <td><%= u.getFirstName()%><%= " " + u.getLastName()%></td>
                            <td><%= u.getUserEmail()%></td>
                            <td><%= u.getUserPhone()%></td>
                            <td><%= u.getUserType()%></td>                                         
                            <td>
                                <%if (u.getUserId() != user.getUserId()) {%>
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#<%= u.getUserId()%>">
                                    Change User Type
                                </button>
                                <%} else {%>
                                <!-- Button trigger modal -->
                                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#<%= u.getUserId()%>" disabled="true">
                                    Change User Type
                                </button>
                                <%}%>
                            </td>                                         
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- end of table to show user details -->

        <!-- modal to edit user type details -->
        <%for (User u : l) {%>
        <!-- editing Modal -->
        <div class="modal fade" id="<%=u.getUserId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg">
                        <h5 class="modal-title text-white" id="exampleModalLabel">Edit<%=" " + u.getFirstName() + "'s" + " "%>User Type</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="AdminOperationServlet?user_id=<%=u.getUserId()%>" method="post">
                            <input type="hidden" name="operation" value="editusertype"/>
                            <label class="font-weight-bold" for="usertype">Select User Type : </label>

                            <select class="form-control" id="user_type" name="user_type">
                                <%if (u.getUserType().equals("admin")) {%>
                                <option value="admin" selected="true">admin</option>
                                <option value="normal">normal</option>
                                <%} else if (u.getUserType().equals("normal")) {%>
                                <option value="admin">admin</option>
                                <option value="normal" selected="true">normal</option>
                                <%}%>
                            </select>

                            <div class="container text-center mt-2">
                                <button type="submit" class="btn btn-primary">Change Type</button>
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
        <!-- end of modal to edit user type details -->

        <!-- pagination -->
        <div class="container text-center mt-5">
            <h6 class="text-white">Page no.</h6> 
            <% for (int i = 0; i <= x / pageCount; i++) {%>
            <span class="border border-success bg-light">
                <a class="text-white" href="adminusers.jsp?pgno=<%= i%>">
                    <img src="img/numbers/<%=i + 1%>.png" height="50" width="50" alt="<%=i + 1%>">
                </a>
            </span>
            <%}%>  
        </div>
    </body>
</html>
