package com.example.dao;

import com.example.models.User;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class UserDAO {
    private static final String INSERT_USER_QUERY = "INSERT INTO Users(Email, Name, Password, Role, UniversityId) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_USER_BY_ID_QUERY = "SELECT * FROM Users WHERE UserId = ?";
    private static final String GET_ALL_USERS_QUERY = "SELECT * FROM Users";
    private static final String DELETE_USER_QUERY = "DELETE FROM Users WHERE UserId = ?";
    private static final String UPDATE_USER_QUERY = "UPDATE Users SET Email = ?, Name = ?, Password = ?, Role = ?, UniversityId = ? WHERE UserId = ?";

    public void insertUser(User user) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_QUERY)) {

            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getName());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getRole());
            preparedStatement.setInt(5, user.getUniversityId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User getUserByID(int id) {
        User user = null;
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_ID_QUERY)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User();
                    user.setUserId(resultSet.getInt("UserId"));
                    user.setEmail(resultSet.getString("Email"));
                    user.setName(resultSet.getString("Name"));
                    user.setPassword(resultSet.getString("Password"));
                    user.setRole(resultSet.getString("Role"));
                    user.setUniversityId(resultSet.getInt("UniversityId"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_USERS_QUERY);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                User user = new User();
                user.setUserId(resultSet.getInt("UserId"));
                user.setEmail(resultSet.getString("Email"));
                user.setName(resultSet.getString("Name"));
                user.setPassword(resultSet.getString("Password"));
                user.setRole(resultSet.getString("Role"));
                user.setUniversityId(resultSet.getInt("UniversityId"));
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public void deleteUser(int id) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_QUERY)) {

            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(User user) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_QUERY)) {

            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getName());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getRole());
            preparedStatement.setInt(5, user.getUniversityId());
            preparedStatement.setInt(6, user.getUserId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}