/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

public class RolesPermission {
    private int rolePermissionID;
    private Role role;
    private Permission permission;

    public RolesPermission() {
    }

    public int getRolePermissionID() {
        return rolePermissionID;
    }

    public void setRolePermissionID(int rolePermissionID) {
        this.rolePermissionID = rolePermissionID;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Permission getPermission() {
        return permission;
    }

    public void setPermission(Permission permission) {
        this.permission = permission;
    }
    
}
