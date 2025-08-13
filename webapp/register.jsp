<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>

        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %>
        <!-- css for registration form -->
        <link rel="stylesheet" href="css/regform.css"/>

    </head>
    <body>

        <!-- include directive to include navbar.jsp file
        which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/navbar2.jsp" %>

        <div class="container">
            <div class="row mt-5 mb-5">
                <!-- for enclosing the form in a card within the web page and place the card in middle -->
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header custom-bg text-white text-center">
                            <h3><i class="fa fa-user-plus"></i> Sign up here...</h3>
                        </div>

                        <div class="card-body px-6">
                            <div class="container-fluid">

                                <div class= "text-center">
                                    <img src="img/new.png" style="max-width:60px" class="img-fluid" alt=""/>
                                </div>
                                <!-- include dynamic message alerts -->
                                <%@include  file="components/message.jsp" %>

                                <!--  form to Register new user  -->
                                <form class="register" action="RegisterServlet" method="post" name="register_form" onsubmit="return checkData()">
                                    <div class="form-group">
                                        <label class="font-weight-bold" for="name">First Name</label>
                                        <input name="user_namef" type="text" class="form-control" id="fname" placeholder="Enter here...">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="font-weight-bold" for="name">Last Name</label>
                                        <input name="user_namel" type="text" class="form-control" id="lname" placeholder="Enter here...">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="font-weight-bold" for="email">User E-Mail</label>
                                        <input name="user_email" type="email" class="form-control" id="email" placeholder="Enter e-mail...">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="font-weight-bold" for="password">User Password</label>
                                        <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter Password here...">
                                        <!-- show and hide password image -->
                                        <div class="toggle-password">
                                            <i class="fa-regular fa-eye"></i>
                                            <i class="fa-regular fa-eye-slash"></i>
                                        </div>
                                        <!-- password policies -->
                                        <div class="password-policies">
                                            <div class="policy-length">
                                                Password must have 8 Characters
                                            </div>
                                            <div class="policy-number">
                                                Password must have a Number
                                            </div>
                                            <div class="policy-uppercase">
                                                Password must have a UpperCase Character
                                            </div>
                                            <div class="policy-special">
                                                Password must have a Special Character
                                            </div>
                                        </div>
                                        <p class="fa-solid"></p>
                                        <span class="msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="font-weight-bold" for="password">Confirm Password</label>
                                        <input name="confirm_password" type="password" class="form-control" id="passwordconfirm" placeholder="ReEnter Password here...">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="font-weight-bold" for="phone">User phone</label>
                                        <input name="user_phone" type="number" class="form-control" id="phone" placeholder="Enter Phone Number here...">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>

                                    <div class="form-group">
                                        <label class="font-weight-bold" for="address">User Address</label>
                                        <textarea name="user_address" style="height:100px" class="form-control" id="address" placeholder="Enter your address here..."></textarea>
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>
                                    <!-- redirect to login page -->
                                    <div class="text-center">
                                        <a href="login.jsp" class="badge badge-primary mb-3"> if Registered proceed to login... </a>
                                    </div>

                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-outline-success"><span class="fa fa-user-plus"></span> Register</button>
                                        <button type="reset" class="btn btn-outline-warning"><span class="fa fa-repeat fa-spin"></span> Reset</button>
                                    </div>
                                </form>    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- javascript for form validations -->
        <script src="js/regScript.js"></script>
    </body>
</html>
