/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Sanduni
 */
public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/cabservicedb";
    private static final String user = "root";
    private static final String password = "";
    
    private DBUtil()
    {
        
    }
    
    public static Connection getConnection() throws SQLException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Database Connection created......");
            return (Connection) DriverManager.getConnection(URL,user,password);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error", e);
        }
    }
    
    
}
