/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Profile;

import DAL.UserDAO;
import Models.Logs;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "HistoryActionUser", urlPatterns = {"/logUser"})
public class HistoryActionUser extends HttpServlet {

    UserDAO udao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HistoryActionUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HistoryActionUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String page = request.getParameter("page");
       
        int curPage = 1;
        int pageSize = 5;

        if (page != null) {
            try {
                curPage = Integer.parseInt(page);
            } catch (Exception e) {
                curPage = 1; // Set default nếu parse fail
            }
        }

        User user = (User) request.getSession().getAttribute("user");
        List<Logs> listLogs = udao.getLogsByTimeRange(user.getUserID(), from, to, curPage, pageSize);
        request.setAttribute("listLogs", listLogs);

        int totalResult = udao.countLogsByTimeRange(user.getUserID(), from, to);
        int totalPages = (int) Math.ceil((double) totalResult / pageSize);

        // Validate currentPage
        if (curPage < 1) {
            curPage = 1;
        } else if (curPage > totalPages && totalPages > 0) {
            curPage = totalPages;
        }

        // Tính startPage và endPage cho pagination display
        int maxPagesToShow = 5;
        int startPage, endPage;

        if (totalPages <= maxPagesToShow) {
            startPage = 1;
            endPage = totalPages;
        } else {
            int halfPages = maxPagesToShow / 2;

            if (curPage <= halfPages) {
                startPage = 1;
                endPage = maxPagesToShow;
            } else if (curPage > totalPages - halfPages) {
                startPage = totalPages - maxPagesToShow + 1;
                endPage = totalPages;
            } else {
                startPage = curPage - halfPages;
                endPage = curPage + halfPages;
            }
        }

        request.setAttribute("totalResult", totalResult);
        request.setAttribute("currentPage", curPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);

        request.getRequestDispatcher("HomePage/HistoryActionUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
