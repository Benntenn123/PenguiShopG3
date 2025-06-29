/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.Admin.Products.Promotion;

import DAL.PromotionDAO;
import Models.Promotion;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name="GetPromotionsByVariant", urlPatterns={"/getPromotionsByVariant"})
public class GetPromotionsByVariant extends HttpServlet {
    private PromotionDAO promotionDAO = new PromotionDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetPromotionsByVariant</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetPromotionsByVariant at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Read JSON from request
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        // Parse JSON to get variantIds
        Gson gson = new Gson();
        JsonObject jsonObject;
        try {
            jsonObject = gson.fromJson(sb.toString(), JsonObject.class);
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Invalid JSON format");
            response.getWriter().write(gson.toJson(errorResponse));
            return;
        }

        JsonArray variantIdsJson = jsonObject.getAsJsonArray("variantIds");
        List<Integer> variantIds = new ArrayList<>();
        for (int i = 0; i < variantIdsJson.size(); i++) {
            try {
                variantIds.add(variantIdsJson.get(i).getAsInt());
            } catch (Exception e) {
                // Skip invalid variantID
            }
        }

        // Get promotions from DAO
        Map<Integer, List<Promotion>> promotionsByVariant = promotionDAO.getPromotionsByVariantIds(variantIds);

        // Build JSON response
        JsonArray resultArray = new JsonArray();
        for (Integer variantId : variantIds) {
            JsonObject variantPromotions = new JsonObject();
            variantPromotions.addProperty("variantID", variantId);
            JsonArray promotionsArray = new JsonArray();
            List<Promotion> promotions = promotionsByVariant.getOrDefault(variantId, new ArrayList<>());
            for (Promotion promotion : promotions) {
                JsonObject promotionJson = new JsonObject();
                promotionJson.addProperty("promotionID", promotion.getPromotionID());
                promotionJson.addProperty("promotionName", promotion.getPromotionName());
                promotionJson.addProperty("discountType", promotion.getDiscountType());
                promotionJson.addProperty("discountValue", promotion.getDiscountValue());
                promotionJson.addProperty("startDate", promotion.getStartDate());
                promotionJson.addProperty("endDate", promotion.getEndDate());
                promotionJson.addProperty("description", promotion.getDescription());
                promotionJson.addProperty("isActive", promotion.getIsActive());
                promotionsArray.add(promotionJson);
            }
            variantPromotions.add("promotions", promotionsArray);
            resultArray.add(variantPromotions);
        }

        // Return JSON response
        JsonObject responseJson = new JsonObject();
        responseJson.addProperty("success", true);
        responseJson.add("data", resultArray);

        response.getWriter().write(gson.toJson(responseJson));
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
