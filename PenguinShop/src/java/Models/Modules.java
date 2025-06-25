/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class Modules {

    private int moduleID;
    private String moduleName;
    private String icon;

    public Modules() {
    }

    public Modules(int moduleID, String moduleName, String icon) {
        this.moduleID = moduleID;
        this.moduleName = moduleName;
        this.icon = icon;
    }

    public int getModuleID() {
        return moduleID;
    }

    public void setModuleID(int moduleID) {
        this.moduleID = moduleID;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        Modules m = (Modules) obj;
        return moduleID == m.moduleID;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(moduleID);
    }

}
