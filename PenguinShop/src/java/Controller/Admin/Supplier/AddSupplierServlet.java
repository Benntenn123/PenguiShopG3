package Controller.Admin.Supplier;

import DAL.SupplierDAO;
import Models.Supplier;
import Models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AddSupplierServlet", urlPatterns = {"/admin/AddSupplier"})
public class AddSupplierServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }

        // Hiển thị form thêm nhà cung cấp
        request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");
        
        if (uAdmin == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy dữ liệu từ form
        String supplierName = request.getParameter("supplierName");
        String contactName = request.getParameter("contactName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        
        // Validate dữ liệu
        String errorMessage = null;
        if (supplierName == null || supplierName.trim().isEmpty()) {
            errorMessage = "Tên nhà cung cấp không được để trống!";
        }
        
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("supplierName", supplierName);
            request.setAttribute("contactName", contactName);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.setAttribute("note", note);
            request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
            return;
        }
        
        // Tạo object Supplier
        Supplier supplier = new Supplier();
        supplier.setSupplierName(supplierName.trim());
        supplier.setContactName(contactName != null ? contactName.trim() : null);
        supplier.setPhone(phone != null ? phone.trim() : null);
        supplier.setEmail(email != null ? email.trim() : null);
        supplier.setAddress(address != null ? address.trim() : null);
        supplier.setNote(note != null ? note.trim() : null);
        
        // Thêm vào database
        SupplierDAO supplierDAO = new SupplierDAO();
        boolean success = supplierDAO.addSupplier(supplier);
        
        if (success) {
            // Thành công - redirect về danh sách với thông báo
            request.getSession().setAttribute("ms", "Thêm nhà cung cấp thành công!");
            response.sendRedirect("SupplierList");
        } else {
            // Thất bại - hiển thị lỗi
            request.getSession().setAttribute("supplierName", supplierName);
            request.setAttribute("contactName", contactName);
            request.setAttribute("phone", phone);
            request.setAttribute("email", email);
            request.setAttribute("address", address);
            request.setAttribute("note", note);
            request.getRequestDispatcher("/Admin/AddSupplier.jsp").forward(request, response);
        }
    }
}
