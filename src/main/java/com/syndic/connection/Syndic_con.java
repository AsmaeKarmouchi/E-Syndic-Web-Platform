package com.syndic.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Syndic_con {
    String db = "syndic_db";
    String user = "root";
    String pwd = "Asmae2003KARMOUCHI";
    String url = "jdbc:mysql://localhost:3306/" + db + "?useSSL=false";

    private static Connection connection = null;


    private Syndic_con() {
        try {

            connection = DriverManager.getConnection(url, user, pwd);
            System.out.println("instance cree!!"+connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static Connection getConnection() {
        if (connection == null)
            new Syndic_con();
        System.out.println("syndic_con"+connection);
        return connection;

    }

}
