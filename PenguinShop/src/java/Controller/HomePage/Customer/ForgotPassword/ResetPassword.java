/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Customer.ForgotPassword;

import DAL.UserDAO;
import Models.User;
import Utils.HashPassword;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name="ResetPassword", urlPatterns={"/reset_password"})
public class ResetPassword extends HttpServlet {
   
    UserDAO udao = new UserDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("HomePage/ResetPassword.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String password = request.getParameter("newPassword");
        System.out.println(password);
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        User userforgot = (User) session.getAttribute("userforget");
        if(password.isEmpty() || password == null || confirmPassword.isEmpty() || confirmPassword == null){
            request.getSession().setAttribute("error", "Vui lòng nhập đủ thông tin");
            response.sendRedirect("reset_password");
        }
        if(!password.equals(confirmPassword)){
            request.getSession().setAttribute("error", "Mật khẩu không trùng khớp");
            response.sendRedirect("reset_password");
        }
        if(udao.updatePassword(userforgot.getUserID(), HashPassword.hashWithSHA256(password))){
            request.getSession().setAttribute("ms", "Khôi phục mật khẩu thành công");
            response.sendRedirect("login");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
