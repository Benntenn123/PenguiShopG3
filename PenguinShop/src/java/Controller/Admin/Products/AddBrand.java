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
import java.io.InputStream;
import java.util.List;

@MultipartConfig
@WebServlet(name="AddBrand", urlPatterns={"/admin/add-brand"})
public class AddBrand extends HttpServlet {
    private static final String[] ALLOWED_EXTENSIONS = {".png", ".jpg", ".jpeg"};
    MeterialDAO attributeDAO = new MeterialDAO();
    private CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddBrand</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddBrand at " + request.getContextPath () + "</h1>");
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
            // Get form fields and file
            String brandName = request.getParameter("brandName");
            Part logoPart = request.getPart("brandLogo");
            String logoPublicId = null;

            // Validate brandName
            if (brandName == null || brandName.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Không thể add nhãn hàng!");
                response.sendRedirect("managevariant");
                return;
            }

            // Process file
            if (logoPart != null && logoPart.getSize() > 0) {
                String fileName = logoPart.getSubmittedFileName();
                if (fileName != null) {
                    String extension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                    if (!List.of(ALLOWED_EXTENSIONS).contains(extension)) {
                        request.getSession().setAttribute("error", "Định dạng hỗ trợ là png,jpg,jpeg!");
                        response.sendRedirect("managevariant");
                        return;
                    }

                    // Upload to Cloudinary
                    try (InputStream imageStream = logoPart.getInputStream()) {
                        logoPublicId = cloudinaryConfig.uploadImage(imageStream, fileName);
                    }
                    if (logoPublicId == null) {
                        request.getSession().setAttribute("error", "Lỗi khi tải ảnh lên");
                        response.sendRedirect("managevariant");
                        return;
                    }
                }
            } else {
                request.getSession().setAttribute("error", "Vui lòng thêm logo");
                response.sendRedirect("managevariant");
                return;
            }

            // Save to DB
            if (attributeDAO.addBrand(brandName, logoPublicId)) {
                request.getSession().setAttribute("ms", "Thêm nhãn hàng thành công!");
                response.sendRedirect("managevariant");
            } else {
                request.getSession().setAttribute("error", "Thêm nhãn hàng thất bại!");
                response.sendRedirect("managevariant");
            }
        } catch (Exception e) {
            request.getSession().getAttribute("Lỗi khi up ảnh: " + e.getMessage());
            response.sendRedirect("managevariant");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
