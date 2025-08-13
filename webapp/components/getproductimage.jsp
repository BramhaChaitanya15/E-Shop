<!-- page for primary image of product from database on home page -->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.*"%>
<%@page trimDirectiveWhitespaces="true" %>
<%
    String id = request.getParameter("id");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/eshop", "root", "milindmonu1526");

        PreparedStatement ps = con.prepareStatement("select * from product where pId=?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Blob blob = rs.getBlob("productImg");
            byte byteArray[] = blob.getBytes(1, (int) blob.length());
            response.setContentType("image/gif");
            OutputStream os = response.getOutputStream();
            os.write(byteArray);
            os.flush();
            os.close();
        } else {
            HttpSession hSession = request.getSession();
            hSession.setAttribute("errorMessage", " No image here...!");
            response.sendRedirect("index.jsp");
            return;
        }
    } catch (Exception e) {
        out.println(e);
    }
%>