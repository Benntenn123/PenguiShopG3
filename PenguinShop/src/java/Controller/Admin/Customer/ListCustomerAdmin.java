/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Customer;

import Const.Account;
import DAL.UserDAO;
import Models.User;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import static jakarta.servlet.http.HttpServlet.LEGACY_DO_HEAD;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "ListCustomerAdmin", urlPatterns = {"/admin/listCustomerAdmin"})
public class ListCustomerAdmin extends HttpServlet {
    UserDAO udao = new UserDAO();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListCustomerAdmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListCustomerAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] data = getData(request);
        try {
            int page = 1;
            if(data[0] != null){
                page = Integer.parseInt(data[0]);
            }
            List<User> list = udao.getAllUser(page, 12,
                data[2], data[4], data[3], Account.ROLE_CUSTOMER);
            request.setAttribute("list", list);
        } catch (Exception e) {
        }
        
        request.getRequestDispatcher("../Admin/ListCustomerAdmin.jsp").forward(request, response);
    }

    private String[] getData(HttpServletRequest request) {
        String page = request.getParameter("page");
        String fullname = request.getParameter("fullName");
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String image_user = request.getParameter("image_user");
        return new String[]{page, fullname, birthday, phone, email, image_user};
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
