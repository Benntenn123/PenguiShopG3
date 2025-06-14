/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;


public class Product {
    private int productId;
    private String productName;
    private String sku;
    private Type type;
    private Category category;
    private String importDate;
    private String imageMainProduct;
    private String description;
    private double weight;
    private String full_description;
    private Brand brand;

    public Product(int productId, String productName, String sku, Type type, Category category, String importDate, String imageMainProduct, String description, double weight, String full_description, Brand brand) {
        this.productId = productId;
        this.productName = productName;
        this.sku = sku;
        this.type = type;
        this.category = category;
        this.importDate = importDate;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
        this.weight = weight;
        this.full_description = full_description;
        this.brand = brand;
    }
    
    public Product(int productId) {
        this.productId = productId;
    }

    public Product(int productId, String productName, Type type, String imageMainProduct, String description, String full_description, Brand brand) {
        this.productId = productId;
        this.productName = productName;
        this.type = type;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
        this.full_description = full_description;
        this.brand = brand;
    }

    public Product(int productId, String productName, String sku, Type type, Category category, String importDate, String imageMainProduct, String description, double weight, String full_description) {
        this.productId = productId;
        this.productName = productName;
        this.sku = sku;
        this.type = type;
        this.category = category;
        this.importDate = importDate;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
        this.weight = weight;
        this.full_description = full_description;
    }

    public Product() {
    }

    public Product(int productId, String productName, String imageMainProduct, String description, String sku, String full_description) {
        this.productId = productId;
        this.productName = productName;
        this.sku = sku;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
        this.full_description = full_description;
    }

    public Product(int productId, String productName, String imageMainProduct, String description) {
        this.productId = productId;
        this.productName = productName;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
    }

    public Product(int productId, String productName, String imageMainProduct, String description,String sku) {
        this.productId = productId;
        this.productName = productName;
        this.sku = sku;
        this.imageMainProduct = imageMainProduct;
        this.description = description;
    }

    public Product(int productId, String productName, String sku, Type type, Category category, String importDate, String description, double weight) {
        this.productId = productId;
        this.productName = productName;
        this.sku = sku;
        this.type = type;
        this.category = category;
        this.importDate = importDate;
        this.description = description;
        this.weight = weight;
    }

    public Product(int productId, String productName, String imageMainProduct) {
        this.productId = productId;
        this.productName = productName;
        this.imageMainProduct = imageMainProduct;
    }

    public Product(String productName, String imageMainProduct) {
        this.productName = productName;
        this.imageMainProduct = imageMainProduct;
    }

    public Product(String productName, String sku, Type type, Category category, String importDate, String description, double weight) {
        this.productName = productName;
        this.sku = sku;
        this.type = type;
        this.category = category;
        this.importDate = importDate;
        this.description = description;
        this.weight = weight;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getFull_description() {
        return full_description;
    }

    public void setFull_description(String full_description) {
        this.full_description = full_description;
    }

    public String getProductName() {
        return productName;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getImageMainProduct() {
        return imageMainProduct;
    }

    public void setImageMainProduct(String imageMainProduct) {
        this.imageMainProduct = imageMainProduct;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getImportDate() {
        return importDate;
    }

    public void setImportDate(String importDate) {
        this.importDate = importDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", sku=" + sku + ", type=" + type + ", category=" + category + ", importDate=" + importDate + ", imageMainProduct=" + imageMainProduct + ", description=" + description + ", weight=" + weight + ", full_description=" + full_description + '}';
    }
    
    
    
}
