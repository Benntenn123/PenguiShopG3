/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;


public class GetDateTime {
    public static String getCurrentTime() {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }

    // Hàm so sánh thời gian thực với thời gian truyền vào
    // Trả true nếu <= 3 phút, false nếu > 3 phút
    public static boolean isWithinThreeMinutes(LocalDateTime inputTime) {
        if (inputTime == null) {
            return false; 
        }

        LocalDateTime now = LocalDateTime.now();
        long minutesDiff = ChronoUnit.MINUTES.between(inputTime, now);
        return minutesDiff <= 3;
    }
}
