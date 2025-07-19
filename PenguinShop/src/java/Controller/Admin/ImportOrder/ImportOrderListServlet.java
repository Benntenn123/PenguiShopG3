package Controller.Admin.ImportOrder;

import DAL.ImportOrderDAO;
import DAL.SupplierDAO;
import Models.ImportOrder;
import Models.Supplier;
import Models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ImportOrderListServlet", urlPatterns = {"/admin/ImportOrderList"})
public class ImportOrderListServlet extends HttpServlet {
    
    private ImportOrderDAO importOrderDAO;
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        importOrderDAO = new ImportOrderDAO();
        supplierDAO = new SupplierDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("loginAdmin");
            return;
        }
        
        try {
            // Parameters for pagination and search
            int page = 1;
            int pageSize = 10;
            String search = request.getParameter("search");
            String sortBy = request.getParameter("sortBy");
            String sortDir = request.getParameter("sortDir");
            String supplierIdParam = request.getParameter("supplierId");
            
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            // Xử lý filter theo supplier
            Integer supplierId = null;
            Supplier selectedSupplier = null;
            if (supplierIdParam != null && !supplierIdParam.trim().isEmpty()) {
                try {
                    supplierId = Integer.parseInt(supplierIdParam);
                    selectedSupplier = supplierDAO.getSupplierById(supplierId);
                    if (selectedSupplier != null) {
                        request.setAttribute("selectedSupplier", selectedSupplier);
                    }
                } catch (NumberFormatException e) {
                    // Invalid supplier ID, ignore
                }
            }
            
            // Default sorting
            if (sortBy == null || sortBy.isEmpty()) {
                sortBy = "importDate";
                sortDir = "DESC";
            }
            
            // Get import orders (filtered by supplier if specified)
            List<ImportOrder> importOrders;
            int totalRecords;
            
            if (supplierId != null) {
                // Filter by specific supplier
                importOrders = importOrderDAO.getImportOrdersBySupplier(supplierId, page, pageSize, search, sortBy, sortDir);
                totalRecords = importOrderDAO.countImportOrdersBySupplier(supplierId, search);
            } else {
                // Get all import orders
                importOrders = importOrderDAO.getAllImportOrders(page, pageSize, search, sortBy, sortDir);
                totalRecords = importOrderDAO.countImportOrders(search);
            }
            
            // Pagination calculations
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
            
            // Get all suppliers for filter dropdown
            List<Supplier> suppliers = supplierDAO.getAllSuppliers();
            
            // Set attributes
            request.setAttribute("importOrders", importOrders);
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("search", search);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortDir", sortDir);
            request.setAttribute("supplierId", supplierId);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn nhập hàng: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/Admin/ImportOrderList.jsp").forward(request, response);
    }
}
