/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Modules;
import Models.Permission;
import Models.Role;
import Models.RolesPermission;
import Models.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class PermissionDAO extends DBContext {

    public List<Role> getAllRole() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM dbo.tbRoles";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Role r = new Role(rs.getInt(1),
                        rs.getString(2));
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertRole(String roleName) {

        String sql = "INSERT INTO dbo.tbRoles\n"
                + "(roleName)\n"
                + "VALUES\n"
                + "(?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, roleName);
            int row = ps.executeUpdate();
            if(row>0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updateRole(String roleName, int roleID) {

        String sql = "UPDATE dbo.tbRoles SET roleName= ? where roleID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, roleName);
            ps.setInt(2, roleID);
            int row = ps.executeUpdate();
            if(row>0){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        PermissionDAO pdao = new PermissionDAO();
        try {
//            System.out.println("hẹ hẹ");
//            Map<String, Object> result = pdao.getPermissions("", 4, 1, 10);
//            System.out.println("hẹ hẹ");
//            List<Permission> listPermissions = (List<Permission>) result.get("permissions");
//            Map<Integer, String> roleNamesMap = (Map<Integer, String>) result.get("roleNamesMap");
//            
//            for (Permission listPermission : listPermissions) {
//                System.out.println(listPermission.getPermissionName());
//            }
//            for (Map.Entry<Integer, String> entry : roleNamesMap.entrySet()) {
//                System.out.println(entry.getKey());
//                System.out.println(entry.getValue());
//                
//            }
            LinkedHashMap<Modules, List<Permission>> map = pdao.loadPermissionsByRole(3);
            for (Map.Entry<Modules, List<Permission>> entry : map.entrySet()) {
                System.out.println(entry.getKey().getModuleName());
                for (Permission arg : entry.getValue()) {
                    System.out.println(arg.getPermissionName());
                }
            }
            System.out.println(pdao.getAllModules().size());
        } catch (Exception e) {
        }

    }

    public List<Modules> getAllModules() {
        List<Modules> modules = new ArrayList<>();
        String sql = "SELECT moduleID, moduleName, icon FROM tbModules";
        System.out.println("SQL: " + sql);

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Modules module = new Modules();
                module.setModuleID(rs.getInt("moduleID"));
                module.setModuleName(rs.getString("moduleName"));
                module.setIcon(rs.getString("icon"));
                modules.add(module);
            }
        } catch (SQLException e) {
            System.err.println("❌ SQLException at getAllModules(): " + e.getMessage());
            e.printStackTrace(); // Hiện stacktrace chi tiết
        }

        return modules;
    }

    // Lấy danh sách permission với bộ lọc, phân trang, và roleNames
    public Map<String, Object> getPermissions(String permissionName, Integer moduleId, int page, int pageSize)
            throws SQLException {
        List<Permission> permissions = new ArrayList<>();
        Map<Integer, String> roleNamesMap = new HashMap<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.permissionID, p.permissionName, p.url_permission, p.isHide, p.permissionDescription, "
                + "m.moduleID, m.moduleName, m.icon, "
                + "STRING_AGG(r.roleName, ', ') AS roleNames "
                + "FROM tbPermissions p "
                + "LEFT JOIN tbModules m ON p.moduleID = m.moduleID "
                + "LEFT JOIN tbRolePermissions rp ON p.permissionID = rp.permissionID "
                + "LEFT JOIN tbRoles r ON rp.roleID = r.roleID "
                + "WHERE 1=1"
        );

        if (permissionName != null && !permissionName.trim().isEmpty()) {
            sql.append(" AND p.permissionName LIKE ?");
        }
        if (moduleId != null) {
            sql.append(" AND p.moduleID = ?");
        }
        sql.append(" GROUP BY p.permissionID, p.permissionName, p.url_permission, p.isHide, p.permissionDescription, "
                + "m.moduleID, m.moduleName, m.icon "
                + "ORDER BY p.permissionID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (permissionName != null && !permissionName.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + permissionName + "%");
            }
            if (moduleId != null) {
                stmt.setInt(paramIndex++, moduleId);
            }
            stmt.setInt(paramIndex++, (page - 1) * pageSize);
            stmt.setInt(paramIndex, pageSize);
            System.out.println(sql);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Permission perm = new Permission();
                    perm.setPermissionID(rs.getInt("permissionID"));
                    perm.setPermissionName(rs.getString("permissionName"));
                    perm.setUrl_permisson(rs.getString("url_permission"));
                    perm.setIsHide(rs.getInt("isHide")); // isMenuItem=1 -> isHide=0 (hiển thị)
                    perm.setPermissionDescription(rs.getString("permissionDescription"));
                    // Populate Module
                    Modules module = new Modules();
                    module.setModuleID(rs.getInt("moduleID"));
                    module.setModuleName(rs.getString("moduleName"));
                    module.setIcon(rs.getString("icon"));

                    // Lưu roleNames vào Map
                    roleNamesMap.put(perm.getPermissionID(), rs.getString("roleNames") != null ? rs.getString("roleNames") : "");

                    permissions.add(perm);
                }
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("permissions", permissions);
        result.put("roleNamesMap", roleNamesMap);
        return result;
    }

    // Đếm tổng số permission
    public int getTotalPermissions(String permissionName, Integer moduleId) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tbPermissions p WHERE 1=1");
        if (permissionName != null && !permissionName.trim().isEmpty()) {
            sql.append(" AND p.permissionName LIKE ?");
        }
        if (moduleId != null) {
            sql.append(" AND p.moduleID = ?");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (permissionName != null && !permissionName.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + permissionName + "%");
            }
            if (moduleId != null) {
                stmt.setInt(paramIndex, moduleId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    // Đếm số permission hiển thị trên menu (isMenuItem = 0)
    public int getMenuItemCount(String permissionName, Integer moduleId) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM tbPermissions p WHERE p.isHide = 0"
        );
        if (permissionName != null && !permissionName.trim().isEmpty()) {
            sql.append(" AND p.permissionName LIKE ?");
        }
        if (moduleId != null) {
            sql.append(" AND p.moduleID = ?");
        }

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (permissionName != null && !permissionName.trim().isEmpty()) {
                stmt.setString(paramIndex++, "%" + permissionName + "%");
            }
            if (moduleId != null) {
                stmt.setInt(paramIndex, moduleId);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public List<Permission> getPermissionsByRole(int roleId) throws SQLException {
        List<Permission> permissions = new ArrayList<>();
        String sql = "SELECT p.permissionID, p.permissionName, p.url_permission, p.isHide, p.permissionDescription, "
                + "m.moduleID, m.moduleName, m.icon "
                + "FROM tbPermissions p "
                + "JOIN tbRolePermissions rp ON p.permissionID = rp.permissionID "
                + "LEFT JOIN tbModules m ON p.moduleID = m.moduleID "
                + "WHERE rp.roleID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Permission perm = new Permission();
                    perm.setPermissionID(rs.getInt("permissionID"));
                    perm.setPermissionName(rs.getString("permissionName"));
                    perm.setUrl_permisson(rs.getString("url_permission"));
                    perm.setIsHide(rs.getInt("isHide"));
                    perm.setPermissionDescription(rs.getString("permissionDescription"));

                    Modules module = new Modules();
                    module.setModuleID(rs.getInt("moduleID"));
                    module.setModuleName(rs.getString("moduleName"));
                    module.setIcon(rs.getString("icon"));
                    perm.setModules(module);

                    permissions.add(perm);
                }
            }
        }
        return permissions;
    }

    // Lấy danh sách permission chưa được gán cho role
    public List<Permission> getAvailablePermissionsForRole(int roleId) throws SQLException {
        List<Permission> permissions = new ArrayList<>();
        String sql = "SELECT p.permissionID, p.permissionName, p.isHide, p.url_permission, p.permissionDescription, "
                + "m.moduleID, m.moduleName, m.icon "
                + "FROM tbPermissions p "
                + "LEFT JOIN tbModules m ON p.moduleID = m.moduleID "
                + "WHERE p.permissionID NOT IN (SELECT permissionID FROM tbRolePermissions WHERE roleID = ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Permission perm = new Permission();
                    perm.setPermissionID(rs.getInt("permissionID"));
                    perm.setPermissionName(rs.getString("permissionName"));
                    perm.setUrl_permisson(rs.getString("url_permission"));
                    perm.setIsHide(rs.getInt("isHide"));
                    perm.setPermissionDescription(rs.getString("permissionDescription"));

                    Modules module = new Modules();
                    module.setModuleID(rs.getInt("moduleID"));
                    module.setModuleName(rs.getString("moduleName"));
                    module.setIcon(rs.getString("icon"));
                    perm.setModules(module);

                    permissions.add(perm);
                }
            }
        }
        return permissions;
    }

    // Thêm permission cho role
    public void addRolePermission(int roleId, int permissionId) throws SQLException {
        String sql = "INSERT INTO tbRolePermissions (roleID, permissionID) VALUES (?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            stmt.setInt(2, permissionId);
            stmt.executeUpdate();
        }
    }

    // Xóa permission khỏi role
    public void removeRolePermission(int roleId, int permissionId) throws SQLException {
        String sql = "DELETE FROM tbRolePermissions WHERE roleID = ? AND permissionID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            stmt.setInt(2, permissionId);
            stmt.executeUpdate();
        }
    }

    public List<Permission> getPermissionsByRole(int roleId, int page, int pageSize) throws SQLException {
        List<Permission> permissions = new ArrayList<>();
        String sql = "SELECT p.permissionID, p.permissionName, p.url_permission, p.isHide, p.permissionDescription, "
                + "m.moduleID, m.moduleName, m.icon "
                + "FROM tbPermissions p "
                + "JOIN tbRolePermissions rp ON p.permissionID = rp.permissionID "
                + "LEFT JOIN tbModules m ON p.moduleID = m.moduleID "
                + "WHERE rp.roleID = ? "
                + "ORDER BY p.permissionID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Permission perm = new Permission();
                    perm.setPermissionID(rs.getInt("permissionID"));
                    perm.setPermissionName(rs.getString("permissionName"));
                    perm.setUrl_permisson(rs.getString("url_permission"));
                    perm.setIsHide(rs.getBoolean("isHide") ? 0 : 1);
                    perm.setPermissionDescription(rs.getString("permissionDescription"));

                    Modules module = new Modules();
                    module.setModuleID(rs.getInt("moduleID"));
                    module.setModuleName(rs.getString("moduleName"));
                    module.setIcon(rs.getString("icon"));
                    perm.setModules(module);

                    permissions.add(perm);
                }
            }
        }
        return permissions;
    }

    // Đếm tổng số permission của một role
    public int getTotalPermissionsByRole(int roleId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tbRolePermissions WHERE roleID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, roleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

    public LinkedHashMap<Modules, List<Permission>> loadPermissionsByRole(int roleID) {
        LinkedHashMap<Modules, List<Permission>> moduleMap = new LinkedHashMap<>();

        String sql = "SELECT m.moduleID, m.moduleName, m.icon, "
                + "p.permissionID, p.permissionName, p.url_permission, p.isHide, p.permissionDescription "
                + "FROM tbModules m "
                + "JOIN tbPermissions p ON m.moduleID = p.moduleID "
                + "JOIN tbRolePermissions rp ON rp.permissionID = p.permissionID "
                + "WHERE rp.roleID = ? "
                + "ORDER BY m.moduleID ASC, p.permissionID ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int moduleID = rs.getInt("moduleID");
                String moduleName = rs.getString("moduleName");
                String icon = rs.getString("icon");

                Modules module = new Modules(moduleID, moduleName, icon);
                moduleMap.putIfAbsent(module, new ArrayList<>());

                Permission permission = new Permission();
                permission.setPermissionID(rs.getInt("permissionID"));
                permission.setPermissionName(rs.getString("permissionName"));
                permission.setUrl_permisson(rs.getString("url_permission"));
                permission.setIsHide(rs.getInt("isHide"));
                permission.setPermissionDescription(rs.getString("permissionDescription"));
                // Bạn có thể bỏ qua setModules nếu không cần

                moduleMap.get(module).add(permission);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return moduleMap;
    }

}
