/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
// Edit URL , username, password to authenticate with your MS SQL Server
            String url = "jdbc:sqlserver://localhost:1433;databaseName= PenguinShop";
            String username = "viet";
            String password = "31122004";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }
     public static void main(String[] args) {
         DBContext dbContext = new DBContext();
        
        // Check if the connection is not null and print a message accordingly
        if (dbContext.connection != null) {
            System.out.println("Database connection is active.");
        } else {
            System.out.println("Database connection failed.");
        }
     }
}
