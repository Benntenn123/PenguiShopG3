package Controller.Admin.ImportOrder;

import DAL.SupplierDAO;
import DAL.ImportOrderDAO;
import Models.Supplier;
import Models.ImportOrder;
import Models.ImportOrderDetail;
import Models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

@WebServlet(name = "AddImportOrderServlet", urlPatterns = {"/admin/AddImportOrder"})
public class AddImportOrderServlet extends HttpServlet {
    
    private SupplierDAO supplierDAO;
    private ImportOrderDAO importOrderDAO;
    
    @Override
    public void init() throws ServletException {
        supplierDAO = new SupplierDAO();
        importOrderDAO = new ImportOrderDAO();
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
        
        String supplierIdParam = request.getParameter("supplierId");
        
        // Lấy danh sách nhà cung cấp cho dropdown
        List<Supplier> suppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("suppliers", suppliers);
        
        // Nếu có supplierId từ parameter, set làm selected
        if (supplierIdParam != null && !supplierIdParam.trim().isEmpty()) {
            try {
                int supplierId = Integer.parseInt(supplierIdParam);
                Supplier selectedSupplier = supplierDAO.getSupplierById(supplierId);
                if (selectedSupplier != null) {
                    request.setAttribute("selectedSupplierId", supplierId);
                    request.setAttribute("selectedSupplier", selectedSupplier);
                }
            } catch (NumberFormatException e) {
                // Ignore invalid supplierId
            }
        }
        
        request.getRequestDispatcher("/Admin/AddImportOrder.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("loginAdmin");
            return;
        }
        
        try {
            // Lấy thông tin cơ bản của đơn nhập
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String note = request.getParameter("note");
            String importDateStr = request.getParameter("importDate");
            
            // Parse import date
            Date importDate = new Date();
            if (importDateStr != null && !importDateStr.trim().isEmpty()) {
                importDate = java.sql.Date.valueOf(importDateStr);
            }
            
            // Lấy danh sách sản phẩm từ form
            String[] productIds = request.getParameterValues("productId");
            String[] variantIds = request.getParameterValues("variantId");
            String[] quantities = request.getParameterValues("quantity");
            String[] importPrices = request.getParameterValues("importPrice");
            
            if (productIds == null || productIds.length == 0) {
                request.setAttribute("error", "Vui lòng chọn ít nhất một sản phẩm");
                doGet(request, response);
                return;
            }
            
            // Tạo ImportOrder
            ImportOrder importOrder = new ImportOrder();
            importOrder.setSupplierID(supplierId);
            importOrder.setNote(note);
            importOrder.setImportDate(new Timestamp(importDate.getTime()));
            
            // Tạo danh sách ImportOrderDetail
            List<ImportOrderDetail> details = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;
            
            for (int i = 0; i < productIds.length; i++) {
                if (productIds[i] != null && !productIds[i].trim().isEmpty()) {
                    ImportOrderDetail detail = new ImportOrderDetail();
                    
                    // Phải có variantId để lưu vào database
                    if (variantIds != null && variantIds[i] != null && !variantIds[i].trim().isEmpty()) {
                        detail.setVariantID(Integer.parseInt(variantIds[i]));
                    } else {
                        // Nếu không có variantId, skip item này
                        continue;
                    }
                    
                    detail.setQuantity(Integer.parseInt(quantities[i]));
                    detail.setImportPrice(new BigDecimal(importPrices[i]));
                    
                    // Tính subtotal
                    BigDecimal subtotal = detail.getImportPrice().multiply(new BigDecimal(detail.getQuantity()));
                    totalAmount = totalAmount.add(subtotal);
                    
                    details.add(detail);
                }
            }
            
            importOrder.setTotalImportAmount(totalAmount);
            importOrder.setDetails(details);
            
            // Debug: In thông tin trước khi lưu
            System.out.println("=== DEBUG AddImportOrder ===");
            System.out.println("Total details: " + details.size());
            for (ImportOrderDetail detail : details) {
                System.out.println("VariantID: " + detail.getVariantID() + 
                                 ", Quantity: " + detail.getQuantity() + 
                                 ", Price: " + detail.getImportPrice());
            }
            System.out.println("Total Amount: " + totalAmount);
            
            // Lưu vào database
            int result = importOrderDAO.addImportOrder(importOrder);
            
            if (result > 0) {
                session.setAttribute("ms", "Tạo đơn nhập hàng thành công!");
                response.sendRedirect("ImportOrderList");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi tạo đơn nhập hàng");
                doGet(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }
}
