package Controller.Admin.Feedback;

import DAL.FeedbackDAO;
import Models.Feedback;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FeedbackDetail", urlPatterns = {"/admin/feedbackDetail"})
public class FeedbackDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("feedbackID");
        Feedback feedback = null;
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                FeedbackDAO dao = new FeedbackDAO();
                feedback = dao.getFeedbackDetailById(id);
            } catch (Exception ignored) {}
        }
        if (feedback != null && feedback.getImages() == null) {
            feedback.setImages(new java.util.ArrayList<>());
        }
        request.setAttribute("feedback", feedback);
        request.getRequestDispatcher("../Admin/FeedbackDetail.jsp").forward(request, response);
    }
}
