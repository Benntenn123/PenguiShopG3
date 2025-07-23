package Controller.Admin.Feedback;

import DAL.FeedbackDAO;
import Models.Feedback;
import Models.Product;
import Models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FeedbackList", urlPatterns = {"/admin/feedbackList"})
public class FeedbackList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        
        // Lấy tham số search từ request
        String productName = request.getParameter("productName");
        String userName = request.getParameter("userName");
        String ratingStr = request.getParameter("rating");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        
        List<Feedback> feedbackList;
        
        // Kiểm tra nếu có tham số search thì gọi method search, không thì lấy tất cả
        if ((productName != null && !productName.trim().isEmpty()) ||
            (userName != null && !userName.trim().isEmpty()) ||
            (ratingStr != null && !ratingStr.trim().isEmpty()) ||
            (fromDate != null && !fromDate.trim().isEmpty()) ||
            (toDate != null && !toDate.trim().isEmpty())) {
            
            Integer rating = null;
            if (ratingStr != null && !ratingStr.trim().isEmpty()) {
                try {
                    rating = Integer.parseInt(ratingStr);
                } catch (NumberFormatException e) {
                    // Ignore invalid rating
                }
            }
            
            feedbackList = feedbackDAO.searchFeedbacks(productName, userName, rating, fromDate, toDate);
        } else {
            feedbackList = feedbackDAO.getAllFeedbacksWithProductAndUser();
        }
        
        // Set attributes cho JSP
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("productName", productName);
        request.setAttribute("userName", userName);
        request.setAttribute("rating", ratingStr);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        
        request.getRequestDispatcher("/Admin/ListFeedBack.jsp").forward(request, response);
    }
}
