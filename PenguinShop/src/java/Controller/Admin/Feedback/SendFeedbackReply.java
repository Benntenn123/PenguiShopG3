package Controller.Admin.Feedback;

import Utils.SendMail;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "SendFeedbackReply", urlPatterns = {"/api/sendFeedbackReply"})
public class SendFeedbackReply extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        try {
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            Gson gson = new Gson();
            Map<String, String> data = gson.fromJson(sb.toString(), Map.class);
            String email = data.get("email");
            String name = data.get("name");
            String content = data.get("content");
            if (email == null || email.isEmpty() || content == null || content.isEmpty()) {
                result.put("success", false);
                result.put("message", "Thiếu thông tin email hoặc nội dung phản hồi.");
            } else {
                boolean sent = SendMail.sendMailReplyFeedbackAsync(email, name, content);
                result.put("success", sent);
                result.put("message", sent ? "Gửi phản hồi thành công." : "Gửi phản hồi thất bại.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Lỗi hệ thống: " + e.getMessage());
        }
        out.print(new Gson().toJson(result));
        out.flush();
    }
}
