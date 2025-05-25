/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.HomePage.Customer.Profile;

import DAL.UserDAO;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.text.SimpleDateFormat;
import java.util.Date;
@MultipartConfig
@WebServlet(name = "UserProfile", urlPatterns = {"/userprofile"})
public class UserProfile extends HttpServlet {

    UserDAO udao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("HomePage/UserProfile.jsp").forward(request, response);
    }

    private User getUserData(HttpServletRequest request) {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("gmail");
        String phone = request.getParameter("telephone");
        String address = request.getParameter("addres");
        String birthdayStr = request.getParameter("birthday");
        String imageUser = request.getParameter("imageOld"); // default to old image

        Date birthday = null;

        try {
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                birthday = new SimpleDateFormat("yyyy-MM-dd").parse(birthdayStr);
            }

            Part filePart = request.getPart("input-file");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                byte[] imageData = filePart.getInputStream().readAllBytes();
                String baseUrl = request.getRequestURL().toString().replace(request.getRequestURI(), request.getContextPath());
                imageUser = Utils.ImageServices.saveImageToLocal(imageData, fileName, baseUrl);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        User user = (User) request.getSession().getAttribute("user");
        

        return new User(user.getUserID(),fullName, address, birthday, phone, email, imageUser);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getUserData(request);
        
        boolean isUpdated = udao.updateUserProfile(user);

        if (isUpdated) {
            request.getSession().setAttribute("ms", "Update profile thành công!");
            request.getSession().removeAttribute("user");
        } else {
            request.getSession().setAttribute("error", "Update không thành công!");
        }

        response.sendRedirect("trangchu");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
