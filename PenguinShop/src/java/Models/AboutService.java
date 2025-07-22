package Models;

public class AboutService {
    private int serviceID;
    private String serviceName;
    private String serviceDescription;
    private String serviceIcon;
    private int displayOrder;
    private boolean isActive;
    
    // Constructor mặc định
    public AboutService() {}
    
    // Constructor đầy đủ
    public AboutService(int serviceID, String serviceName, String serviceDescription, 
                       String serviceIcon, int displayOrder, boolean isActive) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.serviceDescription = serviceDescription;
        this.serviceIcon = serviceIcon;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
    }
    
    // Constructor cho insert
    public AboutService(String serviceName, String serviceDescription, 
                       String serviceIcon, int displayOrder, boolean isActive) {
        this.serviceName = serviceName;
        this.serviceDescription = serviceDescription;
        this.serviceIcon = serviceIcon;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
    }
    
    // Getters and Setters
    public int getServiceID() {
        return serviceID;
    }
    
    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }
    
    public String getServiceName() {
        return serviceName;
    }
    
    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }
    
    public String getServiceDescription() {
        return serviceDescription;
    }
    
    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }
    
    public String getServiceIcon() {
        return serviceIcon;
    }
    
    public void setServiceIcon(String serviceIcon) {
        this.serviceIcon = serviceIcon;
    }
    
    public int getDisplayOrder() {
        return displayOrder;
    }
    
    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    @Override
    public String toString() {
        return "AboutService{" +
                "serviceID=" + serviceID +
                ", serviceName='" + serviceName + '\'' +
                ", serviceDescription='" + serviceDescription + '\'' +
                ", serviceIcon='" + serviceIcon + '\'' +
                ", displayOrder=" + displayOrder +
                ", isActive=" + isActive +
                '}';
    }
}
