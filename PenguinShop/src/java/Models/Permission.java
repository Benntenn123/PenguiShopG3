/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class Permission {
    private int permissionID;
    private String permissionName;
    private String url_permisson;
    private Modules modules;
    private int isHide;
    private String permissionDescription;

    public Permission() {
    }

    public int getPermissionID() {
        return permissionID;
    }

    public void setPermissionID(int permissionID) {
        this.permissionID = permissionID;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public String getUrl_permisson() {
        return url_permisson;
    }

    public void setUrl_permisson(String url_permisson) {
        this.url_permisson = url_permisson;
    }

    public Modules getModules() {
        return modules;
    }

    public void setModules(Modules modules) {
        this.modules = modules;
    }

    public int getIsHide() {
        return isHide;
    }

    public void setIsHide(int isHide) {
        this.isHide = isHide;
    }

    public String getPermissionDescription() {
        return permissionDescription;
    }

    public void setPermissionDescription(String permissionDescription) {
        this.permissionDescription = permissionDescription;
    }
    
}
