package com.example.tests;

import com.example.utils.DatabaseUtility;

import java.sql.Connection;

public class TestConnection {

    public static void main(String[] args) {
        try {
            Connection connection = DatabaseUtility.getConnection();
            if (connection != null) {
                System.out.println("Connected to the database!");
                DatabaseUtility.closeConnection(connection);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
