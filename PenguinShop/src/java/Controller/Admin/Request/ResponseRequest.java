/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Request;

import DAL.RequestDAO;
import Models.CustomerRequest;
import Utils.SendMail;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet(name="ResponseRequest", urlPatterns={"/admin/responseSupport"})
public class ResponseRequest extends HttpServlet {
    RequestDAO requestDAO = new RequestDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResponseRequest</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResponseRequest at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Get requestID from URL
            String requestIDParam = request.getParameter("requestID");
            if (requestIDParam == null || requestIDParam.isEmpty()) {
                request.getSession().setAttribute("error", "Thiếu ID yêu cầu.");
                response.sendRedirect("listRequestSupport");
                return;
            }

            int requestID = Integer.parseInt(requestIDParam);

            // Fetch request details
            CustomerRequest customerRequest = requestDAO.getCustomerRequestById(requestID);
            if (customerRequest == null) {
                request.getSession().setAttribute("error", "Không tìm thấy yêu cầu với ID: " + requestID);
                response.sendRedirect("listRequestSupport");
                return;
            }

            // Set attributes and forward to JSP
            request.setAttribute("customerRequest", customerRequest);
            request.getRequestDispatcher("../Admin/ResponseSupport.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID yêu cầu không hợp lệ.");
            response.sendRedirect("listRequestSupport");
            
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Lỗi khi tải chi tiết yêu cầu: " + e.getMessage());
            response.sendRedirect("listRequestSupport");
            
        } 
        
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String textarea = request.getParameter("responseContent");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String requestID = request.getParameter("requestID");
        String fullName = request.getParameter("fullName");
        String[] data = new String[]{textarea,email,subject,requestID,fullName};
        if(StringConvert.isAnyFieldEmpty(data)){
            request.getSession().setAttribute("error", "Vui lòng điền đủ thông tin!");
        }
        else{
            try {
                int rID = Integer.parseInt(requestID);
                if(requestDAO.updateRequest(textarea, rID)){
                    SendMail.sendMailAsyncCamOn2(email, fullName, textarea);
                    request.getSession().setAttribute("ms", "Phản hồi thành công!");
                }
                else{
                    request.getSession().setAttribute("error", "Phản hồi thất bại! Vui lòng thử lại");
                }
            } catch (Exception e) {
            }
            
        }
        response.sendRedirect("responseSupport?requestID="+requestID);
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
