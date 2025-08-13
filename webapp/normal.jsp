<%@page import="com.mycompany.eshop.entities.User"%>
<%
    /*protecting normal user page from unauthorised access*/
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("errorMessage", "You are not logged in !! Login first...");
        response.sendRedirect("login.jsp");
        return;

    } else {

        if (user.getUserType().equals("admin")) {

            session.setAttribute("errorMessage", "You are not normal user ! Do not access this page...");
            response.sendRedirect("admin.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Panel</title>
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

        <!-- include dynamic message alerts -->
        <%@include  file="components/message.jsp" %>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <!-- for enclosing the user card -->
                    <div class="card mt-3">

                        <div class="card-header custom-bg text-white text-center">
                            <div class="container-fluid text-center">
                                <img src="components/getuserimage.jsp?id=<%=user.getUserId()%>" class="img-fluid rounded-circle" width="200px" height="200px"/>                           
                            </div>
                        </div>

                        <div class="card-body">                            
                            <div class ="container-fluid">
                                <div class="container text-center text-uppercase">
                                    <h1><%= user.getFirstName()%><%= " " + user.getLastName()%></h1>
                                </div>
                                <br>
                                <br>
                                <!-- details -->
                                <div class="container text-center" id="profile-details">
                                    <table class="table">                            
                                        <tbody>
                                            <tr class="table-success">
                                                <th scope="row">ID :</th>
                                                <td><%= user.getUserId()%></td>
                                            </tr>
                                            <tr class="table-success">
                                                <th scope="row">E-Mail :</th>
                                                <td><%= user.getUserEmail()%></td>
                                            </tr>
                                            <tr class="table-success">
                                                <th scope="row">Phone Number :</th>
                                                <td><%= user.getUserPhone()%></td>
                                            </tr>
                                            <tr class="table-success">
                                                <th scope="row">Address :</th>
                                                <td><%= user.getUserAddress()%></td>
                                            </tr>
                                        </tbody>                                    
                                    </table>
                                    <div class="container mt-2 mb-2">
                                        <button class="btn btn-warning mr-sm-2">
                                            <a class="nav-link text-white" href="myorders.jsp?uid=<%=user.getUserId()%>">
                                                <span class="fa fa-shopping-cart" style="font-size: 20px;"></span> My Orders 
                                            </a>
                                        </button>
                                        <button class="btn btn-primary my-2 my-sm-0">
                                            <a class="nav-link text-white" href="LogoutServlet">
                                                <span class="fa fa-sign-out" style="font-size: 20px;"></span> Logout 
                                            </a>
                                        </button>
                                    </div>
                                </div>
                                <!-- end details -->

                                <!-- edit details -->                         
                                <div class="container text-center" id="profile-edit" style="display: none;">
                                    <h3 class="mt-2">Please Edit Carefully...</h3>

                                    <form action="UserEditServlet" method="post" enctype="multipart/form-data">
                                        <table class="table">
                                            <tr>
                                                <td>ID :</td>
                                                <td><%= user.getUserId()%></td>
                                            </tr>
                                            <tr>
                                                <td>User Type :</td>
                                                <td><%= user.getUserType()%></td>
                                            </tr>
                                            <tr>
                                                <td>First Name :</td>
                                                <td><input type="text" class="form-control" name="user_fname" value="<%= user.getFirstName()%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Last Name :</td>
                                                <td><input type="text" class="form-control" name="user_lname" value="<%= user.getLastName()%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>E-Mail :</td>
                                                <td><input type="text" class="form-control" name="user_email" value="<%= user.getUserEmail()%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Phone number :</td>
                                                <td><input type="text" class="form-control" name="user_phone" value="<%= user.getUserPhone()%>"/></td>
                                            </tr>
                                            <tr>
                                                <td>Address :</td>
                                                <td>
                                                    <textarea rows="3" class="form-control" name="user_address"><%= user.getUserAddress()%></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>New Profile Image :</td>
                                                <td><input type="file" id="image" name="image" class="form-control"/></td>
                                            </tr>
                                        </table>
                                        <div class="container">
                                            <button type="submit" class="btn btn-outline-primary">Save</button>
                                        </div>
                                    </form>
                                </div>
                                <!-- end edit details --> 
                            </div>
                            <div class="card-footer text-right">
                                <button id="edit-profile-button" type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-edit-modal">Edit Profile</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- script for user profile -->
        <script src="js/profileScript.js"></script>
    </body>
</html>
