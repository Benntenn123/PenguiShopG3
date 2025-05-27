/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package APIKey;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;


public class CloudinaryConfig {
    private static Cloudinary cloudinary;

    static {
        cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dcdwqd5up", // Thay bằng cloud_name của bạn
            "api_key", "715755382767874",       // Thay bằng API key
            "api_secret", "lfNSLX0KnRLluTmMJmNHVzjJuzA", // Thay bằng API secret
            "secure", true
        ));
    }

    public static Cloudinary getCloudinary() {
        return cloudinary;
    }
}
