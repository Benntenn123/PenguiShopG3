package Controller.Admin.Supplier;

import DAL.SupplierDAO;
import DAL.ImportOrderDAO;
import DAL.ProductVariantDAO;
import Models.Supplier;
import Models.ImportOrder;
import Models.VariantDTO;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SupplierController", urlPatterns = {"/admin/supplier"})
public class SupplierController extends HttpServlet {
    
    private SupplierDAO supplierDAO = new SupplierDAO();
    private ImportOrderDAO importOrderDAO = new ImportOrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listSuppliers(request, response);
                break;
            case "view":
                viewSupplier(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "recent-orders":
                showRecentOrders(request, response);
                break;
            default:
                listSuppliers(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "add":
                addSupplier(request, response);
                break;
            case "edit":
                editSupplier(request, response);
                break;
            case "delete":
                deleteSupplier(request, response);
                break;
            default:
                response.sendRedirect("supplier");
                break;
        }
    }
    
    private void listSuppliers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy tham số phân trang và tìm kiếm
        int page = 1;
        int pageSize = 10;
        String search = request.getParameter("search");
        String sortBy = request.getParameter("sortBy");
        String sortDir = request.getParameter("sortDir");
        
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "supplierName";
        }
        if (sortDir == null || sortDir.isEmpty()) {
            sortDir = "ASC";
        }
        
        // Lấy danh sách nhà cung cấp
        List<Supplier> suppliers = supplierDAO.getAllSuppliers(page, pageSize, search, sortBy, sortDir);
        int totalSuppliers = supplierDAO.countSuppliers(search);
        int totalPages = (int) Math.ceil((double) totalSuppliers / pageSize);
        
        // Set attributes
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalSuppliers", totalSuppliers);
        request.setAttribute("search", search);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortDir", sortDir);
        
        request.getRequestDispatcher("/Admin/ListSuppliers.jsp").forward(request, response);
    }
    
    private void viewSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int supplierID = Integer.parseInt(request.getParameter("id"));
            Supplier supplier = supplierDAO.getSupplierById(supplierID);
            
            if (supplier != null) {
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/Admin/ViewSupplier.jsp").forward(request, response);
            } else {
                response.sendRedirect("supplier?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("supplier?error=invalid");
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int supplierID = Integer.parseInt(request.getParameter("id"));
            Supplier supplier = supplierDAO.getSupplierById(supplierID);
            
            if (supplier != null) {
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
            } else {
                response.sendRedirect("supplier?error=notfound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("supplier?error=invalid");
        }
    }
    
    private void showRecentOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<ImportOrder> recentOrders = importOrderDAO.getRecentImportOrders();
        request.setAttribute("recentOrders", recentOrders);
        request.getRequestDispatcher("/Admin/RecentImportOrders.jsp").forward(request, response);
    }
    
    private void addSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String supplierName = request.getParameter("supplierName");
        String contactName = request.getParameter("contactName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        
        // Validate
        if (supplierName == null || supplierName.trim().isEmpty()) {
            request.setAttribute("error", "Tên nhà cung cấp không được để trống");
            request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
            return;
        }
        
        Supplier supplier = new Supplier();
        supplier.setSupplierName(supplierName.trim());
        supplier.setContactName(contactName != null ? contactName.trim() : null);
        supplier.setPhone(phone != null ? phone.trim() : null);
        supplier.setEmail(email != null ? email.trim() : null);
        supplier.setAddress(address != null ? address.trim() : null);
        supplier.setNote(note != null ? note.trim() : null);
        
        if (supplierDAO.addSupplier(supplier)) {
            response.sendRedirect("supplier?success=added");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi thêm nhà cung cấp");
            request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
        }
    }
    
    private void editSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            String supplierName = request.getParameter("supplierName");
            String contactName = request.getParameter("contactName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String note = request.getParameter("note");
            
            // Validate
            if (supplierName == null || supplierName.trim().isEmpty()) {
                request.setAttribute("error", "Tên nhà cung cấp không được để trống");
                Supplier supplier = supplierDAO.getSupplierById(supplierID);
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
                return;
            }
            
            Supplier supplier = new Supplier();
            supplier.setSupplierID(supplierID);
            supplier.setSupplierName(supplierName.trim());
            supplier.setContactName(contactName != null ? contactName.trim() : null);
            supplier.setPhone(phone != null ? phone.trim() : null);
            supplier.setEmail(email != null ? email.trim() : null);
            supplier.setAddress(address != null ? address.trim() : null);
            supplier.setNote(note != null ? note.trim() : null);
            
            if (supplierDAO.updateSupplier(supplier)) {
                response.sendRedirect("supplier?success=updated");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật nhà cung cấp");
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect("supplier?error=invalid");
        }
    }
    
    private void deleteSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int supplierID = Integer.parseInt(request.getParameter("supplierID"));
            
            if (supplierDAO.deleteSupplier(supplierID)) {
                response.sendRedirect("supplier?success=deleted");
            } else {
                response.sendRedirect("supplier?error=delete_failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("supplier?error=invalid");
        }
    }
}
