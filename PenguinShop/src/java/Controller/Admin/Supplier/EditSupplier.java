/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Supplier;

import DAL.SupplierDAO;
import Models.Supplier;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditSupplier", urlPatterns = {"/admin/EditSupplier"})
public class EditSupplier extends HttpServlet {

    private SupplierDAO supplierDAO = new SupplierDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String method = request.getMethod();

        if ("GET".equals(method)) {
            doGet(request, response);
        } else if ("POST".equals(method)) {
            doPost(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get supplier ID from parameter
            String supplierIdStr = request.getParameter("id");

            if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Không tìm thấy mã nhà cung cấp");
                response.sendRedirect("SupplierList");
                return;
            }

            int supplierId;
            try {
                supplierId = Integer.parseInt(supplierIdStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Mã nhà cung cấp không hợp lệ");
                response.sendRedirect("SupplierList");
                return;
            }

            // Get supplier details
            Supplier supplier = supplierDAO.getSupplierById(supplierId);

            if (supplier == null) {
                request.getSession().setAttribute("error", "Không tìm thấy nhà cung cấp với ID: " + supplierId);
                response.sendRedirect("SupplierList");
                return;
            }

            // Set supplier data for the form
            request.setAttribute("supplier", supplier);

            // Forward to edit supplier page
            request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Error in EditSupplier GET: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Có lỗi xảy ra khi tải thông tin nhà cung cấp");
            response.sendRedirect("SupplierList");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get supplier ID
            String supplierIdStr = request.getParameter("supplierID");

            if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Không tìm thấy mã nhà cung cấp");
                response.sendRedirect("SupplierList");
                return;
            }

            int supplierId;
            try {
                supplierId = Integer.parseInt(supplierIdStr);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Mã nhà cung cấp không hợp lệ");
                response.sendRedirect("SupplierList");
                return;
            }

            // Get form data
            String supplierName = request.getParameter("supplierName");
            String contactName = request.getParameter("contactName");
            String phoneNumber = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String notes = request.getParameter("notes");

            // Validate required fields
            if (supplierName == null || supplierName.trim().isEmpty()) {
                request.setAttribute("error", "Tên nhà cung cấp là bắt buộc");
                // Get supplier data again for the form
                Supplier supplier = supplierDAO.getSupplierById(supplierId);
                request.setAttribute("supplier", supplier);

                request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
                return;
            }

            // Clean up data
            supplierName = supplierName.trim();
            contactName = (contactName != null) ? contactName.trim() : "";
            phoneNumber = (phoneNumber != null) ? phoneNumber.trim() : "";
            email = (email != null) ? email.trim() : "";
            address = (address != null) ? address.trim() : "";
            notes = (notes != null) ? notes.trim() : "";

            // Create supplier object with updated data
            Supplier supplier = new Supplier();
            supplier.setSupplierID(supplierId);
            supplier.setSupplierName(supplierName);
            supplier.setContactName(contactName.isEmpty() ? null : contactName);
            supplier.setPhone(phoneNumber.isEmpty() ? null : phoneNumber);
            supplier.setEmail(email.isEmpty() ? null : email);
            supplier.setAddress(address.isEmpty() ? null : address);
            supplier.setNote(notes.isEmpty() ? null : notes);

            // Update supplier in database
            boolean updateResult = supplierDAO.updateSupplier(supplier);

            if (updateResult) {
                // Success - redirect to supplier details page
                request.getSession().setAttribute("ms", "Cập nhật nhà cung cấp thành công!");
                response.sendRedirect("supplier-details?id=" + supplierId);
            } else {
                // Update failed
                request.setAttribute("error", "Không thể cập nhật nhà cung cấp. Vui lòng thử lại.");

                // Get supplier data again for the form
                supplier = supplierDAO.getSupplierById(supplierId);
                request.setAttribute("supplier", supplier);

                request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("Error in EditSupplier POST: " + e.getMessage());
            e.printStackTrace();

            // Get supplier ID for error handling
            String supplierIdStr = request.getParameter("supplierID");
            if (supplierIdStr != null && !supplierIdStr.trim().isEmpty()) {
                try {
                    int supplierId = Integer.parseInt(supplierIdStr);
                    Supplier supplier = supplierDAO.getSupplierById(supplierId);
                    request.setAttribute("supplier", supplier);
                } catch (Exception ignored) {
                    // If we can't get supplier data, redirect to supplier list
                    request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật nhà cung cấp");
                    response.sendRedirect("SupplierList");
                    return;
                }
            }

            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật nhà cung cấp");
            request.getRequestDispatcher("/Admin/EditSupplier.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "EditSupplier Servlet - Handles supplier editing operations";
    }// </editor-fold>

}
