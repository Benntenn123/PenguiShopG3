/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products;

import DAL.MeterialDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="AddColor", urlPatterns={"/admin/add-color"})
public class AddColor extends HttpServlet {
    MeterialDAO attributeDAO = new MeterialDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddColor</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddColor at " + request.getContextPath () + "</h1>");
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
        try {
            String colorName = request.getParameter("colorName").trim();
            
            if (colorName == null || colorName.isEmpty()) {
                request.getSession().setAttribute("error", "Không được để null");
                response.sendRedirect("managevariant");
                return;
            }

            if (attributeDAO.addColor(colorName)) {
                request.getSession().setAttribute("ms", "Thêm màu sắc thành công");
                response.sendRedirect("managevariant");
            } else {
                request.getSession().setAttribute("error", "Thêm màu sắc không thành công! Vui lòng thử lại");
                response.sendRedirect("managevariant");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error","Lỗi: " + e.getMessage());
            response.sendRedirect("managevariant");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
