/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.Date;

public class GetDateTime {

    public static String getCurrentTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }

    // Hàm so sánh thời gian thực với thời gian truyền vào
    // Trả true nếu <= 3 phút, false nếu > 3 phút
    public static boolean isWithinThreeMinutes(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.isEmpty()) {
            return false;
        }

        try {
            // Sử dụng SimpleDateFormat để parse chuỗi thời gian với millisecond linh hoạt
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
            sdf.setLenient(false); // Không cho phép định dạng không hợp lệ
            Date date = sdf.parse(dateTimeStr);

            // Chuyển Date thành LocalDateTime
            LocalDateTime inputTime = new java.sql.Timestamp(date.getTime()).toLocalDateTime();
            LocalDateTime now = LocalDateTime.now();

            long minutesDiff = ChronoUnit.MINUTES.between(inputTime, now);
            return minutesDiff <= 3;
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Trả về false nếu parse thất bại
        }
    }
    public static void main(String[] args) {
        System.out.println(GetDateTime.getCurrentTime());
    }

}
