/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "FilterAdmin", urlPatterns = {"/admin/*"}, dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD})
public class FilterAdmin implements Filter {
    private UserDAO adao = new UserDAO();
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession();
        User uAdmin = (User) session.getAttribute("uAdmin");

        String contextPath = request.getContextPath();
        String requestPath = request.getRequestURI().substring(contextPath.length());
        
        System.out.println("Context Path: " + contextPath);
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Final Request Path: " + requestPath);
        
        if (requestPath.equals("/admin/loginAdmin") || requestPath.equals("/admin/logoutAdmin")) {
            chain.doFilter(request, response);
            return;
        }
        if (requestPath.matches(".+\\.(css|js|png|jpg|gif|ico|woff2|woff|ttf|svg)$")) {
            chain.doFilter(request, response);
            return;
        }

        if (uAdmin == null) {
            request.getSession().setAttribute("error", "Đã có lỗi xảy ra! Vui lòng đăng nhập lại!");
            response.sendRedirect("loginAdmin");
            return;
        }
        if (uAdmin.getRole().getRoleID() == 2) {
            request.getSession().setAttribute("error", "Bạn không có quyền để truy cập vào đường dẫn này!");
            response.sendRedirect("loginAdmin");
            return;
        }
        if(!adao.hasPermission(uAdmin.getRole().getRoleID(), requestPath)){
            request.getSession().setAttribute("error", "Bạn không có quyền để vô trang này!");
            response.sendRedirect("dashboard");
            return;
        }

        chain.doFilter(request, response);

    }
    
    
}
