package Utils;

import APIKey.Gmail;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.internet.MimeUtility;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Properties;

public class SendMail {

    public static boolean sendMailAsync(String email, String nameUser, String userId, String token) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.guiMailVerify(email, nameUser, userId, token);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }

    public static boolean guiMailVerify(String email, String nameUser, String userId, String token) throws UnsupportedEncodingException, AddressException, MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", Gmail.HOST_NAME);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", Gmail.TSL_PORT);

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Gmail.APP_EMAIL, Gmail.APP_PASSWORD);
            }
        });

        // Bật debug để kiểm tra chi tiết
        session.setDebug(true);

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Gmail.APP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

            String subject = "Xác thực tài khoản của bạn";

            // Tạo token cho link xác thực bằng cách ghép userId với UUID
            String verifyLink = "http://127.0.0.1:8080/PenguinShop/verify?token=" + token; // Thay "yourdomain.com" bằng domain của bạn

            // Nội dung email mới
            String emailContent = "<html><head>"
                    + "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
                    + "<style>"
                    + "  body { font-family: Arial, sans-serif; }"
                    + "  .email-container { width: 100%; padding: 20px; background-color: #f4f4f4; text-align: center; }"
                    + "  .email-content { background-color: #fff; padding: 20px; border-radius: 10px; width: 100%; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); }"
                    + "  h2 { color: #333; }"
                    + "  a.verify-link { display: inline-block; padding: 10px 20px; background-color: #3498db; color: #fff; text-decoration: none; border-radius: 5px; font-weight: bold; }"
                    + "  a.verify-link:hover { background-color: #2980b9; }"
                    + "</style>"
                    + "</head><body>"
                    + "<div class='email-container'>"
                    + "<div class='email-content'>"
                    + "<h2>Chào " + nameUser + "!</h2>"
                    + "<p>Để xác thực tài khoản của bạn, vui lòng nhấp vào nút bên dưới:</p>"
                    + "<p><a href='" + verifyLink + "' class='verify-link'>Xác thực tài khoản</a></p>"
                    + "</div></div>"
                    + "</body></html>";

            // Đặt tiêu đề với UTF-8
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            // Tạo MimeMultipart với subtype "alternative"
            MimeMultipart multipart = new MimeMultipart("alternative");

            // Tạo phần nội dung HTML
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(emailContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlPart);

            // Gán multipart vào message
            message.setContent(multipart);

            // Gửi email
            Transport.send(message);
            System.out.println("Mail đã được gửi thành công tại: " + System.currentTimeMillis());

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static boolean sendMailAsyncOTP(String email, String nameUser, String otp, String createdDate) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.guiMailOTP(email, nameUser, otp, createdDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }

 public static boolean guiMailOTP(String email, String nameUser, String otp, String createdDate) 
            throws UnsupportedEncodingException, AddressException, MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", Gmail.HOST_NAME);
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", Gmail.TSL_PORT);
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Gmail.APP_EMAIL, Gmail.APP_PASSWORD);
            }
        });
        session.setDebug(true);
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Gmail.APP_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            String subject = "Xác thực tài khoản của bạn";

            

            // Nội dung email HTML
            String emailContent = "<!DOCTYPE html>\n" +
                    "<html lang=\"vi\">\n" +
                    "<head>\n" +
                    "    <meta charset=\"UTF-8\">\n" +
                    "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                    "    <title>Mã OTP xác thực</title>\n" +
                    "    <style>\n" +
                    "        body {\n" +
                    "            font-family: Arial, sans-serif;\n" +
                    "            background-color: #f5f5f5;\n" +
                    "            margin: 0;\n" +
                    "            padding: 20px;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .email-container {\n" +
                    "            max-width: 500px;\n" +
                    "            margin: 0 auto;\n" +
                    "            background: white;\n" +
                    "            border-radius: 10px;\n" +
                    "            box-shadow: 0 4px 15px rgba(0,0,0,0.1);\n" +
                    "            overflow: hidden;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .header {\n" +
                    "            background: linear-gradient(135deg, #AE1C9A, #8B156F);\n" +
                    "            color: white;\n" +
                    "            padding: 25px;\n" +
                    "            text-align: center;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .header h1 {\n" +
                    "            margin: 0;\n" +
                    "            font-size: 22px;\n" +
                    "            font-weight: bold;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .header p {\n" +
                    "            margin: 5px 0 0 0;\n" +
                    "            font-size: 14px;\n" +
                    "            opacity: 0.9;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .content {\n" +
                    "            padding: 30px;\n" +
                    "            text-align: center;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .otp-section {\n" +
                    "            background: #f8f9fa;\n" +
                    "            border: 2px dashed #AE1C9A;\n" +
                    "            border-radius: 10px;\n" +
                    "            padding: 25px;\n" +
                    "            margin: 20px 0;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .otp-label {\n" +
                    "            font-size: 16px;\n" +
                    "            color: #333;\n" +
                    "            margin-bottom: 15px;\n" +
                    "            font-weight: bold;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .otp-code {\n" +
                    "            font-size: 32px;\n" +
                    "            font-weight: bold;\n" +
                    "            color: #AE1C9A;\n" +
                    "            letter-spacing: 8px;\n" +
                    "            font-family: 'Courier New', monospace;\n" +
                    "            background: white;\n" +
                    "            padding: 15px 25px;\n" +
                    "            border-radius: 8px;\n" +
                    "            border: 2px solid #AE1C9A;\n" +
                    "            display: inline-block;\n" +
                    "            margin: 10px 0;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .instructions {\n" +
                    "            color: #666;\n" +
                    "            font-size: 15px;\n" +
                    "            line-height: 1.6;\n" +
                    "            margin: 20px 0;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .warning-box {\n" +
                    "            background: #fff3cd;\n" +
                    "            border: 1px solid #ffeaa7;\n" +
                    "            border-radius: 8px;\n" +
                    "            padding: 15px;\n" +
                    "            margin: 20px 0;\n" +
                    "            color: #856404;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .warning-box strong {\n" +
                    "            color: #b8860b;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .expire-info {\n" +
                    "            background: #f5e6f2;\n" +
                    "            border: 1px solid #AE1C9A;\n" +
                    "            border-radius: 8px;\n" +
                    "            padding: 15px;\n" +
                    "            margin: 20px 0;\n" +
                    "            color: #AE1C9A;\n" +
                    "            font-size: 14px;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .footer {\n" +
                    "            background: #f8f9fa;\n" +
                    "            padding: 20px;\n" +
                    "            text-align: center;\n" +
                    "            font-size: 12px;\n" +
                    "            color: #666;\n" +
                    "            border-top: 1px solid #e9ecef;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .footer p {\n" +
                    "            margin: 5px 0;\n" +
                    "        }\n" +
                    "        \n" +
                    "        .security-icon {\n" +
                    "            font-size: 48px;\n" +
                    "            margin-bottom: 15px;\n" +
                    "        }\n" +
                    "    </style>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "    <div class=\"email-container\">\n" +
                    "        <div class=\"header\">\n" +
                    "            <div class=\"security-icon\">🔐</div>\n" +
                    "            <h1>Mã xác thực OTP</h1>\n" +
                    "            <p>Bảo mật tài khoản của bạn</p>\n" +
                    "        </div>\n" +
                    "        \n" +
                    "        <div class=\"content\">\n" +
                    "            <p class=\"instructions\">\n" +
                    "                Xin chào " + nameUser + "! Đây là mã OTP để xác thực tài khoản của bạn:\n" +
                    "            </p>\n" +
                    "            \n" +
                    "            <div class=\"otp-section\">\n" +
                    "                <div class=\"otp-label\">MÃ XÁC THỰC CỦA BẠN</div>\n" +
                    "                <div class=\"otp-code\" id=\"otpCode\">" + otp + "</div>\n" +
                    "            </div>\n" +
                    "            \n" +
                    "            <div class=\"expire-info\">\n" +
                    "                ⏰ <strong>Mã này có hiệu lực trong 3 phút</strong><br>\n" +
                    "                Thời gian tạo: <span id=\"currentTime\">" + createdDate + "</span>\n" +
                    "            </div>\n" +
                    "            \n" +
                    "            <p class=\"instructions\">\n" +
                    "                Vui lòng nhập mã này vào trang xác thực để hoàn tất quá trình đăng nhập.\n" +
                    "            </p>\n" +
                    "            \n" +
                    "            <div class=\"warning-box\">\n" +
                    "                <strong>⚠️ Lưu ý bảo mật:</strong><br>\n" +
                    "                • Không chia sẻ mã này với bất kỳ ai<br>\n" +
                    "                • Mã chỉ sử dụng được một lần<br>\n" +
                    "                • Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "        \n" +
                    "        <div class=\"footer\">\n" +
                    "            <p><strong>Email tự động</strong> - Vui lòng không trả lời</p>\n" +
                    "            <p>© 2025 PenguinShop. Mọi quyền được bảo lưu.</p>\n" +
                    "            <p>Nếu có thắc mắc, liên hệ: support@penguinshop.com</p>\n" +
                    "        </div>\n" +
                    "    </div>\n" +
                    "</body>\n" +
                    "</html>";

            // Đặt tiêu đề với UTF-8
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            // Tạo MimeMultipart với subtype "alternative"
            MimeMultipart multipart = new MimeMultipart("alternative");
            // Tạo phần nội dung HTML
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(emailContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlPart);
            // Gán multipart vào message
            message.setContent(multipart);
            // Gửi email
            Transport.send(message);
            System.out.println("Mail đã được gửi thành công tại: " + System.currentTimeMillis());
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
