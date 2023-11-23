package com.example.dao;

import com.example.models.Vehicle;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    private static final String GET_VEHICLE_BY_LICENSE = "SELECT * FROM Vehicle WHERE LicensePlate = ?";
    private static final String GET_VEHICLES_BY_USER_ID = "SELECT * FROM Vehicle WHERE UserId = ?";
    private static final String INSERT_VEHICLE = "INSERT INTO Vehicle (LicensePlate, UserId, Manufacturer, Model, Color) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_VEHICLE = "UPDATE Vehicle SET Manufacturer = ?, Model = ?, Color = ? WHERE LicensePlate = ?";
    private static final String DELETE_VEHICLE = "DELETE FROM Vehicle WHERE LicensePlate = ?";

    public Vehicle getVehicleByLicense(String licensePlate) {
        Vehicle vehicle = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_VEHICLE_BY_LICENSE)) {

            preparedStatement.setString(1, licensePlate);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                vehicle = new Vehicle();
                vehicle.setLicensePlate(resultSet.getString("LicensePlate"));
                vehicle.setUserId(resultSet.getInt("UserId"));
                vehicle.setManufacturer(resultSet.getString("Manufacturer"));
                vehicle.setModel(resultSet.getString("Model"));
                vehicle.setColor(resultSet.getString("Color"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehicle;
    }

    public List<Vehicle> getVehiclesByUserId(int userId) {
        List<Vehicle> vehiclesList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_VEHICLES_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Vehicle vehicle = new Vehicle();
                vehicle.setLicensePlate(resultSet.getString("LicensePlate"));
                vehicle.setUserId(resultSet.getInt("UserId"));
                vehicle.setManufacturer(resultSet.getString("Manufacturer"));
                vehicle.setModel(resultSet.getString("Model"));
                vehicle.setColor(resultSet.getString("Color"));
                vehiclesList.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vehiclesList;
    }

    public boolean insertVehicle(Vehicle vehicle) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_VEHICLE)) {

            preparedStatement.setString(1, vehicle.getLicensePlate());
            preparedStatement.setInt(2, vehicle.getUserId());
            preparedStatement.setString(3, vehicle.getManufacturer());
            preparedStatement.setString(4, vehicle.getModel());
            preparedStatement.setString(5, vehicle.getColor());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateVehicle(Vehicle vehicle) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_VEHICLE)) {

            preparedStatement.setString(1, vehicle.getManufacturer());
            preparedStatement.setString(2, vehicle.getModel());
            preparedStatement.setString(3, vehicle.getColor());
            preparedStatement.setString(4, vehicle.getLicensePlate());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteVehicle(String licensePlate) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_VEHICLE)) {

            preparedStatement.setString(1, licensePlate);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

}
