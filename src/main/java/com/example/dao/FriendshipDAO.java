package com.example.dao;

import com.example.models.Friendship;
import com.example.utils.DatabaseUtility;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FriendshipDAO {

    private static final String INSERT_FRIEND_REQUEST = "INSERT INTO Friendship (StudentId1, StudentId2, Status) VALUES (?, ?, 'pending')";
    private static final String UPDATE_FRIENDSHIP_STATUS = "UPDATE Friendship SET Status = ? WHERE FriendshipId = ?";
    private static final String DELETE_FRIENDSHIP = "DELETE FROM Friendship WHERE FriendshipId = ?";
    private static final String GET_FRIENDSHIP_BY_ID = "SELECT * FROM Friendship WHERE FriendshipId = ?";
    private static final String GET_FRIENDS_OF_STUDENT = "SELECT * FROM Friendship WHERE (StudentId1 = ? OR StudentId2 = ?) AND Status = 'accepted'";
    private static final String GET_PENDING_REQUESTS = "SELECT * FROM Friendship WHERE StudentId2 = ? AND Status = 'pending'";

    public boolean sendFriendRequest(int requesterId, int requesteeId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_FRIEND_REQUEST)) {

            preparedStatement.setInt(1, requesterId);
            preparedStatement.setInt(2, requesteeId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateFriendshipStatus(int friendshipId, String status) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_FRIENDSHIP_STATUS)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, friendshipId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteFriendship(int friendshipId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_FRIENDSHIP)) {

            preparedStatement.setInt(1, friendshipId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public Friendship getFriendshipById(int friendshipId) {
        Friendship friendship = null;
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_FRIENDSHIP_BY_ID)) {

            preparedStatement.setInt(1, friendshipId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                friendship = extractFriendshipFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friendship;
    }

    public List<Friendship> getFriendsOfStudent(int studentId) {
        List<Friendship> friendships = new ArrayList<>();
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_FRIENDS_OF_STUDENT)) {

            preparedStatement.setInt(1, studentId);
            preparedStatement.setInt(2, studentId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                friendships.add(extractFriendshipFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friendships;
    }

    public List<Friendship> getPendingFriendRequests(int studentId) {
        List<Friendship> pendingRequests = new ArrayList<>();
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PENDING_REQUESTS)) {

            preparedStatement.setInt(1, studentId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                pendingRequests.add(extractFriendshipFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingRequests;
    }

    private Friendship extractFriendshipFromResultSet(ResultSet resultSet) throws SQLException {
        Friendship friendship = new Friendship();
        friendship.setFriendshipId(resultSet.getInt("FriendshipId"));
        friendship.setStudentId1(resultSet.getInt("StudentId1"));
        friendship.setStudentId2(resultSet.getInt("StudentId2"));
        friendship.setStatus(resultSet.getString("Status"));
        return friendship;
    }
}
