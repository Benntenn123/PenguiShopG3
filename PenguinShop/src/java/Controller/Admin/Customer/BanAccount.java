/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Admin.Customer;

import Const.Account;
import DAL.UserDAO;
import Utils.StringConvert;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BanAccount", urlPatterns = {"/admin/banAccount"})
public class BanAccount extends HttpServlet {

    UserDAO udao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BanAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BanAccount at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountID = request.getParameter("accountID");
        try {
            if (StringConvert.isEmpty(accountID)) {
                request.getSession().setAttribute("error", "Thiếu accountID");

            } else {
                int accountId = Integer.parseInt(accountID);
                if (udao.updateStatusAccount(accountId, Account.BAN_ACCOUNT)) {
                    request.getSession().setAttribute("ms", "Ban account thành công!");
                } else {
                    request.getSession().setAttribute("error", "Ban không thành công");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("listCustomerAdmin");
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
