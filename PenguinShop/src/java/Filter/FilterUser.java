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
    urlPatterns = {"/changepassword", "/userprofile", "/orderhistory", "/logout"},
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

        HttpSession session = req.getSession();

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Chưa đăng nhập, chuyển về trang login
            session.setAttribute("error", "Vui lòng login");
            res.sendRedirect(req.getContextPath() + "/login");
        } else {
            // Đã đăng nhập, cho đi tiếp
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Optional: Dọn tài nguyên nếu cần
    }
}
