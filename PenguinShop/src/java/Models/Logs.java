
package Models;

public class Logs {
     private int logID;
     private User user;
     private String action;
     private String description;
     private String logDate;

    public Logs(int logID, User user, String action, String description, String logDate) {
        this.logID = logID;
        this.user = user;
        this.action = action;
        this.description = description;
        this.logDate = logDate;
    }

    public Logs(int logID, User user, String action, String logDate) {
        this.logID = logID;
        this.user = user;
        this.action = action;
        this.logDate = logDate;
    }

    public Logs() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLogDate() {
        return logDate;
    }

    public void setLogDate(String logDate) {
        this.logDate = logDate;
    }
     
}
