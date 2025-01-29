package com.resort;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class AzureConnection {
	// Database credentials
    private static final String DB_DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String DB_CONNECTION = "jdbc:sqlserver://mdresortdb.database.windows.net:1433;database=MDResortDB;user=mdresortadmin@mdresortdb;password=mdresort_2024;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;";
    private static final String DB_USER = "mdresort"; 
    private static final String DB_PASSWORD = "mdresort_2024";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(DB_DRIVER);
            connection = DriverManager.getConnection(DB_CONNECTION);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

}