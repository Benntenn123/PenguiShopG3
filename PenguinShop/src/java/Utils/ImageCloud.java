/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Utils;

import APIKey.CloudinaryConfig;
import com.cloudinary.Cloudinary;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="ImageCloud", urlPatterns={"/api/img/*"})
public class ImageCloud extends HttpServlet {
    private Cloudinary cloudinary;

    @Override
    public void init() throws ServletException {
        cloudinary = CloudinaryConfig.getCloudinary();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String imgLink = request.getPathInfo();
        if (imgLink == null || imgLink.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tên hình ảnh");
            return;
        }

        if (imgLink.startsWith("/")) {
            imgLink = imgLink.substring(1);
        }

        String publicId = imgLink.replaceFirst("\\.[^.]+$", "");
        String cloudinaryUrl = cloudinary.url()
                .resourceType("image")
                .secure(true)
                .publicId(publicId)
                .format(imgLink.substring(imgLink.lastIndexOf(".") + 1))
                .generate();

        response.sendRedirect(cloudinaryUrl);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
