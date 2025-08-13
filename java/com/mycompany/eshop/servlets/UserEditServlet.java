package com.mycompany.eshop.servlets;

import com.mycompany.eshop.dao.UserDao;
import com.mycompany.eshop.entities.User;
import com.mycompany.eshop.helper.FactoryProvider;
import com.mycompany.eshop.helper.Helper;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;

/*@MultipartConfig is used for operation on image files*/
@MultipartConfig
public class UserEditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            //fetching edditing details
            String fname = request.getParameter("user_fname");
            String lname = request.getParameter("user_lname");
            String email = request.getParameter("user_email");
            String phone = request.getParameter("user_phone");
            String address = request.getParameter("user_address");
            Part part = request.getPart("image");

            String userImg = part.getSubmittedFileName();

            //get the user from the session...
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("current-user");
            //setting user details
            user.setFirstName(fname);
            user.setLastName(lname);
            user.setUserEmail(email);
            user.setUserPhone(phone);
            user.setUserAddress(address);
            String oldFile = user.getUserPicName();
            user.setUserPicName(userImg);

            UserDao udao = new UserDao(FactoryProvider.getFactory());
            boolean ans = udao.updateUser(user);

            if (ans) {
                String path = request.getRealPath("/") + "img" + File.separator + "user" + File.separator + userImg;

                //delete code to delete 
                //user profile picture from web/inf
                String pathOldFile = request.getRealPath("/") + "img" + File.separator + "user" + File.separator + oldFile;

                Helper.deleteFile(pathOldFile);

                if (Helper.saveFile(part.getInputStream(), path)) {

                    Session s = FactoryProvider.getFactory().openSession();
                    Transaction tx = s.beginTransaction();
                    //uploading code..
                    FileInputStream fis = new FileInputStream(path);

                    //reading data
                    byte[] data = new byte[fis.available()];

                    fis.read(data);
                    user.setUserPic(data);

                    tx.commit();
                    s.close();

                    udao.updateUserPic(user);
                }
                //Message...
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("successMessage", "Profile editted successfully...");
                response.sendRedirect(user.getUserType().equals("admin") ? "admin.jsp" : "normal.jsp");
                return;
            } else {
                //Message...
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("errorMessage", "Something went Wrong !!!");
                response.sendRedirect(user.getUserType().equals("admin") ? "admin.jsp" : "normal.jsp");
                return;
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
