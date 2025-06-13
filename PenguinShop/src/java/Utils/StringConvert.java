/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
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

    public static String maskPhoneNumber(String phone) {
        if (phone == null || phone.length() < 7) {
            return phone; // Không đủ dài để ẩn
        }
        int length = phone.length();
        String start = phone.substring(0, 3);
        String end = phone.substring(length - 3);
        String maskedMiddle = "*".repeat(length - 6);
        return start + maskedMiddle + end;
    }

    // Ẩn email, ví dụ: user@example.com -> u***@example.com
    public static String maskEmail(String email) {
        if (email == null || !email.contains("@")) {
            return email;
        }
        String[] parts = email.split("@", 2);
        String name = parts[0];
        String domain = parts[1];
        if (name.length() <= 1) {
            return "*" + "@" + domain;
        }
        String start = name.substring(0, 1);
        String maskedMiddle = "*".repeat(Math.max(0, name.length() - 1));
        return start + maskedMiddle + "@" + domain;
    }

    public static String generateRandom6DigitNumber() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10)); // Tạo số ngẫu nhiên từ 0-9
        }
        return sb.toString();
    }

    public static String generateRandomString() {
        String upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCase = "abcdefghijklmnopqrstuvwxyz";
        String digits = "0123456789";
        String specialChars = "!@#$%^&*()_+-=[]{}|;:,.<>?";

        SecureRandom random = new SecureRandom();

        // Bắt buộc mỗi loại có ít nhất 1
        List<Character> password = new ArrayList<>();
        password.add(upperCase.charAt(random.nextInt(upperCase.length())));
        password.add(digits.charAt(random.nextInt(digits.length())));
        password.add(specialChars.charAt(random.nextInt(specialChars.length())));

        // Các ký tự còn lại là chữ thường hoặc ngẫu nhiên trong 3 nhóm
        String allChars = lowerCase + upperCase + digits + specialChars;
        for (int i = 0; i < 5; i++) {
            password.add(allChars.charAt(random.nextInt(lowerCase.length())));
        }

        // Trộn ngẫu nhiên để tránh cố định thứ tự
        Collections.shuffle(password, random);

        // Chuyển về String
        StringBuilder sb = new StringBuilder();
        for (char c : password) {
            sb.append(c);
        }

        return sb.toString();
    }

    public static boolean isAnyFieldEmpty(String... fields) {
        for (String field : fields) {
            if (field == null || field.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }

    public static boolean isEmpty(String field) {
        if (field == null || field.trim().isEmpty()) {
            return true;
        }
        return false;
    }

    public static String cleanString(String input) {
        if (input == null) {
            return "";
        }
        // Loại bỏ ký tự đặc biệt, giữ lại chữ cái, số và ký tự tiếng Việt
        String cleaned = input.replaceAll("[^\\p{L}\\p{N}\\s]", "");
        // Chuẩn hóa khoảng trắng: thay nhiều khoảng trắng bằng một và loại bỏ khoảng trắng đầu/cuối
        cleaned = cleaned.replaceAll("\\s+", " ").trim();
        return cleaned;
    }

    public static String standardizeAddress(String rawAddress) {
        if (rawAddress == null || rawAddress.trim().isEmpty()) {
            return "";
        }

        // Tách dựa trên dấu "-"
        String[] parts = rawAddress.split("\\s*-\\s*");
        // Lọc phần tử rỗng và ghép lại
        StringBuilder standardized = new StringBuilder();
        for (String part : parts) {
            part = part.trim();
            if (!part.isEmpty()) {
                if (standardized.length() > 0) {
                    standardized.append(", ");
                }
                standardized.append(part);
            }
        }
        return standardized.toString();
    }

}
