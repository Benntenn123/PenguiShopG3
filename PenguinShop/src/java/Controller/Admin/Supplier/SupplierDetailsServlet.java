package Controller.Admin.Supplier;

import DAL.SupplierDAO;
import Models.Supplier;
import Models.ImportOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SupplierDetailsServlet", urlPatterns = {"/admin/supplier-details"})
public class SupplierDetailsServlet extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    
    @Override
    public void init() throws ServletException {
        supplierDAO = new SupplierDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String supplierIdParam = request.getParameter("id");
        
        if (supplierIdParam == null || supplierIdParam.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Không tìm thấy thông tin nhà cung cấp");
            response.sendRedirect("SupplierList");
            
            return;
        }
        
        try {
            int supplierId = Integer.parseInt(supplierIdParam);
            
            // Lấy thông tin nhà cung cấp
            Supplier supplier = supplierDAO.getSupplierById(supplierId);
            
            if (supplier == null) {
                request.getSession().setAttribute("error", "Không tìm thấy nhà cung cấp với ID: " + supplierId);
                response.sendRedirect("SupplierList");
                return;
            }
            
            // Lấy 5 lần nhập hàng gần nhất
            List<ImportOrder> recentImportOrders = supplierDAO.getRecentImportOrders(supplierId, 5);
            
            // Lấy thống kê
            int totalImportOrders = supplierDAO.countImportOrdersBySupplier(supplierId);
            double totalImportValue = supplierDAO.getTotalImportValueBySupplier(supplierId);
            
            // Set attributes cho JSP
            request.setAttribute("supplier", supplier);
            request.setAttribute("recentImportOrders", recentImportOrders);
            request.setAttribute("totalImportOrders", totalImportOrders);
            request.setAttribute("totalImportValue", totalImportValue);
            
            // Forward đến JSP
            request.getRequestDispatcher("/Admin/SupplierDetails.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID nhà cung cấp không hợp lệ");
            response.sendRedirect("SupplierList");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi tải thông tin nhà cung cấp");
            response.sendRedirect("SupplierList");;
        }
    }
}
