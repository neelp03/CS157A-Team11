package com.example.dao;

import com.example.models.RideHistory;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RideHistoryDAO {

    private static final String GET_RIDE_HISTORY_BY_USER_ID = "SELECT * FROM RideHistory WHERE UserId = ?";
    private static final String INSERT_RIDE_HISTORY = "INSERT INTO RideHistory (UserId, RideId, Type, Date) VALUES (?, ?, ?, ?";

    public List<RideHistory> getRideHistoryByUserId(int userId) {
        List<RideHistory> rideHistoryList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_RIDE_HISTORY_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                RideHistory rideHistory = new RideHistory();
                rideHistory.setRideHistoryId(resultSet.getInt("RideHistoryId"));
                rideHistory.setUserId(resultSet.getInt("UserId"));
                rideHistory.setRideId(resultSet.getInt("RideId"));
                rideHistory.setType(resultSet.getString("Type"));
                rideHistory.setDate(resultSet.getDate("Date"));
                rideHistoryList.add(rideHistory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rideHistoryList;
    }

    public boolean insertRideHistory(RideHistory rideHistory) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RIDE_HISTORY)) {

            preparedStatement.setInt(1, rideHistory.getUserId());
            preparedStatement.setInt(2, rideHistory.getRideId());
            preparedStatement.setString(3, rideHistory.getType());
            preparedStatement.setDate(4, rideHistory.getDate());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}

