/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.UUID;


public class StringConvert {
    public static String combineUserIdAndUUID(String userId) {
        // Tạo UUID ngẫu nhiên
        String uuid = UUID.randomUUID().toString();
        // Ghép chuỗi theo định dạng UserIDxUUID
        return userId + "x" + uuid;
    }
    
    // Hàm tách chuỗi để lấy UserID và UUID
    public static String[] splitUserIdAndUUID(String combinedString) {
        // Kiểm tra chuỗi rỗng hoặc không đúng định dạng
        if (combinedString == null || !combinedString.contains("x")) {
            throw new IllegalArgumentException("Chuỗi không đúng định dạng UserIDxUUID");
        }
        
        // Tách chuỗi tại ký tự 'x'
        String[] parts = combinedString.split("x", 2);
        return parts; // parts[0] là UserID, parts[1] là UUID
    }
}
