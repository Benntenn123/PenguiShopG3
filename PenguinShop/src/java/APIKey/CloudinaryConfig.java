package APIKey;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.InputStream;
import java.util.Map;

public class CloudinaryConfig {
    public static Cloudinary cloudinary;
    
    static {
        try {
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dcdwqd5up", // Thay bằng cloud_name của bạn
                "api_key", "951237837454779", // Thay bằng API key
                "api_secret", "0JBYs-JYq07sAWbTu-FRbXSP8vM", // Thay bằng API secret
                "secure", true
        ));
            
            System.out.println("Cloudinary initialized successfully");
        } catch (Exception e) {
            System.out.println("Error initializing Cloudinary: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public static Cloudinary getCloudinary() {
        return cloudinary;
    }
    
    public String uploadImage(InputStream imageStream, String fileName) {
        try {
            System.out.println("=== CLOUDINARY UPLOAD DEBUG ===");
            System.out.println("Starting upload for file: " + fileName);
            
            if (cloudinary == null) {
                System.out.println("ERROR: Cloudinary is not initialized!");
                return null;
            }
            
            if (imageStream == null) {
                System.out.println("ERROR: InputStream is null!");
                return null;
            }
            
            byte[] imageBytes = imageStream.readAllBytes();
            System.out.println("Image bytes length: " + imageBytes.length);
            
            // Tạo public_id KHÔNG có extension
            String cleanFileName = fileName.replaceAll("[^a-zA-Z0-9._-]", "_");
            if (cleanFileName.contains(".")) {
                cleanFileName = cleanFileName.substring(0, cleanFileName.lastIndexOf("."));
            }
            String publicId = System.currentTimeMillis() + "_" + cleanFileName;
            
            System.out.println("Public ID will be: " + publicId);
            
            // Upload - Để Cloudinary TỰ ĐỘNG detect format từ binary data
            Map uploadResult = cloudinary.uploader().upload(imageBytes, ObjectUtils.asMap(
                "resource_type", "image",
                "public_id", publicId,
                "overwrite", true
                // KHÔNG chỉ định format - để Cloudinary tự detect
            ));
            
            System.out.println("Upload result: " + uploadResult);
            
            String resultPublicId = (String) uploadResult.get("public_id");
            String actualFormat = (String) uploadResult.get("format");
            String secureUrl = (String) uploadResult.get("secure_url");
            
            System.out.println("Result Public ID: " + resultPublicId);
            System.out.println("Actual format detected by Cloudinary: " + actualFormat);
            System.out.println("Secure URL: " + secureUrl);
            
            // Return public_id kèm format thực tế mà Cloudinary detect được
            return resultPublicId + "." + actualFormat;
        } catch (Exception e) {
            System.out.println("ERROR in uploadImage: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Hàm này để lấy URL ảnh từ public_id
    public String getImageUrl(String publicId) {
        try {
            if (publicId == null || publicId.trim().isEmpty()) {
                System.out.println("Public ID is null or empty");
                return null;
            }
            
            // Nếu public_id đã có format (như: "123_image.jpg")
            if (publicId.contains(".")) {
                String url = cloudinary.url()
                    .secure(true)
                    .generate(publicId);
                
                System.out.println("Generated URL for " + publicId + ": " + url);
                return url;
            } else {
                // Nếu không có format, để Cloudinary tự generate
                String url = cloudinary.url()
                    .secure(true)
                    .generate(publicId);
                
                System.out.println("Generated URL for " + publicId + ": " + url);
                return url;
            }
        } catch (Exception e) {
            System.out.println("Error generating URL: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    // Hàm để generate URL với format cụ thể (nếu cần transform)
    public String getImageUrlWithFormat(String publicId, String format) {
        try {
            if (publicId == null || publicId.trim().isEmpty()) {
                return null;
            }
            
            // Clean public_id (remove extension if exists)
            String cleanPublicId = publicId;
            if (publicId.contains(".")) {
                cleanPublicId = publicId.substring(0, publicId.lastIndexOf("."));
            }
            
            String url = cloudinary.url()
                .secure(true)
                .format(format)
                .generate(cleanPublicId);
            
            System.out.println("Generated URL with format " + format + " for " + cleanPublicId + ": " + url);
            return url;
        } catch (Exception e) {
            System.out.println("Error generating URL: " + e.getMessage());
            return null;
        }
    }
    
    // Test connection
    
}