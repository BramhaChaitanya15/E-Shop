<%@page import="com.mycompany.eshop.dao.UserDao"%>
<%@page import="com.mycompany.eshop.helper.FactoryProvider"%>
<%@page import="com.mycompany.eshop.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.eshop.entities.Category"%>
<%@page import="com.mycompany.eshop.entities.User"%>
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
<%/* creating dao objects and gatting the user, products and categories */
    CategoryDao cdao1 = new CategoryDao(FactoryProvider.getFactory());
    List<Category> clist1 = cdao1.getCategories();

    ProductDao pdao2 = new ProductDao(FactoryProvider.getFactory());
    List<Product> plist1 = pdao2.getAllProducts();

    UserDao udao2 = new UserDao(FactoryProvider.getFactory());
    List<User> ulist = udao2.getAllUsers();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
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
        <!-- user profile card showing details -->
        <div class="card profilecard mr-2 ml-2">
            <div class="card-body text-center">
                <div class="container-fluid">
                    <img src="components/getuserimage.jsp?id=<%=user.getUserId()%>" class="img-fluid rounded-circle" data-toggle="modal" data-target="#profile-modal" width="80px" height="80px"/>
                </div>
                <h3><%= user.getFirstName()%><%= " " + user.getLastName()%></h3>
            </div>
            <div class="card-footer text-center mt-3 mb-3">
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
        <!-- end user profile card showing details -->

        <!-- profile modal for user -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered " role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <div class="container-fluid text-center">
                            <img src="components/getuserimage.jsp?id=<%=user.getUserId()%>" class="img-fluid rounded-circle" width="200px" height="200px"/>                           
                        </div>                        
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center text-uppercase">
                            <h1><%= user.getFirstName()%><%= " " + user.getLastName()%></h1>
                        </div>
                        <br>
                        <br>
                        <!-- details -->
                        <div class="container text-center" id="profile-details">
                            <table class="table">                            
                                <tbody>
                                    <tr>
                                        <th scope="row">ID :</th>
                                        <td><%= user.getUserId()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">E-Mail :</th>
                                        <td><%= user.getUserEmail()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Phone Number :</th>
                                        <td><%= user.getUserPhone()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Address :</th>
                                        <td><%= user.getUserAddress()%></td>
                                    </tr>
                                </tbody>
                            </table>
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
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-edit-modal">Edit Profile</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- end of profile modal for user -->




        <!-- designing admin page for admin -->
        <div class="container admin">

            <div class="container-fluid mt-3">
                <!-- include dynamic message alerts -->
                <%@include file="components/message.jsp" %>
            </div>

            <div class="row mt-3">
                <!-- first column -->
                <div class="col-md-4">
                    <!--first box-->
                    <div class="card" data-clickable="true" data-href="adminusers.jsp">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 80px;" class="img-fluid" src="img/group.png" alt="user_icon">
                            </div> 
                            <h1><%= ulist.size()%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>   
                <!-- second column -->
                <div class="col-md-4">
                    <div class="card" data-clickable="true" data-href="admincategories.jsp">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 80px;" class="img-fluid" src="img/shopping-list.png" alt="categories_icon">
                            </div>
                            <h1><%= clist1.size()%></h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>   
                <!-- third column -->
                <div class="col-md-4">
                    <div class="card" data-clickable="true" data-href="adminproducts.jsp">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 80px;" class="img-fluid" src="img/product.png" alt="products_icon">
                            </div>
                            <h1><%= plist1.size()%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>  
            </div>
            <!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --> 
            <!--second row-->
            <div class="row mt-3 mb-5">

                <!-- second :row first column -->
                <div class="col-md-6">

                    <!-- Card trigger modal for add category -->
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 80px;" class="img-fluid" src="img/menu.png" alt="categories_icon">
                            </div>
                            <p class="mt-2">Click here to add new category</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>

                <!-- second :row second column -->
                <div class="col-md-6">
                    <!-- Card trigger modal for add product -->
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 80px;" class="img-fluid" src="img/plus.png" alt="categories_icon">
                            </div>
                            <p class="mt-2">Click here to add new Product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- add category Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLongTitle">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- add category form -->
                        <form action="AdminOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <label class="font-weight-bold">Category Title</label>
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title here..." required />
                            </div>
                            <div class="form-group">
                                <label class="font-weight-bold">Category Description</label>
                                <textarea style="height: 300px;" class="form-control" placeholder="Enter category description here..." name="catDescription" required></textarea>
                            </div>
                            <div class="cotnainer text-center">
                                <button class="btn btn-primary">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                        <!-- add category form end -->
                    </div>
                </div>
            </div>
        </div>
        <!-- end add category modal -->

        <!-- add product Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLongTitle">Fill Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- add product form -->
                        <form action="AdminOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct"/>
                            <!--product title-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Title</label>
                                <input type="text" class="form-control" placeholder="Enter title of product" name="pName" required />
                            </div>
                            <!--product description-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Description</label>
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter product description" name="pDesc"></textarea>
                            </div>
                            <!--product price-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Price</label>
                                <input type="number" class="form-control" placeholder="Enter price of product" name="pPrice" required />
                            </div>
                            <!--product discount-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Discount</label>
                                <input type="number" class="form-control" placeholder="Enter product discount" name="pDiscount" required />
                            </div>
                            <!--product quantity-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Quantity</label>
                                <input type="number" class="form-control" placeholder="Enter product Quantity" name="pQuantity" required />
                            </div>
                            <!--product category-->
                            <div class="form-group">
                                <label class="font-weight-bold">Product Category</label>
                                <select name="catId" class="form-control" id="catId">
                                    <%
                                        for (Category c : clist1) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"> <%= c.getCategoryTitle()%> </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <!--product file-->
                            <div class="form-group">
                                <label for="pPic" class="font-weight-bold">Select Picture of the product</label>  
                                <br>
                                <input type="file" id="pPic" name="pPic" required />
                                <br>
                                <input type="file" id="pPic2" name="pPic2"/>
                                <br>
                                <input type="file" id="pPic3" name="pPic3"/>
                                <br>
                                <input type="file" id="pPic4" name="pPic4"/>
                                <br>
                                <input type="file" id="pPic5" name="pPic5"/>
                                <br>
                                <input type="file" id="pPic6" name="pPic6"/>
                            </div>

                            <!--submit button-->
                            <div class="container text-center">
                                <button class="btn btn-primary">Add product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                        <!-- add product form end -->
                    </div>
                </div>
            </div>
        </div>
        <!-- end add product modal -->


        <!-- script for user profile -->
        <script src="js/profileScript.js"></script>

        <script>
            $(document).ready(() => {
                $(document.body).on('click', '.card[data-clickable=true]', (e) => {
                    var href = $(e.currentTarget).data('href');
                    window.location = href;
                });
            });
        </script>

    </body>
</html>
