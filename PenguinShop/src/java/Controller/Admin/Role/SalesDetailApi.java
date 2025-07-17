package Controller.Admin.Role;

import DAL.UserDAO;
import DAL.PermissionDAO;
import Models.User;
import Models.Permission;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SalesDetailApi", urlPatterns = {"/api/salesDetail"})
public class SalesDetailApi extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        String idStr = request.getParameter("id");
        try {
            int userId = Integer.parseInt(idStr);
            UserDAO userDAO = new UserDAO();
            PermissionDAO permissionDAO = new PermissionDAO();
            User user = userDAO.getUserById(userId);
            if (user != null) {
                // Lấy danh sách quyền theo roleID
                List<Permission> permissions = permissionDAO.getAvailablePermissionsForRole(user.getRoleID());
                // Nếu User có setPermissions thì gọi trực tiếp (giả sử User là class tự định nghĩa)
                if (user instanceof Models.User) {
                    ((Models.User) user).setPermissions(permissions);
                }
            }
            String json = new Gson().toJson(user);
            response.getWriter().write(json);
        } catch (Exception e) {
            response.getWriter().write("{}");
        }
    }
}
