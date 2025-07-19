package Controller.HomePage.Customer.Profile;

import APIKey.CloudinaryConfig;
import DAL.FeedbackDAO;
import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(name="Feedback", urlPatterns={"/feedback"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   //
public class Feedback extends HttpServlet {
    private static final Logger LOGGER = LogManager.getLogger(Feedback.class);
    private CloudinaryConfig cloudinary = new CloudinaryConfig();
    private static final int MAX_IMAGES = 5;
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
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
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            // Get form data
            String productIDStr = request.getParameter("productIDFeedBack");
            String variantIDStr = request.getParameter("variantIDFeedBack");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");

            // Validate inputs
            if (productIDStr == null || variantIDStr == null || ratingStr == null || comment == null) {
                session.setAttribute("error", "Thiếu thông tin bắt buộc");
                response.sendRedirect("orderhistory");
                return;
            }

            // Parse and validate numeric inputs
            int productID, variantID, rating;
            try {
                productID = Integer.parseInt(productIDStr);
                variantID = Integer.parseInt(variantIDStr);
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Dữ liệu không hợp lệ");
                response.sendRedirect("orderhistory");
                return;
            }

            if (rating < 1 || rating > 5) {
                session.setAttribute("error", "Điểm đánh giá phải từ 1 đến 5");
                response.sendRedirect("orderhistory");
                return;
            }

            if (comment.trim().isEmpty()) {
                session.setAttribute("error", "Nhận xét không được để trống");
                response.sendRedirect("orderhistory");
                return;
            }

            // Check if user has already reviewed this variant
            if (feedbackDAO.userHasFeedback(user.getUserID(), variantID)) {
                session.setAttribute("error", "Bạn đã đánh giá sản phẩm này rồi");
                response.sendRedirect("orderhistory");
                return;
            }

//            // Validate order status
//            if (!isOrderEligibleForReview(orderId)) {
//                request.getSession().setAttribute("errorMessage", "Đơn hàng không đủ điều kiện để đánh giá");
//                response.sendRedirect(request.getContextPath() + "/order-status");
//                return;
//            }

            // Get image parts
            // Process uploaded images
            List<String> imageUrls = new ArrayList<>();
            for (Part part : request.getParts()) {
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    if (fileName != null && fileName.matches(".*\\.(jpg|jpeg|png|gif)$")) {
                        try (InputStream inputStream = part.getInputStream()) {
                            String imageUrl = cloudinary.uploadImage(inputStream, fileName);
                            if (imageUrl != null) {
                                imageUrls.add(imageUrl);
                            }
                        }
                    }
                }
            }

            if (imageUrls.size() > MAX_IMAGES) {
                session.setAttribute("error", "Chỉ được tải lên tối đa " + MAX_IMAGES + " ảnh");
                response.sendRedirect("orderhistory");
                return;
            }

            // Create and save feedback
            Models.Feedback feedback = new Models.Feedback();
            feedback.setProductID(productID);
            feedback.setVariantID(variantID);
            feedback.setUserID(user.getUserID());
            feedback.setRating(rating);
            feedback.setComment(comment);
            feedback.setFeedbackDate(new Date());
            feedback.setImages(imageUrls);

            // Save to database using transaction
            boolean success = feedbackDAO.addFeedback(feedback);

            if (success) {
                String thongbao = "User đánh giá sản phẩm với id" +variantID;
                UserDAO udao = new UserDAO();
                udao.insertLog(user.getUserID(), thongbao, thongbao);
                session.setAttribute("ms", "Đánh giá sản phẩm thành công!");
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi lưu đánh giá");
            }

        } catch (IOException e) {
            LOGGER.error("Lỗi khi upload ảnh: " + e.getMessage());
            request.getSession().setAttribute("error", "Lỗi khi tải ảnh lên");
        } catch (ServletException e) {
            LOGGER.error("Lỗi servlet: " + e.getMessage());
            request.getSession().setAttribute("error", "Lỗi hệ thống");
        } catch (Exception e) {
            LOGGER.error("Lỗi không xác định: " + e.getMessage());
            request.getSession().setAttribute("error", "Lỗi không xác định");
        }

        // Always redirect back to order history
        response.sendRedirect("orderhistory");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
