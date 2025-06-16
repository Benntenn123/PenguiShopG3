/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class ProductVariant {
    private int variantID, quantity; 
    private Product product;
    private Color color;
    private Size size;
    private double price;
    private String stockStatus;
    private int StockSta;

    public int getStockSta() {
        return StockSta;
    }

    public void setStockSta(int StockSta) {
        this.StockSta = StockSta;
    }

    public ProductVariant(int variantID, int quantity, double price, String stockStatus) {
        this.variantID = variantID;
        this.quantity = quantity;
        this.price = price;
        this.stockStatus = stockStatus;
    }

    public ProductVariant() {
    }

    public ProductVariant(int variantID) {
        this.variantID = variantID;
    }

    public ProductVariant(int variantID, Product product, Color color, Size size) {
        this.variantID = variantID;
        this.product = product;
        this.color = color;
        this.size = size;
    }

    public ProductVariant(int variantID, int quantity, double price) {
        this.variantID = variantID;
        this.quantity = quantity;
        this.price = price;
    }

    public ProductVariant(int variantID, int quantity, Product product, double price) {
        this.variantID = variantID;
        this.quantity = quantity;
        this.product = product;
        this.price = price;
    }

    public ProductVariant(int variantID, Product product) {
        this.variantID = variantID;
        this.product = product;
    }

    public ProductVariant(int variantID, int quantity, Product product, Color color, Size size, double price, String stockStatus) {
        this.variantID = variantID;
        this.quantity = quantity;
        this.product = product;
        this.color = color;
        this.size = size;
        this.price = price;
        this.stockStatus = stockStatus;
    }

    public ProductVariant(Product product) {
        this.product = product;
    }

    public ProductVariant(int variantID, Product product, double price) {
        this.variantID = variantID;
        this.product = product;
        this.price = price;
    }

    

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Color getColor() {
        return color;
    }

    public void setColor(Color color) {
        this.color = color;
    }

    public Size getSize() {
        return size;
    }

    public void setSize(Size size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStockStatus() {
        return stockStatus;
    }

    public void setStockStatus(String stockStatus) {
        this.stockStatus = stockStatus;
    }
    
}
