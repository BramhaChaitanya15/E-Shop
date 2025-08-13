package com.mycompany.eshop.servlets;

import com.mycompany.eshop.entities.User;
import com.mycompany.eshop.dao.CategoryDao;
import com.mycompany.eshop.dao.ProductDao;
import com.mycompany.eshop.dao.ProductImageDao;
import com.mycompany.eshop.dao.UserDao;
import com.mycompany.eshop.entities.Category;
import com.mycompany.eshop.entities.Product;
import com.mycompany.eshop.entities.ProductImage;
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
public class AdminOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NullPointerException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            //get operation name for type of admin operation
            String op = request.getParameter("operation");

            /*add category operation*/
            if (op.trim().equals("addcategory")) {
                //add category
                //fetching category data
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                //category databse save:
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("successMessage", "Category added successfully : " + catId);
                response.sendRedirect("admin.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {
                /*add product operation*/
                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDesc");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");
                Part part2 = request.getPart("pPic2");
                Part part3 = request.getPart("pPic3");
                Part part4 = request.getPart("pPic4");
                Part part5 = request.getPart("pPic5");
                Part part6 = request.getPart("pPic6");

                Product p = new Product();
                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);

                CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdoa.getCategoryById(catId);

                p.setCategory(category);

                //Product image object
                ProductImage pi = new ProductImage();

                String path = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part.getSubmittedFileName();
                String path2 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part2.getSubmittedFileName();
                String path3 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part3.getSubmittedFileName();
                String path4 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part4.getSubmittedFileName();
                String path5 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part5.getSubmittedFileName();
                String path6 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part6.getSubmittedFileName();

                boolean f = Helper.saveFile(part.getInputStream(), path);

                //product save...
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                int pid = pdao.saveProduct(p, path);
                Product product = pdao.getProductById(pid);
                pi.setProduct(product);

                ProductImageDao pidao = new ProductImageDao(FactoryProvider.getFactory());
                if (f) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path);
                }
                if (Helper.saveFile(part2.getInputStream(), path2)) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path2);
                }
                if (Helper.saveFile(part3.getInputStream(), path3)) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path3);
                }
                if (Helper.saveFile(part4.getInputStream(), path4)) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path4);
                }
                if (Helper.saveFile(part5.getInputStream(), path5)) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path5);
                }
                if (Helper.saveFile(part6.getInputStream(), path6)) {
                    //saving image in database
                    pidao.saveFileInDb(pi, path6);
                }
                //message...
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("successMessage", "Product is added successfully...");
                response.sendRedirect("admin.jsp");
                return;
            } else if (op.trim().equals("editusertype")) {

                /*edit user type operation*/
                String uType = request.getParameter("user_type");
                int uid = Integer.parseInt(request.getParameter("user_id"));

                UserDao udao = new UserDao(FactoryProvider.getFactory());

                User u = udao.getUserById(uid);
                u.setUserType(uType);

                boolean ans = udao.updateUser(u);

                if (ans) {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("successMessage", "User type editted successfully...");
                    response.sendRedirect("adminusers.jsp");
                    return;
                } else {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("errorMessage", "Something went Wrong !!!");
                    response.sendRedirect("adminusers.jsp");
                    return;
                }

            } else if (op.trim().equals("editcategory")) {

                /*edit category operation*/
                String cTitle = request.getParameter("cat_title");
                String cDesc = request.getParameter("cat_desc");
                String catid = request.getParameter("cat_id");
                int cid = Integer.parseInt(catid);

                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());

                Category category = cDao.getCategoryById(cid);
                category.setCategoryTitle(cTitle);
                category.setCategoryDescription(cDesc);

                boolean e = cDao.updateCategory(category);

                if (e) {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("successMessage", "Category editted successfully...");
                    response.sendRedirect("admincategories.jsp");
                    return;
                } else {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("errorMessage", "Something went Wrong !!!");
                    response.sendRedirect("admincategories.jsp");
                    return;
                }
            } else if (op.trim().equals("editproduct")) {
                /*edit product operation*/
                String productId = request.getParameter("pro_id");
                int pid = Integer.parseInt(productId);
                String pName = request.getParameter("pro_title");
                String pDesc = request.getParameter("pro_desc");
                int pPrice = Integer.parseInt(request.getParameter("pro_price"));
                int pDiscount = Integer.parseInt(request.getParameter("pro_discount"));
                int pQuantity = Integer.parseInt(request.getParameter("pro_quantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");
                Part part2 = request.getPart("pPic2");
                String pImage = part.getSubmittedFileName();
                boolean e = false;

                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

                Product product = pdao.getProductById(pid);

                product.setpName(pName);
                product.setpDesc(pDesc);
                product.setpPrice(pPrice);
                product.setpDiscount(pDiscount);
                product.setpQuantity(pQuantity);

                ProductImageDao pidao = new ProductImageDao(FactoryProvider.getFactory());

                CategoryDao cdoa = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdoa.getCategoryById(catId);

                product.setCategory(category);

                boolean ans = pdao.updateProduct(product);

                if (ans) {
                    String path = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + pImage;
                    String path2 = request.getRealPath("/") + "img" + File.separator + "products" + File.separator + part2.getSubmittedFileName();

                    if (Helper.saveFile(part.getInputStream(), path)) {

                        Session s = FactoryProvider.getFactory().openSession();
                        Transaction tx = s.beginTransaction();
                        //uploading code..
                        FileInputStream fis = new FileInputStream(path);

                        //reading data
                        byte[] data = new byte[fis.available()];

                        fis.read(data);
                        product.setProductImg(data);

                        tx.commit();
                        s.close();

                        e = pdao.updateProductPic(product);
                    }
                    if (Helper.saveFile(part2.getInputStream(), path2)) {
                        //Product image object
                        ProductImage pi = new ProductImage();

                        pi.setProduct(product);

                        //saving image in database
                        pidao.saveFileInDb(pi, path2);
                    }
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("successMessage", "Product editted successfully...");
                    response.sendRedirect("adminproducts.jsp");
                    return;
                } else {
                    //message...
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("errorMessage", "Something went Wrong !!!");
                    response.sendRedirect("adminproducts.jsp");
                    return;
                }
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
