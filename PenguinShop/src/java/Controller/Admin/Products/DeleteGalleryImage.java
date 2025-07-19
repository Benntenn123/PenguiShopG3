/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products;

import DAL.ProductDao;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteGalleryImage", urlPatterns = {"/admin/deleteGalleryImage"})
public class DeleteGalleryImage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteGalleryImage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteGalleryImage at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Đổi parameter names để khớp với frontend JSP
            String imageUrl = request.getParameter("imageUrl");
            String productID = request.getParameter("productID");
            
            System.out.println("Link ảnh: " + imageUrl);
            System.out.println("ProductID: " + productID);
            
            if (imageUrl == null || productID == null || imageUrl.trim().isEmpty() || productID.trim().isEmpty()) {
                session.setAttribute("error", "Thiếu thông tin ảnh hoặc sản phẩm!");
                response.sendRedirect("galleryProduct?productID=" + productID);
                return;
            }
            
            ProductDao galleryDAO = new ProductDao();
            // Kiểm tra ảnh tồn tại
            if (!galleryDAO.checkImageExists(imageUrl, Integer.parseInt(productID))) {
                session.setAttribute("error", "Ảnh không tồn tại trong gallery của sản phẩm này!");
                response.sendRedirect("galleryProduct?productID=" + productID);
                return;
            }
            System.out.println(imageUrl +"hehehe");
            System.out.println(productID +"hehehe");
            // Xóa ảnh
            boolean success = galleryDAO.deleteGalleryImage(imageUrl, Integer.parseInt(productID));
            if (success) {
                session.setAttribute("ms", "Xóa ảnh thành công!");
            } else {
                session.setAttribute("error", "Xóa ảnh không thành công!");
            }
            response.sendRedirect("galleryProduct?productID=" + productID);
        }catch (Exception e) {
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("galleryProduct?productID=" + request.getParameter("productID"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
