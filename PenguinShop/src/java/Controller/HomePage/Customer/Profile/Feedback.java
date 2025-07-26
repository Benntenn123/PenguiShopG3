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
import java.util.Collection;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CountDownLatch;
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
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class Feedback extends HttpServlet {
    private static final Logger LOGGER = LogManager.getLogger(Feedback.class);
    private CloudinaryConfig cloudinary = new CloudinaryConfig();
    private static final int MAX_IMAGES = 5;
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    // Thread-safe list để lưu kết quả upload
    private final List<String> uploadResults = new CopyOnWriteArrayList<>();
    private final List<String> uploadErrors = new CopyOnWriteArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

            // Collect image parts first
            List<Part> imageParts = new ArrayList<>();
            Collection<Part> allParts = request.getParts();
            
            for (Part part : allParts) {
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    String fileName = part.getSubmittedFileName();
                    if (fileName != null && fileName.toLowerCase().matches(".*\\.(jpg|jpeg|png|gif|bmp|webp)$")) {
                        imageParts.add(part);
                    }
                }
            }

            if (imageParts.size() > MAX_IMAGES) {
                session.setAttribute("error", "Chỉ được tải lên tối đa " + MAX_IMAGES + " ảnh");
                response.sendRedirect("orderhistory");
                return;
            }

            // Clear previous results
            uploadResults.clear();
            uploadErrors.clear();

            // MULTI-THREADING UPLOAD IMAGES
            List<String> imageUrls = uploadImagesMultiThreaded(imageParts);

            LOGGER.info("Total images uploaded successfully: " + imageUrls.size());
            if (!uploadErrors.isEmpty()) {
                LOGGER.warn("Upload errors: " + uploadErrors);
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
                String thongbao = "User đánh giá sản phẩm với id " + variantID + 
                                (imageUrls.size() > 0 ? " với " + imageUrls.size() + " ảnh" : "");
                UserDAO udao = new UserDAO();
                udao.insertLog(user.getUserID(), thongbao, thongbao);
                
                String successMsg = "Đánh giá sản phẩm thành công!";
                if (imageUrls.size() > 0) {
                    successMsg += " Đã tải lên " + imageUrls.size() + " ảnh.";
                }
                if (!uploadErrors.isEmpty()) {
                    successMsg += " (Có " + uploadErrors.size() + " ảnh lỗi)";
                }
                session.setAttribute("ms", successMsg);
            } else {
                session.setAttribute("error", "Có lỗi xảy ra khi lưu đánh giá");
            }

        } catch (Exception e) {
            LOGGER.error("Lỗi không xác định: " + e.getMessage(), e);
            request.getSession().setAttribute("error", "Lỗi không xác định");
        }

        // Always redirect back to order history
        response.sendRedirect("orderhistory");
    }

    /**
     * Upload images using multiple threads (basic implementation)
     */
    private List<String> uploadImagesMultiThreaded(List<Part> imageParts) {
        if (imageParts.isEmpty()) {
            return new ArrayList<>();
        }

        // CountDownLatch để chờ tất cả threads hoàn thành
        CountDownLatch latch = new CountDownLatch(imageParts.size());
        
        LOGGER.info("Starting multi-threaded upload for " + imageParts.size() + " images");

        // Tạo thread cho mỗi ảnh
        for (int i = 0; i < imageParts.size(); i++) {
            final Part imagePart = imageParts.get(i);
            final int index = i;
            
            // Tạo thread mới để upload ảnh
            Thread uploadThread = new Thread(() -> {
                try {
                    String fileName = imagePart.getSubmittedFileName();
                    LOGGER.info("Thread " + index + " uploading: " + fileName);
                    
                    try (InputStream inputStream = imagePart.getInputStream()) {
                        String imageUrl = cloudinary.uploadImage(inputStream, fileName);
                        
                        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                            uploadResults.add(imageUrl);
                            LOGGER.info("Thread " + index + " successfully uploaded: " + fileName + " -> " + imageUrl);
                        } else {
                            String error = "Failed to upload: " + fileName;
                            uploadErrors.add(error);
                            LOGGER.warn("Thread " + index + " " + error);
                        }
                    }
                } catch (Exception e) {
                    String error = "Error uploading " + imagePart.getSubmittedFileName() + ": " + e.getMessage();
                    uploadErrors.add(error);
                    LOGGER.error("Thread " + index + " " + error, e);
                } finally {
                    // Giảm count của latch khi thread hoàn thành
                    latch.countDown();
                }
            });
            
            // Đặt tên cho thread để dễ debug
            uploadThread.setName("ImageUpload-" + index);
            
            // Start thread
            uploadThread.start();
        }

        try {
            // Chờ tất cả threads hoàn thành (timeout 30 giây)
            boolean completed = latch.await(30, java.util.concurrent.TimeUnit.SECONDS);
            
            if (!completed) {
                LOGGER.warn("Some upload threads did not complete within 30 seconds");
            }
            
        } catch (InterruptedException e) {
            LOGGER.error("Upload process was interrupted", e);
            Thread.currentThread().interrupt();
        }

        LOGGER.info("Multi-threaded upload completed. Success: " + uploadResults.size() + ", Errors: " + uploadErrors.size());
        
        // Return list of successful uploads
        return new ArrayList<>(uploadResults);
    }

    @Override
    public String getServletInfo() {
        return "Feedback servlet with multi-threaded image upload";
    }
}