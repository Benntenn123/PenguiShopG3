/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.HomePage.DashBoard;

import DAL.RequestDAO;
import Utils.SendMail;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="SendRequestSupport", urlPatterns={"/sendRequestSupport"})
public class SendRequestSupport extends HttpServlet {
    RequestDAO rdao = new RequestDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SendRequestSupport</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendRequestSupport at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String[] data = getData(request);
        if(StringConvert.isAnyFieldEmpty(data)){
            request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin");      
        }
        else{
            if(rdao.addRequestSupport(data)){
                System.out.println(data[2]);
                System.out.println(data[0]);
                SendMail.sendMailAsyncCamOn(data[0],data[2]);
                request.getSession().setAttribute("ms", "Gửi phản hồi thành công! Chúng tôi sẽ phản hồi bạn sớm nhất có thể!");
            }
            else{
                request.getSession().setAttribute("error", "Gửi phản hồi thất bại! Vui lòng thử lại!");
            }
        }
        response.sendRedirect("trangchu");
    }
    private String[] getData(HttpServletRequest request){
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String issueType = request.getParameter("issueType");
        String description = request.getParameter("description");
        return new String[]{email,phone, fullName, issueType, description};
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
