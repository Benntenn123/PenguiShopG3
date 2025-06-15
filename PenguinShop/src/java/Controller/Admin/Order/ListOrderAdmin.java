/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Order;

import Const.Batch;
import DAL.OrderDAO;
import Models.Order;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ListOrderAdmin", urlPatterns = {"/admin/listOrderAdmin"})
public class ListOrderAdmin extends HttpServlet {

    OrderDAO odao = new OrderDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListOrderAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListOrderAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] data = getData(request);
        String page_raw = request.getParameter("page");
        int page = 1;

        try {
            if (!StringConvert.isEmpty(page_raw)) {
                page = Integer.parseInt(page_raw);
            }
            List<Order> list = odao.listOrders(data, page, Batch.BATCH_SEARCH_ORDER);
            request.setAttribute("list", list);

            int totalRecords = odao.countOrdered(data);
            request.setAttribute("startRecord", (page - 1) * Batch.BATCH_SEARCH_ORDER + 1);
            request.setAttribute("endRecord", Math.min(page * Batch.BATCH_SEARCH_ORDER, totalRecords));
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", (int) (totalRecords / Batch.BATCH_SEARCH_ORDER) + 1);
            request.setAttribute("totalRecords", totalRecords);
        } catch (Exception e) {
        }

        request.getRequestDispatcher("../Admin/ListOrderAdmin.jsp").forward(request, response);
    }

    private String[] getData(HttpServletRequest request) {
        String[] params = new String[]{
            request.getParameter("orderID"),
            request.getParameter("from"),
            request.getParameter("to"),
            request.getParameter("status"),
            request.getParameter("email")
        };
        return params;
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
