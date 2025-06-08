/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Authen;

import DAL.UserDAO;
import Utils.HashPassword;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginAdmin", urlPatterns = {"/admin/loginAdmin"})
public class LoginAdmin extends HttpServlet {
    
    UserDAO udao = new UserDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginAdmin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("../Admin/LoginAdmin.jsp").forward(request, response);
    }    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        System.out.println(email +" "+password);
        if (StringConvert.isAnyFieldEmpty(new String[]{email, password})) {
            request.getSession().setAttribute("error", "Vui lòng điền đủ email và mật khẩu!");
            response.sendRedirect("loginAdmin");
        } else {
            if (udao.authenticateUser(email, HashPassword.hashWithSHA256(password))) {
                request.getSession().setAttribute("ms", "Login thành công!");
                response.sendRedirect("dashboard");
            }
        }
        
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
