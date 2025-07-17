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
        List<Feedback> feedbackList = feedbackDAO.getAllFeedbacksWithProductAndUser();
        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("/Admin/ListFeedBack.jsp").forward(request, response);
    }
}
