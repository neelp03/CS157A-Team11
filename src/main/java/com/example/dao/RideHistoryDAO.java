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

    private static final String GET_RIDE_HISTORY_BY_USER_ID =
            "SELECT Rides.RideId, 'Offered' AS Type, Rides.Time AS Date, Rides.PickupLocation, Rides.DropoffLocation " +
                    "FROM Rides " +
                    "WHERE Rides.DriverId = ? " +
                    "UNION " +
                    "SELECT Rides.RideId, 'Taken' AS Type, Rides.Time AS Date, Rides.PickupLocation, Rides.DropoffLocation " +
                    "FROM Rides " +
                    "INNER JOIN Requests ON Rides.RideId = Requests.RideId " +
                    "WHERE Requests.PassengerId = ?";
    public List<RideHistory> getRideHistoryByUserId(int userId) {
        List<RideHistory> rideHistoryList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_RIDE_HISTORY_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                RideHistory rideHistory = new RideHistory();
                rideHistory.setRideId(resultSet.getInt("RideId"));
                rideHistory.setType(resultSet.getString("Type"));
                rideHistory.setDate(resultSet.getTime("Date"));
                if ("Offered".equals(rideHistory.getType())) {
                    // For offered rides, set pickup and dropoff locations
                    rideHistory.setPickupLocation(getPickupLocation(rideHistory.getRideId()));
                    rideHistory.setDropoffLocation(getDropoffLocation(rideHistory.getRideId()));
                } else {
                    // For taken rides, set pickup and dropoff locations from the corresponding ride
                    int takenRideId = rideHistory.getRideId();
                    rideHistory.setPickupLocation(getPickupLocation(takenRideId));
                    rideHistory.setDropoffLocation(getDropoffLocation(takenRideId));
                }
                rideHistoryList.add(rideHistory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rideHistoryList;
    }

    // Helper method to get pickup location
    private String getPickupLocation(int rideId) {
        String pickupLocation = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT PickupLocation FROM Rides WHERE RideId = ?")) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                pickupLocation = resultSet.getString("PickupLocation");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return pickupLocation;
    }

    // Helper method to get dropoff location
    private String getDropoffLocation(int rideId) {
        String dropoffLocation = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT DropoffLocation FROM Rides WHERE RideId = ?")) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                dropoffLocation = resultSet.getString("DropoffLocation");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dropoffLocation;
    }
}

