/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Role;

import Const.Batch;
import DAL.PermissionDAO;
import Models.Permission;
import Models.Role;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.sql.SQLException;

@WebServlet(name="ManageRolePermissions", urlPatterns={"/admin/manage_role_permissions"})
public class ManageRolePermissions extends HttpServlet {
    PermissionDAO permissionDAO = new PermissionDAO();
    int PAGE_SIZE = Batch.BATCH_SEARCH_PRODUCT;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageRolePermissions</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageRolePermissions at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            // Lấy danh sách role cho dropdown
            List<Role> roleList = permissionDAO.getAllRole();
            request.setAttribute("roleList", roleList);

            // Xử lý phân trang
            String roleIdStr = request.getParameter("roleId");
            if (roleIdStr != null && !roleIdStr.isEmpty()) {
                int roleId = Integer.parseInt(roleIdStr);
                int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

                // Lấy permission của role với phân trang
                List<Permission> rolePermissions = permissionDAO.getPermissionsByRole(roleId, currentPage, PAGE_SIZE);
                List<Permission> availablePermissions = permissionDAO.getAvailablePermissionsForRole(roleId);
                
                // Tính toán phân trang
                int totalPermissions = permissionDAO.getTotalPermissionsByRole(roleId);
                int totalPages = (int) Math.ceil((double) totalPermissions / PAGE_SIZE);
                int startRecord = (currentPage - 1) * PAGE_SIZE + 1;
                int endRecord = Math.min(currentPage * PAGE_SIZE, totalPermissions);

                // Đặt thuộc tính cho JSP
                request.setAttribute("rolePermissions", rolePermissions);
                request.setAttribute("availablePermissions", availablePermissions);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("startRecord", startRecord);
                request.setAttribute("endRecord", endRecord);
                request.setAttribute("totalRecords", totalPermissions);
            }

            // Chuyển hướng đến JSP
            request.getRequestDispatcher("/Admin/ManageRolePermissions.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("/Admin/ManageRolePermissions.jsp").forward(request, response);
        }
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int permissionId = Integer.parseInt(request.getParameter("permissionId"));

            if ("add".equals(action)) {
                // Thêm permission cho role
                permissionDAO.addRolePermission(roleId, permissionId);
                request.setAttribute("message", "Thêm quyền thành công!");
            } else if ("remove".equals(action)) {
                // Xóa permission khỏi role
                permissionDAO.removeRolePermission(roleId, permissionId);
                request.setAttribute("message", "Xóa quyền thành công!");
            }

            // Tải lại dữ liệu và chuyển hướng
            response.sendRedirect("manage_role_permissions?roleId=" + roleId);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            doGet(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            doGet(request, response);
        }
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
