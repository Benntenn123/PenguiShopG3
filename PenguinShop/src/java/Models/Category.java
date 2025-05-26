/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;


public class Category {
    private int categoryId;
    private String categoryName;
    private String sportType;
    private String imageCategory;

    public Category(int categoryId, String categoryName, String sportType, String imageCategory) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.sportType = sportType;
        this.imageCategory = imageCategory;
    }

    public Category(int categoryId, String categoryName) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }
    

    public Category(int categoryId, String categoryName, String sportType) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.sportType = sportType;
    }

    public Category() {
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getSportType() {
        return sportType;
    }

    public void setSportType(String sportType) {
        this.sportType = sportType;
    }

    public String getImageCategory() {
        return imageCategory;
    }

    public void setImageCategory(String imageCategory) {
        this.imageCategory = imageCategory;
    }
    
    
}
