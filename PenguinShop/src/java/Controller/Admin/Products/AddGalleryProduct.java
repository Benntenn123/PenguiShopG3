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
        try {
            String productID = request.getParameter("productID");
            if (productID == null || productID.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng chọn sản phẩm!");
                response.sendRedirect("galleryProduct?productID=" + (productID != null ? productID : ""));
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productID);
            } catch (NumberFormatException e) {
                session.setAttribute("error", "ID sản phẩm không hợp lệ!");
                response.sendRedirect("galleryProduct?productID=" + productID);
                return;
            }

            // Lấy các part có name="imageFile" (nhiều file)
            int maxFiles = 10;
            int successCount = 0;
            int failCount = 0;
            StringBuilder errorMsg = new StringBuilder();
            int totalFiles = 0;

            for (jakarta.servlet.http.Part part : request.getParts()) {
                if ("imageFile".equals(part.getName()) && part.getSize() > 0) {
                    totalFiles++;
                    if (totalFiles > maxFiles) {
                        errorMsg.append("Chỉ được tải lên tối đa ").append(maxFiles).append(" ảnh mỗi lần!\n");
                        break;
                    }
                    String fileName = part.getSubmittedFileName();
                    if (fileName == null || !fileName.matches(".*\\.(jpg|jpeg|png|gif|bmp|webp)$")) {
                        failCount++;
                        errorMsg.append("File ").append(fileName != null ? fileName : "[không xác định]").append(" không phải ảnh hợp lệ!\n");
                        continue;
                    }
                    try (java.io.InputStream inputStream = part.getInputStream()) {
                        String imageUrl = cloudinaryService.uploadImage(inputStream, fileName);
                        if (imageUrl != null) {
                            ProductDao galleryDAO = new ProductDao();
                            boolean saved = galleryDAO.addGalleryImage(productId, imageUrl);
                            if (saved) {
                                successCount++;
                            } else {
                                failCount++;
                                errorMsg.append("Lỗi lưu ảnh ").append(fileName).append(" vào CSDL!\n");
                            }
                        } else {
                            failCount++;
                            errorMsg.append("Lỗi upload ảnh ").append(fileName).append(" lên Cloudinary!\n");
                        }
                    } catch (Exception ex) {
                        failCount++;
                        errorMsg.append("Lỗi xử lý file ").append(fileName).append(": ").append(ex.getMessage()).append("\n");
                    }
                }
            }

            if (successCount > 0) {
                session.setAttribute("ms", "Thêm " + successCount + " ảnh thành công!");
            }
            if (failCount > 0 || errorMsg.length() > 0) {
                session.setAttribute("error", errorMsg.toString());
            }
            if (successCount == 0) {
                session.setAttribute("error", errorMsg.length() > 0 ? errorMsg.toString() : "Không có ảnh nào được thêm!");
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
