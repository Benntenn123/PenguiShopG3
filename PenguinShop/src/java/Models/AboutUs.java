package Models;

import java.sql.Timestamp;
import java.util.List;

public class AboutUs {
    private int aboutID;
    private String title;
    private String subtitle;
    private String mainImage;
    private String content;
    private String highlightPoints;
    private String videoUrl;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer updatedBy;
    
    // Thêm các thuộc tính phụ để xử lý highlight points
    private List<String> highlightPointsList;
    
    // Constructor mặc định
    public AboutUs() {}
    
    // Constructor đầy đủ
    public AboutUs(int aboutID, String title, String subtitle, String mainImage, 
                   String content, String highlightPoints, String videoUrl, 
                   boolean isActive, Timestamp createdAt, Timestamp updatedAt, 
                   Integer updatedBy) {
        this.aboutID = aboutID;
        this.title = title;
        this.subtitle = subtitle;
        this.mainImage = mainImage;
        this.content = content;
        this.highlightPoints = highlightPoints;
        this.videoUrl = videoUrl;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.updatedBy = updatedBy;
    }
    
    // Constructor cho insert
    public AboutUs(String title, String subtitle, String mainImage, 
                   String content, String highlightPoints, String videoUrl, 
                   boolean isActive) {
        this.title = title;
        this.subtitle = subtitle;
        this.mainImage = mainImage;
        this.content = content;
        this.highlightPoints = highlightPoints;
        this.videoUrl = videoUrl;
        this.isActive = isActive;
    }
    
    // Getters and Setters
    public int getAboutID() {
        return aboutID;
    }
    
    public void setAboutID(int aboutID) {
        this.aboutID = aboutID;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getSubtitle() {
        return subtitle;
    }
    
    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }
    
    public String getMainImage() {
        return mainImage;
    }
    
    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public String getHighlightPoints() {
        return highlightPoints;
    }
    
    public void setHighlightPoints(String highlightPoints) {
        this.highlightPoints = highlightPoints;
    }
    
    public String getVideoUrl() {
        return videoUrl;
    }
    
    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public Integer getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(Integer updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    public List<String> getHighlightPointsList() {
        return highlightPointsList;
    }
    
    public void setHighlightPointsList(List<String> highlightPointsList) {
        this.highlightPointsList = highlightPointsList;
    }
    
    @Override
    public String toString() {
        return "AboutUs{" +
                "aboutID=" + aboutID +
                ", title='" + title + '\'' +
                ", subtitle='" + subtitle + '\'' +
                ", mainImage='" + mainImage + '\'' +
                ", content='" + content + '\'' +
                ", highlightPoints='" + highlightPoints + '\'' +
                ", videoUrl='" + videoUrl + '\'' +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", updatedBy=" + updatedBy +
                '}';
    }
}
