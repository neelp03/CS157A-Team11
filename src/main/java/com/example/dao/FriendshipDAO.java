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

    private static final String INSERT_FRIENDSHIP = "INSERT INTO Friendship (StudentId1, StudentId2) VALUES (?, ?)";
    private static final String DELETE_FRIENDSHIP = "DELETE FROM Friendship WHERE FriendshipId = ?";
    private static final String GET_FRIENDSHIP_BY_ID = "SELECT * FROM Friendship WHERE FriendshipId = ?";
    private static final String GET_FRIENDS_OF_STUDENT = "SELECT * FROM Friendship WHERE StudentId1 = ? OR StudentId2 = ?";

    public boolean addFriendship(Friendship friendship) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_FRIENDSHIP)) {

            preparedStatement.setInt(1, friendship.getStudentId1());
            preparedStatement.setInt(2, friendship.getStudentId2());
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
                friendship = new Friendship();
                friendship.setFriendshipId(resultSet.getInt("FriendshipId"));
                friendship.setStudentId1(resultSet.getInt("StudentId1"));
                friendship.setStudentId2(resultSet.getInt("StudentId2"));
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
                Friendship friendship = new Friendship();
                friendship.setFriendshipId(resultSet.getInt("FriendshipId"));
                friendship.setStudentId1(resultSet.getInt("StudentId1"));
                friendship.setStudentId2(resultSet.getInt("StudentId2"));
                friendships.add(friendship);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return friendships;
    }
}
