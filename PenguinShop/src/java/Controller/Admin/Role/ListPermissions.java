/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Role;

import Const.Batch;
import DAL.PermissionDAO;
import Models.Modules;
import Models.Permission;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ListPermissions", urlPatterns = {"/admin/listPermission"})
public class ListPermissions extends HttpServlet {

    private static final int PAGE_SIZE = Batch.BATCH_SEARCH_CUSTOMER;
     PermissionDAO permissionDAO = new PermissionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListPermissions</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListPermissions at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String permissionName = request.getParameter("permissionName");
    String moduleIdStr = request.getParameter("module");
    try {
        Integer moduleId = (moduleIdStr != null && !moduleIdStr.isEmpty()) ? Integer.parseInt(moduleIdStr) : null;
        int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        // Lấy danh sách module cho dropdown
        List<Modules> moduleList = permissionDAO.getAllModules(); // Sửa Modules thành Module
        request.setAttribute("moduleList", moduleList);
        // Lấy danh sách permission và roleNamesMap
        Map<String, Object> result = permissionDAO.getPermissions(permissionName, moduleId, currentPage, PAGE_SIZE);
        List<Permission> listPermissions = (List<Permission>) result.get("permissions");
     
        Map<Integer, String> roleNamesMap = (Map<Integer, String>) result.get("roleNamesMap");
        request.setAttribute("listPermissions", listPermissions);
        request.setAttribute("roleNamesMap", roleNamesMap);
        
        // Lấy số liệu thống kê
        int totalPermissions = permissionDAO.getTotalPermissions(permissionName, moduleId);
        int menuItemCount = permissionDAO.getMenuItemCount(permissionName, moduleId);
        int nonMenuItemCount = totalPermissions - menuItemCount;

        // Tính toán phân trang
        int totalPages = (int) Math.ceil((double) totalPermissions / PAGE_SIZE);
        int startRecord = (currentPage - 1) * PAGE_SIZE + 1;
        int endRecord = Math.min(currentPage * PAGE_SIZE, totalPermissions);

        // Đặt các thuộc tính cho JSP
        request.setAttribute("totalPermissions", totalPermissions);
        request.setAttribute("menuItemCount", menuItemCount);
        request.setAttribute("nonMenuItemCount", nonMenuItemCount);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startRecord", startRecord);
        request.setAttribute("endRecord", endRecord);
        request.setAttribute("totalRecords", totalPermissions);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("../Admin/ListPermissions.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace(); // In stack trace ra console
        throw new ServletException("Error processing request", e); // Ném lại để hiển thị lỗi
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
