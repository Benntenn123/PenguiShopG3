

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Bo;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class ImageServices {
    public static String saveImageToLocal(byte[] imageData, String fileName, String baseUrl) throws IOException {
        
        String currentDir = new File("").getAbsolutePath();
        String directoryPath = currentDir + File.separator + "Images";
        File directory = new File(directoryPath);  
        if (!directory.exists()) {
            directory.mkdirs();
        }        
        File file = new File(directory, fileName);        
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(imageData);
        }       
        return baseUrl + "/Images/" + file.getName();
    }
}
