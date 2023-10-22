package com.example.dao;

import com.example.models.Request;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RequestsDAO {

    private static final String GET_REQUEST_BY_ID = "SELECT * FROM Requests WHERE RequestId = ?";
    private static final String GET_REQUESTS_BY_RIDE_ID = "SELECT * FROM Requests WHERE RideId = ?";
    private static final String GET_REQUESTS_BY_PASSENGER_ID = "SELECT * FROM Requests WHERE PassengerId = ?";
    private static final String INSERT_REQUEST = "INSERT INTO Requests (RideId, PassengerId, Status) VALUES (?, ?, ?)";
    private static final String UPDATE_REQUEST_STATUS = "UPDATE Requests SET Status = ? WHERE RequestId = ?";
    private static final String DELETE_REQUEST = "DELETE FROM Requests WHERE RequestId = ?";

    public Request getRequestById(int requestId) {
        Request request = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_REQUEST_BY_ID)) {

            preparedStatement.setInt(1, requestId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                request = new Request();
                request.setRequestId(resultSet.getInt("RequestId"));
                request.setRideId(resultSet.getInt("RideId"));
                request.setPassengerId(resultSet.getInt("PassengerId"));
                request.setStatus(resultSet.getString("Status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return request;
    }

    public List<Request> getRequestsByRideId(int rideId) {
        List<Request> requestsList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_REQUESTS_BY_RIDE_ID)) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Request request = new Request();
                request.setRequestId(resultSet.getInt("RequestId"));
                request.setRideId(resultSet.getInt("RideId"));
                request.setPassengerId(resultSet.getInt("PassengerId"));
                request.setStatus(resultSet.getString("Status"));
                requestsList.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requestsList;
    }

    public List<Request> getRequestsByPassengerId(int passengerId) {
        List<Request> requestsList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_REQUESTS_BY_PASSENGER_ID)) {

            preparedStatement.setInt(1, passengerId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Request request = new Request();
                request.setRequestId(resultSet.getInt("RequestId"));
                request.setRideId(resultSet.getInt("RideId"));
                request.setPassengerId(resultSet.getInt("PassengerId"));
                request.setStatus(resultSet.getString("Status"));
                requestsList.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return requestsList;
    }

    public boolean insertRequest(Request request) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_REQUEST)) {

            preparedStatement.setInt(1, request.getRideId());
            preparedStatement.setInt(2, request.getPassengerId());
            preparedStatement.setString(3, request.getStatus());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_REQUEST_STATUS)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, requestId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteRequest(int requestId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_REQUEST)) {

            preparedStatement.setInt(1, requestId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
