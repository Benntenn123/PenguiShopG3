
package Models;

import java.util.Date;


    public class User {
    private int userID;
    private String fullName;
    private String password;
    private int roleID;
    private String address;
    private Date birthday;
    private String phone;
    private String email;
    private String image_user;
    private Role role;
    private int status_account;
    private String created_at;
    public User(int userID, String fullName, Date birthday, String phone, String email, String image_user, Role role) {
        this.userID = userID;
        this.fullName = fullName;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
        this.role = role;
    }

    public User(int userID, String fullName, int roleID, String address, Date birthday, String phone, String email, String image_user, int status_account, String created_at) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
        this.status_account = status_account;
        this.created_at = created_at;
    }
    

    public User(int userID, String fullName, String password, int roleID, String address, Date birthday, String phone, String email, String image_user) {
        this.userID = userID;
        this.fullName = fullName;
        this.password = password;
        this.roleID = roleID;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
    }

    public User(int userID, String fullName, String phone, String email) {
        this.userID = userID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
    }
    

    // Constructor
    public User(int userID, String fullName, String password, int roleID, String address, Date birthday, String phone, String email) {
        this.userID = userID;
        this.fullName = fullName;
        this.password = password;
        this.roleID = roleID;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
    }

    public User(int userID, String fullName, Date birthday, String phone, String email, String image_user) {
        this.userID = userID;
        this.fullName = fullName;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
    }

    public User(int userID,String fullName, String address, Date birthday, String phone, String email, String image_user) {
        this.userID = userID;
        this.fullName = fullName;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
    }

    public User(int aInt, String string) {
        this.userID = aInt;
        this.fullName = string;
    }

    public String getImage_user() {
        return image_user;
    }

    public void setImage_user(String image_user) {
        this.image_user = image_user;
    }

    // Default Constructor
    public User() {}

    public User(int userID, String fullName, Date birthday, String phone, String email, String image_user, Role role, int status_account, String created_at) {
        this.userID = userID;
        this.fullName = fullName;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.image_user = image_user;
        this.role = role;
        this.status_account = status_account;
        this.created_at = created_at;
    }

    public User(int userID) {
        this.userID = userID;
    }

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public int getStatus_account() {
        return status_account;
    }

    public void setStatus_account(int status_account) {
        this.status_account = status_account;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

   
    // toString method
    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", fullName='" + fullName + '\'' +
                ", password='" + password + '\'' +
                ", roleID=" + roleID +
                ", address='" + address + '\'' +
                ", birthday=" + birthday +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}

