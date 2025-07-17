package Controller.Admin;

import DAL.UserDAO;
import Models.Logs;
import Models.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ListLogs", urlPatterns = {"/admin/list-logs"})
public class ListLogs extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String from = request.getParameter("from");
        String to = request.getParameter("to");

        UserDAO userDAO = new UserDAO();
        List<Logs> logs = new ArrayList<>();

        // Lấy danh sách user theo filter
        List<User> users = userDAO.getAllUser(1, 1000, fullName, email, phone, 0); // 0: lấy tất cả role
        for (User user : users) {
            // Lấy log theo khoảng thời gian, mới nhất đến cũ nhất
            List<Logs> userLogs = userDAO.getLogsByTimeRange(user.getUserID(), from, to, 1, 100); // page 1, pageSize 100
            if (userLogs != null) {
                for (Logs log : userLogs) {
                    log.setUser(user);
                    logs.add(log);
                }
            }
        }
        request.setAttribute("logs", logs);
        request.getRequestDispatcher("/Admin/ListLogs.jsp").forward(request, response);
    }
}
