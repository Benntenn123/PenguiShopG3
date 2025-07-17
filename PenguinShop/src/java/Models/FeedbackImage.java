package Models;

public class FeedbackImage {
    private int imageID;
    private int feedbackID;
    private String imageURL;
    private String imageCaption;
    
    public FeedbackImage() {
    }
    
    public FeedbackImage(int imageID, int feedbackID, String imageURL, String imageCaption) {
        this.imageID = imageID;
        this.feedbackID = feedbackID;
        this.imageURL = imageURL;
        this.imageCaption = imageCaption;
    }
    
    // Getters and Setters
    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getImageCaption() {
        return imageCaption;
    }

    public void setImageCaption(String imageCaption) {
        this.imageCaption = imageCaption;
    }

    @Override
    public String toString() {
        return "FeedbackImage{" +
                "imageID=" + imageID +
                ", feedbackID=" + feedbackID +
                ", imageURL='" + imageURL + '\'' +
                ", imageCaption='" + imageCaption + '\'' +
                '}';
    }
}
