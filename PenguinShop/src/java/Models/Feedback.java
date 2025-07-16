package Models;

import java.util.Date;
import java.util.List;

public class Feedback {
    private int feedbackID;
    private int productID;
    private int variantID;
    private int userID;
    private int rating;
    private String comment;
    private Date feedbackDate;
    private List<String> images; // List các URL ảnh của feedback
    private Product product;     // Thông tin sản phẩm
    private User user;           // Thông tin người đánh giá
    private ProductVariant variant; // Thông tin biến thể sản phẩm

    public Feedback() {
    }

    public Feedback(int feedbackID, int productID, int variantID, int userID, int rating, String comment, Date feedbackDate) {
        this.feedbackID = feedbackID;
        this.productID = productID;
        this.variantID = variantID;
        this.userID = userID;
        this.rating = rating;
        this.comment = comment;
        this.feedbackDate = feedbackDate;
    }

    // Getters and Setters
    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(Date feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    @Override
    public String toString() {
        return "Feedback{" +
                "feedbackID=" + feedbackID +
                ", productID=" + productID +
                ", variantID=" + variantID +
                ", userID=" + userID +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", feedbackDate=" + feedbackDate +
                '}';
    }
}
