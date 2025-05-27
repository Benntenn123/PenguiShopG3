/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.Customer.ForgotPassword;

import Models.User;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="VerificationMethod", urlPatterns={"/verification_method"})
public class VerificationMethod extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerificationMethod</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerificationMethod at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User userforget = (User) request.getSession().getAttribute("userforget");
        
        String email = StringConvert.maskEmail(userforget.getEmail());
        String phone = StringConvert.maskPhoneNumber(userforget.getPhone());
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
                
        request.getRequestDispatcher("HomePage/VerificationMethod.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String method = request.getParameter("verification_method");
        String otp = StringConvert.generateRandom6DigitNumber();
        
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
