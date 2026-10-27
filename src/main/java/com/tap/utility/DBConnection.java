package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/foodwala";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Divya@123";

    public static Connection getConnection() throws SQLException {
    	Connection con = null;
    	try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con =  DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return con;
    }
}