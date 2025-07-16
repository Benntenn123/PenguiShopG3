package Controller.HomePage.Product;

import DAL.FeedbackDAO;
import Models.Feedback;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "FeedbackAPI", urlPatterns = {"/api/feedback"})
public class FeedbackAPI extends HttpServlet {
    private final FeedbackDAO feedbackDAO = new FeedbackDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        int variantId = Integer.parseInt(request.getParameter("variantId"));

        try (PrintWriter out = response.getWriter()) {
            if ("getRatingDistribution".equals(action)) {
                int[] distribution = feedbackDAO.getRatingDistribution(variantId);
                Map<String, Object> result = new HashMap<>();
                result.put("distribution", distribution);
                result.put("total", feedbackDAO.getTotalFeedbacks(variantId));
                result.put("average", feedbackDAO.getAverageRating(variantId));
                out.print(gson.toJson(result));
            } else if ("getFeedbacks".equals(action)) {
                int page = Integer.parseInt(request.getParameter("page"));
                int pageSize = Integer.parseInt(request.getParameter("pageSize"));
                int rating = request.getParameter("rating") != null ? Integer.parseInt(request.getParameter("rating")) : 0;
                
                List<Feedback> feedbacks;
                int total;
                
                if (rating > 0) {
                    feedbacks = feedbackDAO.getFeedbacksByRating(variantId, rating, page, pageSize);
                    total = feedbackDAO.getTotalFeedbacksByRating(variantId, rating);
                } else {
                    feedbacks = feedbackDAO.getFeedbacksByVariantIDPaginated(variantId, page, pageSize);
                    total = feedbackDAO.getTotalFeedbacks(variantId);
                }
                
                Map<String, Object> result = new HashMap<>();
                result.put("feedbacks", feedbacks);
                result.put("total", total);
                out.print(gson.toJson(result));
            }
        }
    }
}
