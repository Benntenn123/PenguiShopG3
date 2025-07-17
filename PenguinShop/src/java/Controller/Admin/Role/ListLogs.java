package Controller.Admin.Role;

import Const.Batch;
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

        int page = 1;
        int pageSize = Batch.BATCH_SEARCH_CUSTOMER;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (Exception e) {}

        UserDAO userDAO = new UserDAO();
        // Lấy logs trực tiếp từ bảng logs, join user, filter theo user info và thời gian
        List<Logs> logs = userDAO.searchLogs(fullName, email, phone, from, to, page, pageSize);
        int totalLogs = userDAO.countSearchLogs(fullName, email, phone, from, to);
        System.out.println(totalLogs);
        int totalPages = (int) Math.ceil((double) totalLogs / pageSize);

        request.setAttribute("logs", logs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalLogs", totalLogs);
        request.getRequestDispatcher("/Admin/ListLogs.jsp").forward(request, response);
    }
}
