package com.example.dao;

import com.example.models.Users;
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
    private static final String GET_USER_BY_EMAIL_AND_PASSWORD_QUERY =
            "SELECT * FROM users WHERE email = ? AND password = ?";

    public boolean insertUser(Users users) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_QUERY)) {

            preparedStatement.setString(1, users.getEmail());
            preparedStatement.setString(2, users.getName());
            preparedStatement.setString(3, users.getPassword());
            preparedStatement.setString(4, users.getRole());
            preparedStatement.setInt(5, users.getUniversityId());

            int affectedRows = preparedStatement.executeUpdate();

            return affectedRows > 0;

        } catch (SQLException e) {
            // In a real-world application, you'd log this exception
            e.printStackTrace();
            return false;
        }
    }

    public Users getUserByID(int id) {
        Users users = null;
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_ID_QUERY)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    users = new Users();
                    users.setUserId(resultSet.getInt("UserId"));
                    users.setEmail(resultSet.getString("Email"));
                    users.setName(resultSet.getString("Name"));
                    users.setPassword(resultSet.getString("Password"));
                    users.setRole(resultSet.getString("Role"));
                    users.setUniversityId(resultSet.getInt("UniversityId"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<Users> getAllUsers() {
        List<Users> users = new ArrayList<>();
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_ALL_USERS_QUERY);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Users user = new Users();
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

    public void updateUser(Users users) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_QUERY)) {

            preparedStatement.setString(1, users.getEmail());
            preparedStatement.setString(2, users.getName());
            preparedStatement.setString(3, users.getPassword());
            preparedStatement.setString(4, users.getRole());
            preparedStatement.setInt(5, users.getUniversityId());
            preparedStatement.setInt(6, users.getUserId());

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Users> getUsersByName(String name) {
        List<Users> users = new ArrayList<>();
        try (Connection connection = DatabaseUtility.getConnection()) {
            String sql = "SELECT * FROM Users WHERE Name LIKE ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, "%" + name + "%");
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        Users user = new Users();
                        //... set user properties from resultSet
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<Users> searchUsersByName(String query) {
        List<Users> users = new ArrayList<>();
        String sql = "SELECT u.*, uni.Name AS UniversityName " +
                "FROM Users u " +
                "JOIN University uni ON u.UniversityId = uni.UniversityId " +
                "WHERE u.Name LIKE ?";
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + query + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Users user = new Users();
                    user.setUserId(resultSet.getInt("UserId"));
                    user.setEmail(resultSet.getString("Email"));
                    user.setName(resultSet.getString("Name"));
                    user.setRole(resultSet.getString("Role"));
                    user.setUniversityName(resultSet.getString("UniversityName")); // New line
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<Users> searchUsersByNameOrEmail(String query) {
        List<Users> resultList = new ArrayList<>();

        String SEARCH_USERS_QUERY = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ?";

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_USERS_QUERY)) {

            preparedStatement.setString(1, "%" + query + "%");
            preparedStatement.setString(2, "%" + query + "%");

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Users user = new Users();
                user.setUserId(rs.getInt("userId"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setPassword(rs.getString("password")); // Ideally, you wouldn't retrieve the password here.
                user.setRole(rs.getString("role"));
                user.setUniversityId(rs.getInt("universityId"));
                resultList.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resultList;
    }

    public Users getUserByEmailAndPassword(String email, String password) {
        Users user = null;
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_USER_BY_EMAIL_AND_PASSWORD_QUERY)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new Users();
                user.setUserId(resultSet.getInt("userId"));
                user.setEmail(resultSet.getString("email"));
                user.setName(resultSet.getString("name"));
                user.setPassword(resultSet.getString("password")); // In a real-world app, you wouldn't typically retrieve the password back into the model object.
                user.setRole(resultSet.getString("role"));
                user.setUniversityId(resultSet.getInt("universityId"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}