/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.util.ArrayList;
import java.util.List;
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

    public static int[] convertToIntArray(String[] arr) {
        if (arr == null || arr.length == 0) {
            return null;
        }
        List<Integer> validIntegers = new ArrayList<>();
        for (String value : arr) {
            if (value != null && !value.trim().isEmpty()) {
                try {
                    validIntegers.add(Integer.parseInt(value.trim()));
                } catch (NumberFormatException e) {
                    // Bỏ qua giá trị không hợp lệ
                }
            }
        }
        if (validIntegers.isEmpty()) {
            return null;
        }
        int[] result = new int[validIntegers.size()];
        for (int i = 0; i < validIntegers.size(); i++) {
            result[i] = validIntegers.get(i);
        }
        return result;
    }
}
