package Controller.HomePage.Customer;

import DAL.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(name = "Register", urlPatterns = {"/register"})
public class Register extends HttpServlet {

    private static final Logger LOGGER = LogManager.getLogger(Login.class);
    UserDAO udao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("User vào trang /register");
        request.getRequestDispatcher("HomePage/Register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String res = "";
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (action.equals("checkPhone")) {
            String phone_number = request.getParameter("phone_number").trim();
            res = checkPhone(request,phone_number);
        }
        if (action.equals("checkEmail")) {
            String email = request.getParameter("email").trim();
            res = checkEmail(request,email);
        }
        response.getWriter().write(res);
    }

    private String checkPhone(HttpServletRequest request, String phone_number) {  
        String status = "oke";
        if (udao.checkExistPhoneUser(phone_number)) {
            status = "exist";
        }
        return "{\"status\":\"" + status + "\"}";
    }
    private String checkEmail(HttpServletRequest request, String email) {  
        String status = "oke";
        if (udao.checkExistEmail(email)) {
            status = "exist";
        }
        return "{\"status\":\"" + status + "\"}";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
