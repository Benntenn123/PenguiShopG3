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
}
