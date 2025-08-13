package com.mycompany.eshop.servlets;

import com.mycompany.eshop.dao.UserDao;
import com.mycompany.eshop.encryptionKey.KeyGen;
import com.mycompany.eshop.entities.User;
import com.mycompany.eshop.helper.FactoryProvider;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Key;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.binary.Base64;
import org.hibernate.exception.ConstraintViolationException;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    public void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            try {
                /*to get parameters (user details) from the registeration form (register.jsp)*/
                String fuserName = request.getParameter("user_namef");
                String luserName = request.getParameter("user_namel");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");

                //password encryption process
                Key key = KeyGen.generateKey();
                Cipher cipher = Cipher.getInstance(KeyGen.ALGORITHM);
                cipher.init(Cipher.ENCRYPT_MODE, key);

                byte[] encValue = cipher.doFinal(userPassword.getBytes());
                byte[] encryptedByteValue = new Base64().encode(encValue);

                String encryptedPassword = new String(encryptedByteValue);

                //creating user object
                User user = new User();
                int userId;
                //creating object for transaction
                user.setFirstName(fuserName);
                user.setLastName(luserName);
                user.setUserEmail(userEmail);
                user.setUserPhone(userPhone);
                user.setUserAddress(userAddress);
                user.setUserPassword(encryptedPassword);
                user.setUserType("normal");
                //user pic name is to delete user pic 
                //from web/inf for storage issues
                user.setUserPicName("default.png");
                
                UserDao udao = new UserDao(FactoryProvider.getFactory());
                //saving default image to database
                String path = request.getRealPath("/") + "img" + File.separator + "user" + File.separator + "default.png";
                //saving user details to database
                userId = udao.saveUser(user, path);               
                
                //Message...
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("successMessage", "Registration Successful !! User id is : " + userId);
                response.sendRedirect("register.jsp");
                return;

            } catch (ConstraintViolationException e) {
                //Message...
                HttpSession Session = request.getSession();
                Session.setAttribute("errorMessage", " Registration Unsuccessful as E-mail already exists...!");
                response.sendRedirect("register.jsp");
                return;
            } catch (Exception ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public RegisterServlet() {
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
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
