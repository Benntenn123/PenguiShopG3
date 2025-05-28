/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package Filter;

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

@WebFilter(filterName = "FilterForgotPassword", 
        urlPatterns = {"/reset_password","/otpchecking","/verification_method"}, 
        dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.INCLUDE})

public class FilterForgotPassword implements Filter {

    private FilterConfig filterConfig = null;

    public FilterForgotPassword() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession();

        User user = (session != null) ? (User) session.getAttribute("userforget") : null;

        if (user == null) {
            // Chưa đăng nhập, chuyển về trang login
            session.setAttribute("error", "Vui lòng làm theo từng bước");
            res.sendRedirect(req.getContextPath() + "/forgotpassword");
        } else {
            // Đã đăng nhập, cho đi tiếp
            chain.doFilter(request, response);
        }
    }
    
    
}
