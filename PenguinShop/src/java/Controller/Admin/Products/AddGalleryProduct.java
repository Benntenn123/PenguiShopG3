/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import APIKey.CloudinaryConfig;
import DAL.ProductDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
@MultipartConfig
@WebServlet(name="AddGalleryProduct", urlPatterns={"/admin/addGalleryImage"})
public class AddGalleryProduct extends HttpServlet {
    private final CloudinaryConfig cloudinaryService = new CloudinaryConfig();
  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddGalleryProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddGalleryProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        try{
            String productID = request.getParameter("productID");
            Part imageFile = request.getPart("imageFile");

            if (productID == null || imageFile == null || imageFile.getSize() == 0) {
                session.setAttribute("error", "Vui lòng chọn sản phẩm và file ảnh!");
                response.sendRedirect("galleryProduct?productID=" + productID);
                return;
            }

            String imageUrl = cloudinaryService.uploadImage(imageFile.getInputStream(), imageFile.getSubmittedFileName());
            if (imageUrl == null) {
                session.setAttribute("error", "Lỗi upload ảnh lên Cloudinary!");
                response.sendRedirect("galleryProduct?productID=" + productID);
                return;
            }

            ProductDao galleryDAO = new ProductDao();
            boolean success = galleryDAO.addGalleryImage(Integer.parseInt(productID), imageUrl);
            if (success) {
                session.setAttribute("ms", "Thêm ảnh thành công!");
            } else {
                session.setAttribute("error", "Thêm ảnh không thành công!");
            }
            response.sendRedirect("galleryProduct?productID=" + productID);
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect("galleryProduct?productID=" + request.getParameter("productID"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
