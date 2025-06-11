package Utils;

import Utils.StringConvert;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.json.JSONArray;
import org.json.JSONObject;

public class DistanceCalculator {

    private static final double EARTH_RADIUS = 6371; // km
    private static final String NOMINATIM_URL = "https://nominatim.openstreetmap.org/search";

    // Lấy tọa độ từ địa chỉ (Nominatim)
    public static double[] getCoordinates(String address) throws Exception {
        String standardizedAddress = StringConvert.standardizeAddress(address);
        String urlString = NOMINATIM_URL + "?q=" + URLEncoder.encode(standardizedAddress, "UTF-8")
                + "&format=json&limit=1";

        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("User-Agent", "PenguinShop/1.0 (peguing6@gmail.com)");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = in.readLine()) != null) {
            response.append(line);
        }
        in.close();

        System.out.println("Response from Nominatim: " + response.toString()); // Log phản hồi

        JSONArray json = new JSONArray(response.toString());
        if (json.length() == 0) {
            throw new Exception("Không tìm thấy tọa độ cho địa chỉ: " + address);
        }

        JSONObject result = json.getJSONObject(0);
        double lat = result.getDouble("lat");
        double lon = result.getDouble("lon");
        return new double[]{lat, lon};
    }

    // Tính khoảng cách Haversine
    public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        lat1 = Math.toRadians(lat1);
        lon1 = Math.toRadians(lon1);
        lat2 = Math.toRadians(lat2);
        lon2 = Math.toRadians(lon2);

        double dLat = lat2 - lat1;
        double dLon = lon2 - lon1;
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(lat1) * Math.cos(lat2)
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.asin(Math.sqrt(a));
        return EARTH_RADIUS * c;
    }

    // Tính khoảng cách từ hai địa chỉ
    public static double getDistance(String origin, String destination) throws Exception {
        double[] originCoords = getCoordinates(origin);
        double[] destCoords = getCoordinates(destination);
        return calculateDistance(originCoords[0], originCoords[1], destCoords[0], destCoords[1]);
    }

    // Hàm tính phí Ship
    public static double calculateShippingFee(double distance) {
        if (distance < 15) {
            return 20000; // Nội thành
        }
        if (distance < 50) {
            return 40000; // Ngoại thành
        }
        return 80000; // Liên tỉnh
    }
     public static String calculateDeliveryTime(double distance) {  
        if (distance < 15) {
            return "Thời gian nhận hàng: 1-2 ngày";
        } else if (distance < 50) {
            return "Thời gian nhận hàng: 2-3 ngày";
        } else {
            return "Thời gian nhận hàng: 3-5 ngày hoặc hơn";
        }
    }
}
