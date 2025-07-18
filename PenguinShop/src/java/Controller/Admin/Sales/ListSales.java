package Controller.Admin.Sales;

import Const.Batch;
import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="ListSales", urlPatterns={"/admin/listSales"})
public class ListSales extends HttpServlet {
    UserDAO usersDAO = new UserDAO();
    int PAGE_SIZE = Batch.BATCH_SEARCH_PRODUCT;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListSales</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListSales at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Lấy tham số tìm kiếm
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

            // Lấy danh sách Sales với bộ lọc và phân trang
            List<User> salesList = usersDAO.getSalesList(fullName, email, phone, currentPage, PAGE_SIZE);
            int totalSales = usersDAO.getTotalSales(fullName, email, phone);

            // Tính toán phân trang
            int totalPages = (int) Math.ceil((double) totalSales / PAGE_SIZE);
            int startRecord = (currentPage - 1) * PAGE_SIZE + 1;
            int endRecord = Math.min(currentPage * PAGE_SIZE, totalSales);

            // Đặt thuộc tính cho JSP
            request.setAttribute("salesList", salesList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("startRecord", startRecord);
            request.setAttribute("endRecord", endRecord);
            request.setAttribute("totalRecords", totalSales);

            // Chuyển hướng đến JSP
            request.getRequestDispatcher("/Admin/ListSales.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("/Admin/ListSales.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ListSales.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
