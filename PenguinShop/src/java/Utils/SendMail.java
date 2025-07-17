 
package Utils;

import APIKey.Gmail;
import Const.Shop;
import Models.CartSession;
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
import java.util.List;
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
            String emailContent = "<!DOCTYPE html>\n"
                    + "<html lang=\"vi\">\n"
                    + "<head>\n"
                    + "    <meta charset=\"UTF-8\">\n"
                    + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "    <title>Mã OTP xác thực</title>\n"
                    + "    <style>\n"
                    + "        body {\n"
                    + "            font-family: Arial, sans-serif;\n"
                    + "            background-color: #f5f5f5;\n"
                    + "            margin: 0;\n"
                    + "            padding: 20px;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .email-container {\n"
                    + "            max-width: 500px;\n"
                    + "            margin: 0 auto;\n"
                    + "            background: white;\n"
                    + "            border-radius: 10px;\n"
                    + "            box-shadow: 0 4px 15px rgba(0,0,0,0.1);\n"
                    + "            overflow: hidden;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .header {\n"
                    + "            background: linear-gradient(135deg, #AE1C9A, #8B156F);\n"
                    + "            color: white;\n"
                    + "            padding: 25px;\n"
                    + "            text-align: center;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .header h1 {\n"
                    + "            margin: 0;\n"
                    + "            font-size: 22px;\n"
                    + "            font-weight: bold;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .header p {\n"
                    + "            margin: 5px 0 0 0;\n"
                    + "            font-size: 14px;\n"
                    + "            opacity: 0.9;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .content {\n"
                    + "            padding: 30px;\n"
                    + "            text-align: center;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .otp-section {\n"
                    + "            background: #f8f9fa;\n"
                    + "            border: 2px dashed #AE1C9A;\n"
                    + "            border-radius: 10px;\n"
                    + "            padding: 25px;\n"
                    + "            margin: 20px 0;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .otp-label {\n"
                    + "            font-size: 16px;\n"
                    + "            color: #333;\n"
                    + "            margin-bottom: 15px;\n"
                    + "            font-weight: bold;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .otp-code {\n"
                    + "            font-size: 32px;\n"
                    + "            font-weight: bold;\n"
                    + "            color: #AE1C9A;\n"
                    + "            letter-spacing: 8px;\n"
                    + "            font-family: 'Courier New', monospace;\n"
                    + "            background: white;\n"
                    + "            padding: 15px 25px;\n"
                    + "            border-radius: 8px;\n"
                    + "            border: 2px solid #AE1C9A;\n"
                    + "            display: inline-block;\n"
                    + "            margin: 10px 0;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .instructions {\n"
                    + "            color: #666;\n"
                    + "            font-size: 15px;\n"
                    + "            line-height: 1.6;\n"
                    + "            margin: 20px 0;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .warning-box {\n"
                    + "            background: #fff3cd;\n"
                    + "            border: 1px solid #ffeaa7;\n"
                    + "            border-radius: 8px;\n"
                    + "            padding: 15px;\n"
                    + "            margin: 20px 0;\n"
                    + "            color: #856404;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .warning-box strong {\n"
                    + "            color: #b8860b;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .expire-info {\n"
                    + "            background: #f5e6f2;\n"
                    + "            border: 1px solid #AE1C9A;\n"
                    + "            border-radius: 8px;\n"
                    + "            padding: 15px;\n"
                    + "            margin: 20px 0;\n"
                    + "            color: #AE1C9A;\n"
                    + "            font-size: 14px;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .footer {\n"
                    + "            background: #f8f9fa;\n"
                    + "            padding: 20px;\n"
                    + "            text-align: center;\n"
                    + "            font-size: 12px;\n"
                    + "            color: #666;\n"
                    + "            border-top: 1px solid #e9ecef;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .footer p {\n"
                    + "            margin: 5px 0;\n"
                    + "        }\n"
                    + "        \n"
                    + "        .security-icon {\n"
                    + "            font-size: 48px;\n"
                    + "            margin-bottom: 15px;\n"
                    + "        }\n"
                    + "    </style>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "    <div class=\"email-container\">\n"
                    + "        <div class=\"header\">\n"
                    + "            <div class=\"security-icon\">🔐</div>\n"
                    + "            <h1>Mã xác thực OTP</h1>\n"
                    + "            <p>Bảo mật tài khoản của bạn</p>\n"
                    + "        </div>\n"
                    + "        \n"
                    + "        <div class=\"content\">\n"
                    + "            <p class=\"instructions\">\n"
                    + "                Xin chào " + nameUser + "! Đây là mã OTP để xác thực tài khoản của bạn:\n"
                    + "            </p>\n"
                    + "            \n"
                    + "            <div class=\"otp-section\">\n"
                    + "                <div class=\"otp-label\">MÃ XÁC THỰC CỦA BẠN</div>\n"
                    + "                <div class=\"otp-code\" id=\"otpCode\">" + otp + "</div>\n"
                    + "            </div>\n"
                    + "            \n"
                    + "            <div class=\"expire-info\">\n"
                    + "                ⏰ <strong>Mã này có hiệu lực trong 3 phút</strong><br>\n"
                    + "                Thời gian tạo: <span id=\"currentTime\">" + createdDate + "</span>\n"
                    + "            </div>\n"
                    + "            \n"
                    + "            <p class=\"instructions\">\n"
                    + "                Vui lòng nhập mã này vào trang xác thực để hoàn tất quá trình đăng nhập.\n"
                    + "            </p>\n"
                    + "            \n"
                    + "            <div class=\"warning-box\">\n"
                    + "                <strong>⚠️ Lưu ý bảo mật:</strong><br>\n"
                    + "                • Không chia sẻ mã này với bất kỳ ai<br>\n"
                    + "                • Mã chỉ sử dụng được một lần<br>\n"
                    + "                • Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email\n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "        \n"
                    + "        <div class=\"footer\">\n"
                    + "            <p><strong>Email tự động</strong> - Vui lòng không trả lời</p>\n"
                    + "            <p>© 2025 PenguinShop. Mọi quyền được bảo lưu.</p>\n"
                    + "            <p>Nếu có thắc mắc, liên hệ: support@penguinshop.com</p>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";

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
    
    public static boolean sendMailAsyncCamOn(String email, String nameUser) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.guiMailCamOn(email, nameUser);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }
    public static boolean guiMailCamOn(String email, String nameUser) throws UnsupportedEncodingException, AddressException, MessagingException {
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

            String subject = "Cảm ơn bạn đã báo cáo lỗi - PenguinShop";

            // Nội dung email cảm ơn
            String emailContent = "<html><head>"
                    + "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
                    + "<style>"
                    + "  body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; }"
                    + "  .email-container { width: 100%; padding: 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }"
                    + "  .email-content { background-color: #fff; padding: 40px 30px; border-radius: 15px; max-width: 600px; margin: 0 auto; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); }"
                    + "  .header { text-align: center; margin-bottom: 30px; }"
                    + "  .logo { font-size: 28px; font-weight: bold; color: #667eea; margin-bottom: 10px; }"
                    + "  h2 { color: #333; text-align: center; margin-bottom: 25px; font-size: 24px; }"
                    + "  .content { line-height: 1.8; color: #555; font-size: 16px; }"
                    + "  .highlight { background-color: #f8f9ff; padding: 20px; border-left: 4px solid #667eea; margin: 20px 0; border-radius: 5px; }"
                    + "  .thank-you-box { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; border-radius: 10px; text-align: center; margin: 25px 0; }"
                    + "  .thank-you-box h3 { margin: 0 0 10px 0; font-size: 20px; }"
                    + "  .footer { text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; color: #777; font-size: 14px; }"
                    + "  .contact-info { background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 20px; }"
                    + "</style>"
                    + "</head><body>"
                    + "<div class='email-container'>"
                    + "<div class='email-content'>"
                    + "<div class='header'>"
                    + "<div class='logo'>🐧 PenguinShop</div>"
                    + "</div>"
                    + "<h2>Xin chào " + nameUser + "!</h2>"
                    + "<div class='thank-you-box'>"
                    + "<h3>🙏 Cảm ơn bạn rất nhiều!</h3>"
                    + "<p>Chúng tôi đã nhận được báo cáo lỗi từ bạn</p>"
                    + "</div>"
                    + "<div class='content'>"
                    + "<p>Chúng tôi rất trân trọng việc bạn đã dành thời gian để báo cáo lỗi và góp ý cải thiện trải nghiệm mua sắm tại PenguinShop.</p>"
                    + "<div class='highlight'>"
                    + "<p><strong>📝 Thông tin báo cáo của bạn đã được ghi nhận:</strong></p>"
                    + "<p>• Thời gian: " + new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) + "</p>"
                    + "<p>• Email liên hệ: " + email + "</p>"
                    + "<p>• Trạng thái: Đang được xử lý</p>"
                    + "</div>"
                    + "<p>Đội ngũ kỹ thuật của chúng tôi sẽ xem xét và khắc phục vấn đề trong thời gian sớm nhất. Nếu cần thêm thông tin, chúng tôi sẽ liên hệ lại với bạn qua email này.</p>"
                    + "<p>Một lần nữa, cảm ơn bạn đã giúp PenguinShop ngày càng hoàn thiện hơn! 🎉</p>"
                    + "</div>"
                    + "<div class='contact-info'>"
                    + "<h4 style='margin-top: 0; color: #333;'>📞 Thông tin liên hệ</h4>"
                    + "<p style='margin: 5px 0;'>Email hỗ trợ: support@penguinshop.com</p>"
                    + "<p style='margin: 5px 0;'>Hotline: 1900-1234</p>"
                    + "<p style='margin: 5px 0;'>Thời gian hỗ trợ: 8:00 - 22:00 (tất cả các ngày)</p>"
                    + "</div>"
                    + "<div class='footer'>"
                    + "<p>Trân trọng,<br><strong>Đội ngũ PenguinShop</strong></p>"
                    + "<p style='font-size: 12px; margin-top: 15px;'>Email này được gửi tự động. Vui lòng không trả lời trực tiếp email này.</p>"
                    + "</div>"
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
            System.out.println("Mail cảm ơn đã được gửi thành công tại: " + System.currentTimeMillis());
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean sendMailAsyncCamOn2(String email, String nameUser, String htmlContent) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.guiMailCamOn2(email, nameUser,htmlContent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }
    
    public static boolean guiMailCamOn2(String email, String nameUser, String htmlContent) throws UnsupportedEncodingException, AddressException, MessagingException {
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

        String subject = "Cảm ơn bạn đã báo cáo lỗi - PenguinShop";

        // Sử dụng HTML content từ CKEditor
        String emailContent = htmlContent;
        
        // Nếu cần thêm thông tin động vào content
        if (emailContent.contains("{{nameUser}}")) {
            emailContent = emailContent.replace("{{nameUser}}", nameUser);
        }
        if (emailContent.contains("{{email}}")) {
            emailContent = emailContent.replace("{{email}}", email);
        }
        if (emailContent.contains("{{currentTime}}")) {
            emailContent = emailContent.replace("{{currentTime}}", 
                new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()));
        }

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
        System.out.println("Mail cảm ơn đã được gửi thành công tại: " + System.currentTimeMillis());
        return true;
    } catch (MessagingException e) {
        e.printStackTrace();
        return false;
    }
}
    
    public static boolean sendMailAsyncCartConfirm(String email, String nameUser, String otp, List<CartSession> products,double shippingFee, double totalAmount) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.sendCartConfirm(email, nameUser, otp, products, shippingFee, totalAmount);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }
    
    
    public static boolean sendCartConfirm(String email, String nameUser, String otp, List<CartSession> products, double shippingFee, double totalAmount)
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

        String subject = "Xác thực đơn hàng thời trang - Penguin Shop";

        StringBuilder productHtml = new StringBuilder();
        double subtotal = 0;

        for (CartSession product : products) {
            double productTotal = product.getTotalAmount(); // quantity × price
            subtotal += productTotal;

            String imageFileName = product.getCart().getVariant().getProduct().getImageMainProduct();
            String imageUrl = (imageFileName != null && !imageFileName.isEmpty())
                    ? Shop.LINK_IMAGE + imageFileName
                    : "https://via.placeholder.com/70x70/AE1C9A/ffffff?text=👔";

            productHtml.append(String.format(
                "<div class='product-item'>" +
                "<img src='%s' alt='%s' class='product-image'>" +
                "<div class='product-details'>" +
                "<div class='product-name'>%s</div>" +
                "<div class='product-size'>Size: %s | Màu: %s</div>" +
                "<div class='product-quantity'>Số lượng: %d</div>" +
                "<div class='product-price'>%,.0f VNĐ</div>" +
                "</div></div>",
                imageUrl, product.getCart().getVariant().getProduct().getProductName(),
                product.getCart().getVariant().getProduct().getProductName(),
                product.getCart().getVariant().getSize().getSizeName(),
                product.getCart().getVariant().getColor().getColorName(),
                product.getQuantity(), productTotal
            ));
        }

        String emailContent = String.format("""
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f9f4f9; margin: 0; padding: 0; }
        .email-container { max-width: 650px; margin: auto; background: #fff; border: 2px solid #AE1C9A; border-radius: 12px; overflow: hidden; }
        .header { background: linear-gradient(135deg, #AE1C9A, #d946ef); color: white; padding: 30px 20px; text-align: center; }
        .content { padding: 30px; }
        .otp-section, .total-section { background: linear-gradient(135deg, #AE1C9A, #e879f9); color: white; padding: 25px; border-radius: 12px; text-align: center; margin: 25px 0; }
        .otp-code { font-size: 36px; font-weight: bold; letter-spacing: 8px; background: rgba(255,255,255,0.1); padding: 10px 20px; border-radius: 8px; }
        .products-title { font-size: 22px; color: #AE1C9A; border-bottom: 3px solid #AE1C9A; padding-bottom: 10px; margin-bottom: 20px; }
        .product-item { display: flex; background: #fce7f3; padding: 18px; border-radius: 12px; margin-bottom: 15px; border-left: 5px solid #AE1C9A; }
        .product-image { width: 70px; height: 70px; object-fit: cover; border-radius: 12px; margin-right: 20px; border: 3px solid #AE1C9A; }
        .product-name { color: #AE1C9A; font-weight: bold; font-size: 18px; }
        .product-quantity, .product-size { font-size: 14px; margin-top: 5px; }
        .product-price { font-size: 16px; color: #dc2626; font-weight: bold; }
        .footer { background: #fce7f3; padding: 25px; text-align: center; color: #AE1C9A; font-size: 14px; border-top: 2px solid #AE1C9A; }
    </style>
</head>
<body>
    <div class="email-container">
        <div class="header">
            <h1>🐧 PENGUIN SHOP</h1>
            <p>Thời trang chất lượng - Phong cách đẳng cấp</p>
        </div>
        <div class="content">
            <p>Chào <strong>%s</strong>,</p>
            <p>Cảm ơn bạn đã mua sắm tại <strong>Penguin Shop</strong>. Vui lòng nhập mã OTP sau để xác thực đơn hàng:</p>
            <div class="otp-section">
                <div style="font-size: 18px;">🔐 Mã OTP:</div>
                <div class="otp-code">%s</div>
                <div style="font-size: 14px;">⏰ Có hiệu lực trong 10 phút</div>
            </div>
            <div class="products-section">
                <div class="products-title">🛍️ Chi tiết đơn hàng</div>
                %s
                <div class="total-section">
                    <div style="font-size: 18px;">💵 Tổng phụ (chưa gồm ship):</div>
                    <div class="total-amount">%,.0f VNĐ</div>
                    <div style="margin-top: 10px;">🚚 Phí ship: <strong>%,.0f VNĐ</strong></div>
                    <hr style="margin: 20px 0;">
                    <div style="font-size: 18px;">💰 Tổng tiền đơn hàng:</div>
                    <div class="total-amount">%,.0f VNĐ</div>
                </div>
            </div>
            <p style="background: #fff7ed; border: 1px solid #fb923c; color: #9a3412; padding: 15px; border-radius: 10px;">
                ⚠️ Không chia sẻ mã OTP này với bất kỳ ai. Penguin Shop không bao giờ yêu cầu mã OTP qua điện thoại.
            </p>
        </div>
        <div class="footer">
            <p><strong>PENGUIN SHOP</strong> - Thời trang đẳng cấp cho bạn</p>
            <p>📧 support@penguinshop.com | ☎️ 0123456789</p>
            <p>🏪 Đại học FPT, Km29, Láng Hòa Lạc</p>
        </div>
    </div>
</body>
</html>
""", nameUser, otp, productHtml.toString(), subtotal, shippingFee, totalAmount);

        message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

        MimeMultipart multipart = new MimeMultipart("alternative");
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(emailContent, "text/html; charset=UTF-8");
        multipart.addBodyPart(htmlPart);

        message.setContent(multipart);
        Transport.send(message);

        System.out.println("Email xác thực đơn hàng Penguin Shop đã được gửi thành công tại: " + System.currentTimeMillis());
        return true;

    } catch (MessagingException e) {
        e.printStackTrace();
        return false;
    }
}
    
    public static boolean sendMailReplyFeedbackAsync(String email, String nameUser, String replyContent) {
        Thread thread = new Thread(() -> {
            try {
                SendMail.sendMailReplyFeedback(email, nameUser, replyContent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        thread.start();

        return true;
    }
   // Gửi mail phản hồi feedback cho người mua
    public static boolean sendMailReplyFeedback(String email, String nameUser, String replyContent) {
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
            message.setFrom(new InternetAddress(Gmail.APP_EMAIL, "PenguinShop"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            String subject = "Phản hồi từ PenguinShop về đánh giá của bạn";
            String emailContent = "<html><head>"
                    + "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
                    + "<style>body{font-family:Arial,sans-serif;}"
                    + ".container{background:#f8f9fa;padding:20px;border-radius:10px;max-width:600px;margin:0 auto;}"
                    + ".header{font-size:20px;font-weight:bold;color:#333;margin-bottom:10px;}"
                    + ".content{font-size:16px;color:#444;margin-bottom:20px;}"
                    + ".footer{font-size:13px;color:#888;margin-top:30px;text-align:center;}</style>"
                    + "</head><body>"
                    + "<div class='container'>"
                    + "<div class='header'>Phản hồi từ PenguinShop</div>"
                    + "<div class='content'>"
                    + "Xin chào <b>" + (nameUser != null ? nameUser : "bạn") + "</b>,<br><br>"
                    + "Chúng tôi đã nhận được đánh giá/feedback của bạn. Dưới đây là phản hồi từ shop:<br><br>"
                    + "<div style='background:#fffbe6;border-left:4px solid #ffc107;padding:15px 20px;border-radius:6px;margin-bottom:15px;'><i>"
                    + replyContent + "</i></div>"
                    + "Nếu bạn có thêm câu hỏi hoặc cần hỗ trợ, hãy liên hệ với chúng tôi qua email này.<br><br>"
                    + "Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của PenguinShop!"
                    + "</div>"
                    + "<div class='footer'>Đây là email tự động, vui lòng không trả lời lại email này.<br>© 2025 PenguinShop</div>"
                    + "</div></body></html>";
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            MimeMultipart multipart = new MimeMultipart("alternative");
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(emailContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlPart);
            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Mail phản hồi feedback đã gửi thành công: " + System.currentTimeMillis());
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
