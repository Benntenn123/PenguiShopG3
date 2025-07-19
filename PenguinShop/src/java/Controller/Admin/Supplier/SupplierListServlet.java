package Controller.Admin.Supplier;

import DAL.SupplierDAO;
import Models.Supplier;
import Models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SupplierListServlet", urlPatterns = {"/admin/SupplierList"})
public class SupplierListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }

        SupplierDAO supplierDAO = new SupplierDAO();
        
        // Pagination parameters
        String pageStr = request.getParameter("page");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        
        // Search parameters
        String searchName = request.getParameter("searchName");
        String searchPhone = request.getParameter("searchPhone");
        String searchStatus = request.getParameter("searchStatus");
        
        // Get suppliers with search and pagination
        List<Supplier> suppliers = supplierDAO.searchSuppliers(searchName, searchPhone, searchStatus, offset, pageSize);
        int totalSuppliers = supplierDAO.getTotalSuppliersCount(searchName, searchPhone, searchStatus);
        
        // Calculate total pages
        int totalPages = (int) Math.ceil((double) totalSuppliers / pageSize);
        
        // Get statistics
        int totalActiveSuppliers = supplierDAO.countActiveSuppliers();
        int totalInactiveSuppliers = 0; // Tạm thời set = 0 vì chưa có status trong DB
        int totalAllSuppliers = totalActiveSuppliers + totalInactiveSuppliers;
        
        // Set attributes for JSP
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalSuppliers", totalSuppliers);
        request.setAttribute("searchName", searchName);
        request.setAttribute("searchPhone", searchPhone);
        request.setAttribute("searchStatus", searchStatus);
        
        // Statistics attributes
        request.setAttribute("totalAllSuppliers", totalAllSuppliers);
        request.setAttribute("totalActiveSuppliers", totalActiveSuppliers);
        request.setAttribute("totalInactiveSuppliers", totalInactiveSuppliers);
        
        request.getRequestDispatcher("/Admin/ListSuppliers.jsp").forward(request, response);
    }
}