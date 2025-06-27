/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Role;

import DAL.PermissionDAO;
import Models.Role;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ListRole", urlPatterns = {"/admin/listRoleAdmin"})
public class ListRole extends HttpServlet {

    PermissionDAO pdao = new PermissionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListRole</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListRole at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Role> role = pdao.getAllRole();
        request.setAttribute("totalRole", role.size());
        request.setAttribute("role", role);
        request.getRequestDispatcher("../Admin/ListRoleAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roleName = request.getParameter("roleName");
        String action = request.getParameter("action");
        String roleID = request.getParameter("roleId");
        try {

            if (StringConvert.isEmpty(action)) {
                request.getSession().setAttribute("error", "Đã có lỗi xảy ra vui lòng thử lại");
                response.sendRedirect("listRoleAdmin");
            }
            if (StringConvert.isEmpty(roleName)) {
                request.getSession().setAttribute("error", "Tên nhóm quyền không được để trống");
                response.sendRedirect("listRoleAdmin");
            } else {
                if (action.equals("add")) {
                    if (pdao.insertRole(roleName)) {
                        request.getSession().setAttribute("ms", "Thêm nhóm quyền thành công");
                        response.sendRedirect("listRoleAdmin");
                    } else {
                        request.getSession().setAttribute("errpr", "Thêm nhóm quyền không thành công");
                        response.sendRedirect("listRoleAdmin");
                    }
                }
                if (action.equals("edit")) {
                    int roleId = Integer.parseInt(roleID);
                    if (pdao.updateRole(roleName,roleId)) {
                        request.getSession().setAttribute("ms", "Sửa nhóm quyền thành công");
                        response.sendRedirect("listRoleAdmin");
                    } else {
                        request.getSession().setAttribute("error", "Sửa nhóm quyền không thành công");
                        response.sendRedirect("listRoleAdmin");
                    }
                } else {
                    request.getSession().setAttribute("error", "Đã có lỗi xảy ra");
                    response.sendRedirect("listRoleAdmin");
                }
            }
        } catch (Exception e) {
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
