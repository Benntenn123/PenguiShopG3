package Models;

public class CompanyStat {
    private int statID;
    private String statName;
    private String statValue;
    private String statIcon;
    private int displayOrder;
    private boolean isActive;
    
    // Constructor mặc định
    public CompanyStat() {}
    
    // Constructor đầy đủ
    public CompanyStat(int statID, String statName, String statValue, 
                      String statIcon, int displayOrder, boolean isActive) {
        this.statID = statID;
        this.statName = statName;
        this.statValue = statValue;
        this.statIcon = statIcon;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
    }
    
    // Constructor cho insert
    public CompanyStat(String statName, String statValue, String statIcon, 
                      int displayOrder, boolean isActive) {
        this.statName = statName;
        this.statValue = statValue;
        this.statIcon = statIcon;
        this.displayOrder = displayOrder;
        this.isActive = isActive;
    }
    
    // Getters and Setters
    public int getStatID() {
        return statID;
    }
    
    public void setStatID(int statID) {
        this.statID = statID;
    }
    
    public String getStatName() {
        return statName;
    }
    
    public void setStatName(String statName) {
        this.statName = statName;
    }
    
    public String getStatValue() {
        return statValue;
    }
    
    public void setStatValue(String statValue) {
        this.statValue = statValue;
    }
    
    public String getStatIcon() {
        return statIcon;
    }
    
    public void setStatIcon(String statIcon) {
        this.statIcon = statIcon;
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
        return "CompanyStat{" +
                "statID=" + statID +
                ", statName='" + statName + '\'' +
                ", statValue='" + statValue + '\'' +
                ", statIcon='" + statIcon + '\'' +
                ", displayOrder=" + displayOrder +
                ", isActive=" + isActive +
                '}';
    }
}
