/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;
import java.util.List;

public class Promotion {
    private int promotionID;
    private String promotionName;
    private String discountType;
    private double discountValue;
    private String startDate;
    private String endDate;
    private String description;
    private int isActive;

    public int getTotalCount() {
        return totalCount;
    }

    @Override
    public String toString() {
        return "Promotion{" + "promotionID=" + promotionID + ", promotionName=" + promotionName + ", discountType=" + discountType + ", discountValue=" + discountValue + ", startDate=" + startDate + ", endDate=" + endDate + ", description=" + description + ", isActive=" + isActive + ", products=" + products + ", variant=" + variant + ", totalCount=" + totalCount + '}';
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
    private List<Product> products;
    private List<ProductVariant> variant;
    private int totalCount;

    public Promotion() {
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(double discountValue) {
        this.discountValue = discountValue;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public List<ProductVariant> getVariant() {
        return variant;
    }

    public void setVariant(List<ProductVariant> variant) {
        this.variant = variant;
    }
    
}
