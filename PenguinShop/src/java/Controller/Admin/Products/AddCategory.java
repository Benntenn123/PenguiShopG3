/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products;

import APIKey.CloudinaryConfig;
import DAL.MeterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.Arrays;
import java.util.List;

@MultipartConfig
@WebServlet(name = "AddCategory", urlPatterns = {"/admin/add-category"})
public class AddCategory extends HttpServlet {
    MeterialDAO attributeDAO = new MeterialDAO();
    private CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
    private static final List<String> ALLOWED_TYPES = Arrays.asList(
        "image/png", "image/jpeg", "image/jpg");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCategory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCategory at " + request.getContextPath() + "</h1>");
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
        try {
            request.setCharacterEncoding("UTF-8");

            // Get form fields
            String categoryName = request.getParameter("categoryName");
            String sportType = request.getParameter("sportType");
            String categoryImage = null;

            // Validate categoryName
            if (categoryName == null || categoryName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin!");
                response.sendRedirect("managevariant");
                return;
            }
            categoryName = categoryName.trim();
            sportType = sportType != null ? sportType.trim() : null;

            // Handle file upload
            Part filePart = request.getPart("categoryImage");
            if (filePart != null && filePart.getSize() > 0) {
                // Validate file type
                String contentType = filePart.getContentType();
                if (!ALLOWED_TYPES.contains(contentType)) {
                    request.getSession().setAttribute("error", "Chỉ hỗ trợ định dạng jpg, png, jpeg");
                    response.sendRedirect("managevariant");
                    return;
                }

                // Get file name
                String fileName = filePart.getSubmittedFileName();
                if (fileName == null || fileName.isEmpty()) {
                    request.getSession().setAttribute("error", "Vui lòng chọn file logo");
                    response.sendRedirect("managevariant");
                    return;
                }

                // Upload to Cloudinary
                categoryImage = cloudinaryConfig.uploadImage(filePart.getInputStream(), fileName);
                if (categoryImage == null) {
                    request.getSession().setAttribute("error", "Up ảnh lên sever thất bại");
                    response.sendRedirect("managevariant");
                    return;
                }
            }

            // Add to database
            if (attributeDAO.addCategory(categoryName, categoryImage, sportType)) {
                request.getSession().setAttribute("ms", "Thêm danh mục thành công");
                response.sendRedirect("managevariant");
            } else {
                request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin!");
                response.sendRedirect("managevariant");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error","Error in AddCategoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("managevariant");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
