/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Request;

import Const.Batch;
import DAL.RequestDAO;
import Models.CustomerRequest;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


@WebServlet(name="ListRequestSupport", urlPatterns={"/admin/listRequestSupport"})
public class ListRequestSupport extends HttpServlet {
    
    RequestDAO requestDAO = new RequestDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListRequestSupport</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListRequestSupport at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get search parameters
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");
        String requestType = request.getParameter("requestType");
        String startDate = request.getParameter("startDate"); // e.g., 2025-06-01
        String endDate = request.getParameter("endDate"); // e.g., 2025-06-15
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = Batch.BATCH_SEARCH_REQUESTS;

        // Validate and format dates
        if (startDate != null && !startDate.isEmpty()) {
            startDate += " 00:00:00"; // Append time for SQL
        }
        if (endDate != null && !endDate.isEmpty()) {
            endDate += " 23:59:59"; // Append time for SQL
        }

        try {
            // Fetch data from DAO
            List<CustomerRequest> requestList = requestDAO.getCustomerRequests(email, phone,requestType, status, startDate, endDate, page, pageSize);
            int totalRequests = requestDAO.getTotalRequests(email, phone, status, startDate, endDate);
            int pendingRequests = requestDAO.getPendingRequests();
            int processedRequests = requestDAO.getProcessedRequests();

            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalRequests / pageSize);
            int startRecord = (page - 1) * pageSize + 1;
            int endRecord = Math.min(page * pageSize, totalRequests);

            // Set attributes
            request.setAttribute("requestList", requestList);
            request.setAttribute("totalRequests", totalRequests);
            request.setAttribute("pendingRequests", pendingRequests);
            request.setAttribute("processedRequests", processedRequests);
            request.setAttribute("startRecord", startRecord);
            request.setAttribute("endRecord", endRecord);
            request.setAttribute("totalRecords", totalRequests);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Forward to JSP
            request.getRequestDispatcher("../Admin/ListRequestSupport.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi tải danh sách yêu cầu: " + e.getMessage());
            
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
