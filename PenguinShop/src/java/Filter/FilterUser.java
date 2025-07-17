package Filter;

import Models.User;
import java.io.IOException;
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

@WebFilter(
    filterName = "FilterUser",
    urlPatterns = {"/changepassword", "/userprofile", "/orderhistory", "/logout","/logUser","/deliveryinfo","/listCart","/checkout"},
    dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD}
)
public class FilterUser implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Optional: Khởi tạo nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Get the servlet path (e.g., /login, /logout, /listservices)
        String servletPath = req.getServletPath();

        // Allow access to login and logout pages without authentication
        if ("/login".equals(servletPath) || "/logout".equals(servletPath)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false); // Use false to avoid creating a new session
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // User is not logged in, redirect to login page with error message
            session = req.getSession(true); // Create session if null for error message
            session.setAttribute("error", "Vui lòng đăng nhập");
            res.sendRedirect(req.getContextPath() + "/login");
        } else {
            // User is authenticated, proceed with the request
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Optional: Dọn tài nguyên nếu cần
    }
}
