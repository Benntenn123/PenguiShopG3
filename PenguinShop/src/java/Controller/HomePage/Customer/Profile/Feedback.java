package Controller.HomePage.Customer.Profile;

import APIKey.CloudinaryConfig;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name="Feedback", urlPatterns={"/feedback"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   //
public class Feedback extends HttpServlet {
    CloudinaryConfig cloudinary = new CloudinaryConfig();
    private static final int MAX_IMAGES = 5;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Feedback</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Feedback at " + request.getContextPath () + "</h1>");
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
            // Get form data
            String orderIdStr = request.getParameter("orderId");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");

            // Validate inputs
            if (orderIdStr == null || ratingStr == null || comment == null) {
                request.getSession().setAttribute("errorMessage", "Thiếu thông tin bắt buộc");
                response.sendRedirect(request.getContextPath() + "/order-status");
                return;
            }

            int orderId;
            int rating;
            try {
                orderId = Integer.parseInt(orderIdStr);
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "Định dạng orderId hoặc rating không hợp lệ");
                response.sendRedirect(request.getContextPath() + "/order-status");
                return;
            }

            if (rating < 1 || rating > 5) {
                request.getSession().setAttribute("errorMessage", "Điểm đánh giá phải từ 1 đến 5");
                response.sendRedirect(request.getContextPath() + "/order-status");
                return;
            }

            if (comment.trim().isEmpty()) {
                request.getSession().setAttribute("errorMessage", "Nhận xét không được để trống");
                response.sendRedirect(request.getContextPath() + "/order-status");
                return;
            }

//            // Validate order status
//            if (!isOrderEligibleForReview(orderId)) {
//                request.getSession().setAttribute("errorMessage", "Đơn hàng không đủ điều kiện để đánh giá");
//                response.sendRedirect(request.getContextPath() + "/order-status");
//                return;
//            }

            // Get image parts
            List<Part> imageParts = new ArrayList<>();
            for (Part part : request.getParts()) {
                if ("images".equals(part.getName())) {
                    imageParts.add(part);
                }
            }

            if (imageParts.size() > MAX_IMAGES) {
                request.getSession().setAttribute("errorMessage", "Chỉ được tải lên tối đa " + MAX_IMAGES + " ảnh");
                response.sendRedirect(request.getContextPath() + "/order-status");
                return;
            }

            // Upload images to Cloudinary
            List<String> imagePublicIds = new ArrayList<>();

            for (Part imagePart : imageParts) {
                String fileName = imagePart.getSubmittedFileName();
                if (fileName == null || !fileName.matches(".*\\.(jpg|jpeg|png|gif)$")) {
                    request.getSession().setAttribute("errorMessage", "Định dạng ảnh không hợp lệ: " + fileName);
                    response.sendRedirect(request.getContextPath() + "/order-status");
                    return;
                }

                try (InputStream inputStream = imagePart.getInputStream()) {
                    String publicId = cloudinary.uploadImage(inputStream, fileName);
                    if (publicId == null) {
                        request.getSession().setAttribute("errorMessage", "Lỗi khi tải ảnh lên: " + fileName);
                        response.sendRedirect(request.getContextPath() + "/order-status");
                        return;
                    }
                    imagePublicIds.add(publicId);
                }
            }

            // Save review and images to database
//            saveReview(orderId, rating, comment, imagePublicIds);

            // Set success message
            request.getSession().setAttribute("successMessage", "Đánh giá đã được gửi thành công!");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
        }

        // Always redirect to order-status
        response.sendRedirect(request.getContextPath() + "/order-status");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
