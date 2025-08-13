<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <!-- include directive to include common_css_js.jsp file
             which has all common JavaScript and Cascading Style Sheets
             including bootstraps and defined --> 
        <%@include file="components/common_css_js.jsp" %>
        <!-- css for login form -->
        <link rel="stylesheet" href="css/logincss.css"/>
    </head>
    <body>
        <!-- include directive to include navbar.jsp file
        which has the bootstrap navbar in it -->
        <%@include file="components/navbar.jsp" %>
        <%@include file="components/navbar2.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <!-- for enclosing the form in a card within the web page and place the card in middle -->
                    <div class="card mt-3">

                        <div class="card-header custom-bg text-white text-center">
                            <h3><i class="fa fa-user-circle fa-spin"></i> Login here...</h3>
                        </div>

                        <div class="card-body">                            
                            <div class ="container-fluid">
                                <!-- include dynamic message alerts -->
                                <%@include file="components/message.jsp" %>

                                <!-- form for user login -->
                                <form class="register" action="LoginServlet" method="post" onsubmit="return validate()">
                                    <div class="form-group">
                                        <label class="font-weight-bold" for="exampleInputEmail1">Email address</label>
                                        <input  name="email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter email">
                                        <i class="fa-solid"></i>
                                        <span class="msg"></span>
                                    </div>
                                    <div class="form-group">
                                        <label class="font-weight-bold" for="password">User Password</label>
                                        <input name="password" type="password" class="form-control" id="password" placeholder="Enter here...">
                                        <!-- show and hide password image -->
                                        <div class="toggle-password">
                                            <i class="fa-regular fa-eye"></i>
                                            <i class="fa-regular fa-eye-slash"></i>
                                        </div>
                                        <p class="fa-solid"></p>
                                        <span class="msg"></span>
                                    </div>
                                    <!-- redirect to registration page -->
                                    <div class="text-center">
                                        <a href="register.jsp" class="badge badge-warning mb-3"> if not registered click here </a>
                                    </div>
                                    <div class="container text-center"> 
                                        <button type="submit" class="btn btn-outline-primary "><span class="fa fa-sign-in"></span> Login</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- javascript for form validations -->
        <script src="js/loginscript.js"></script>
    </body>
</html>
