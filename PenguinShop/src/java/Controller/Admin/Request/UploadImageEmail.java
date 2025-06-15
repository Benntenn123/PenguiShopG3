/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Request;

import APIKey.CloudinaryConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
@MultipartConfig
@WebServlet(name="UploadImageEmail", urlPatterns={"/api/upload-image"})
public class UploadImageEmail extends HttpServlet {
    private CloudinaryConfig cloudinaryService = new CloudinaryConfig();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadImageEmail</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadImageEmail at " + request.getContextPath () + "</h1>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get file part from request
            Part filePart = request.getPart("file");
            if (filePart == null || filePart.getSize() == 0) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"error\": \"No file uploaded\"}");
                return;
            }

            // Get file name and input stream
            String fileName = filePart.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) {
                fileName = "uploaded_image_" + System.currentTimeMillis();
            }

            // Upload to Cloudinary
            String publicId = cloudinaryService.uploadImage(filePart.getInputStream(), fileName);
            if (publicId == null) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"error\": \"Failed to upload image to Cloudinary\"}");
                return;
            }

            // Get secure URL
            String imageUrl = cloudinaryService.getImageUrl(publicId);
            if (imageUrl == null) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"error\": \"Failed to generate image URL\"}");
                return;
            }

            // Return JSON response for CKEditor
            out.write("{\"imageUrl\": \"" + imageUrl + "\"}");

        } catch (Exception e) {
            System.out.println("Error in UploadImageServlet: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\": \"Server error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
