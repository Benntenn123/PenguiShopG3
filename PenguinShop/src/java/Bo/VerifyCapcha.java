/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Bo;

import APIKey.Capcha;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import org.json.JSONObject;

public class VerifyCapcha {
    public static boolean verifyRecaptcha(String recaptchaResponse) {
        try {

            String url = "https://www.google.com/recaptcha/api/siteverify";
            String postData = "secret=" + URLEncoder.encode(Capcha.SECRETKEY, "UTF-8")
                    + "&response=" + URLEncoder.encode(recaptchaResponse, "UTF-8");

            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            con.setRequestMethod("POST");
            con.setDoOutput(true);
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("Content-Length", String.valueOf(postData.length()));

            OutputStream os = con.getOutputStream();
            os.write(postData.getBytes());
            os.flush();
            os.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder responseText = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                responseText.append(inputLine);
            }
            in.close();

            JSONObject jsonObject = new JSONObject(responseText.toString());
            return jsonObject.getBoolean("success");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
