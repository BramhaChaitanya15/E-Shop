package com.mycompany.eshop.servlets;

import com.mycompany.eshop.dao.UserDao;
import com.mycompany.eshop.encryptionKey.KeyGen;
import com.mycompany.eshop.entities.User;
import com.mycompany.eshop.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Key;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.binary.Base64;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            /*to get parameters (user details) from the login form (login.jsp)*/
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            /*encrypting password 
            to compare it with the encrypted password stored in database*/
            Key key;
            try {
                //encrypt password to compare to database
                key = KeyGen.generateKey();
                Cipher cipher = Cipher.getInstance(KeyGen.ALGORITHM);
                cipher.init(Cipher.ENCRYPT_MODE, key);

                byte[] encValue = cipher.doFinal(password.getBytes());
                byte[] encryptedByteValue = new Base64().encode(encValue);

                String encryptedPassword = new String(encryptedByteValue);

                //authenticating user
                UserDao userDao = new UserDao(FactoryProvider.getFactory());
                User user = userDao.getUserByEmailAndPassword(email, encryptedPassword);

                HttpSession httpSession = request.getSession();
                if (user == null) {
                    //message...
                    httpSession.setAttribute("warMessage", "Invalid Details !! Try with another one...");
                    response.sendRedirect("login.jsp");
                    return;
                } else {

                    //login by creating user session
                    httpSession.setAttribute("current-user", user);

                    if (user.getUserType().equals("admin")) {
                        //redirect admin user to:-admin.jsp
                        response.sendRedirect("admin.jsp");
                    } else if (user.getUserType().equals("normal")) {
                        //redirect normal user to :-normal.jsp
                        response.sendRedirect("normal.jsp");
                    } else {
                        //message...
                        httpSession.setAttribute("warMessage", "We have not identified user type...");
                        response.sendRedirect("login.jsp");
                    }

                }
            } catch (Exception ex) {
                Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
