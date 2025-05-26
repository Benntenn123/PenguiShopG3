/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;


public class Brand {
    private int brandID;
    private String brandName;
    private String logo;
    private String description;

    public Brand(int brandID, String brandName, String logo) {
        this.brandID = brandID;
        this.brandName = brandName;
        this.logo = logo;
    }

    public Brand(int brandID, String brandName, String logo, String description) {
        this.brandID = brandID;
        this.brandName = brandName;
        this.logo = logo;
        this.description = description;
    }

    public Brand() {
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
