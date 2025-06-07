/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Customer;

import Const.Account;
import DAL.UserDAO;
import Models.User;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import static jakarta.servlet.http.HttpServlet.LEGACY_DO_HEAD;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ListCustomerAdmin", urlPatterns = {"/admin/listCustomerAdmin"})
public class ListCustomerAdmin extends HttpServlet {

    UserDAO udao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCustomerAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCustomerAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] data = getData(request);
        try {
            int page = 1;
            if (data[0] != null && !data[0].trim().isEmpty()) {
                page = Integer.parseInt(data[0]);
            }
            int batch = 2; // pageSize
            List<User> list = udao.getAllUser(page, batch, data[1], data[3], data[2], Account.ROLE_CUSTOMER);
            int totalResult = udao.getTotalUserRecords(Account.ROLE_CUSTOMER, data[1], data[3], data[2]);

            int totalPages = (int) Math.ceil((double) totalResult / batch);
            int startRecord = (page - 1) * batch + 1;
            int endRecord = Math.min(startRecord + batch - 1, totalResult);

            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalResult);
            request.setAttribute("startRecord", startRecord);
            request.setAttribute("endRecord", endRecord);
            request.setAttribute("list", list);
        } catch (NumberFormatException e) {
            System.err.println("Invalid page number: " + data[0]);
            request.setAttribute("error", "Invalid page number");
            request.setAttribute("list", new ArrayList<User>());
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 0);
            request.setAttribute("totalRecords", 0);
            request.setAttribute("startRecord", 0);
            request.setAttribute("endRecord", 0);
        } catch (Exception e) {
            System.err.println("Error loading customers: " + e.getMessage());
            request.setAttribute("error", "Error loading customers");
        }

        request.getRequestDispatcher("../Admin/ListCustomerAdmin.jsp").forward(request, response);
    }

    private String[] getData(HttpServletRequest request) {
        String page = request.getParameter("page");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        return new String[]{page, fullname, phone, email};
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
