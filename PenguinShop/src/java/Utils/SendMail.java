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
import java.util.Properties;

public class SendMail {
    public static boolean guiMail(String email, String noidung, String nameUser) throws UnsupportedEncodingException, AddressException, MessagingException {
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
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

            String subject = "Yêu cầu xác thực";
            String emailContent = "<html><head>"
                    + "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
                    + "<style>"
                    + "  body { font-family: Arial, sans-serif; }"
                    + "  .email-container { width: 100%; padding: 20px; background-color: #f4f4f4; text-align: center; }"
                    + "  .email-content { background-color: #fff; padding: 20px; border-radius: 10px; width: 100%; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); }"
                    + "  h2 { color: #333; }"
                    + "  .otp { font-size: 20px; color: #3498db; font-weight: bold; }"
                    + "</style>"
                    + "</head><body>"
                    + "<div class='email-container'>"
                    + "<div class='email-content'>"
                    + "<h2>Chào " + nameUser + "!</h2>"
                    + "<p>Đây là mã OTP của bạn: <span class='otp'>" + noidung + "</span></p>"
                    + "<p>Vui lòng nhập mã này để xác nhận yêu cầu của bạn.</p>"
                    + "</div></div>"
                    + "</body></html>";

            // Đặt tiêu đề với UTF-8
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            // Tạo MimeMultipart với subtype "alternative" (cho email HTML)
            MimeMultipart multipart = new MimeMultipart("alternative");

            // Tạo phần nội dung HTML
            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(emailContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlPart);

            // Gán multipart vào message
            message.setContent(multipart);

            Transport.send(message);
            System.out.println("Mail đã được gửi thành công tại: " + System.currentTimeMillis());

            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) throws UnsupportedEncodingException, MessagingException {
        guiMail("nguyenluongk2k4@gmail.com", "Test email", "Lương");
    }
}