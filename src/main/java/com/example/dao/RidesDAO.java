package com.example.dao;

import com.example.models.Ride;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RidesDAO {

    private static final String GET_RIDE_BY_ID = "SELECT * FROM Rides WHERE RideId = ?";
    private static final String GET_RIDES_BY_DRIVER_ID = "SELECT * FROM Rides WHERE DriverId = ?";
    private static final String INSERT_RIDE = "INSERT INTO Rides (DriverId, Time, PickupLocation, DropoffLocation, Status) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_RIDE_STATUS = "UPDATE Rides SET Status = ? WHERE RideId = ?";
    private static final String DELETE_RIDE = "DELETE FROM Rides WHERE RideId = ?";

    public Ride getRideById(int rideId) {
        Ride ride = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_RIDE_BY_ID)) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                ride = new Ride();
                ride.setRideId(resultSet.getInt("RideId"));
                ride.setDriverId(resultSet.getInt("DriverId"));
                ride.setTime(resultSet.getTime("Time"));
                ride.setPickupLocation(resultSet.getString("PickupLocation"));
                ride.setDropoffLocation(resultSet.getString("DropoffLocation"));
                ride.setStatus(resultSet.getString("Status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ride;
    }

    public List<Ride> getRidesByDriverId(int driverId) {
        List<Ride> ridesList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_RIDES_BY_DRIVER_ID)) {

            preparedStatement.setInt(1, driverId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Ride ride = new Ride();
                ride.setRideId(resultSet.getInt("RideId"));
                ride.setDriverId(resultSet.getInt("DriverId"));
                ride.setTime(resultSet.getTime("Time"));
                ride.setPickupLocation(resultSet.getString("PickupLocation"));
                ride.setDropoffLocation(resultSet.getString("DropoffLocation"));
                ride.setStatus(resultSet.getString("Status"));
                ridesList.add(ride);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ridesList;
    }

    public boolean insertRide(Ride ride) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RIDE)) {

            preparedStatement.setInt(1, ride.getDriverId());
            preparedStatement.setTime(2, ride.getTime());
            preparedStatement.setString(3, ride.getPickupLocation());
            preparedStatement.setString(4, ride.getDropoffLocation());
            preparedStatement.setString(5, ride.getStatus());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateRideStatus(int rideId, String status) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RIDE_STATUS)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, rideId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteRide(int rideId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_RIDE)) {

            preparedStatement.setInt(1, rideId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
