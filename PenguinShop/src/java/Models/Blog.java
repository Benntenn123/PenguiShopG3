package Models;

import java.util.Date;

public class Blog {
    private int blogID;
    private String title;
    private String content;
    private String image;
    private String imageUrl; // For displaying Cloudinary URLs
    private String authorName; // For displaying author name
    private String authorImage; // For displaying author image
    private Date created_at;
    private Date updated_at;
    private int authorID;
    private int status;

    // Constructors
    public Blog() {}

    public Blog(int blogID, String title, String content, String image, Date created_at, Date updated_at, int authorID, int status) {
        this.blogID = blogID;
        this.title = title;
        this.content = content;
        this.image = image;
        this.created_at = created_at;
        this.updated_at = updated_at;
        this.authorID = authorID;
        this.status = status;
    }

    // Getters and Setters
    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorImage() {
        return authorImage;
    }

    public void setAuthorImage(String authorImage) {
        this.authorImage = authorImage;
    }
}
