/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Products;

import DAL.ProductDao;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateVariant", urlPatterns = {"/admin/update_variant"})
public class UpdateVariant extends HttpServlet {

    ProductDao pdao = new ProductDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateVariant</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateVariant at " + request.getContextPath() + "</h1>");
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
        String stockStatus = request.getParameter("stockStatus");
        String quantity = request.getParameter("quantity");
        String variantID = request.getParameter("variantID");
        String[] data = new String[]{stockStatus, quantity, variantID};
        if (StringConvert.isAnyFieldEmpty(data)) {
            request.getSession().setAttribute("error", "Vui lòng nhập đủ thông tin");
        } else {
            if (pdao.updateStatusVariant(data)) {
                request.getSession().setAttribute("ms", "Update thành công");
            } else {
                request.getSession().setAttribute("error", "Update không thành công.Vui lòng thử lại");
            }
        }
        response.sendRedirect("variant_details?variantID=" + variantID);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
