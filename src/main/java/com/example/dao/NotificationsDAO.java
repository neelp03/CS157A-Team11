package com.example.dao;

import com.example.models.Notification;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotificationsDAO {

    private static final String GET_NOTIFICATION_BY_ID = "SELECT * FROM Notifications WHERE NotifId = ?";
    private static final String GET_NOTIFICATIONS_BY_RECEIVER_ID = "SELECT * FROM Notifications WHERE ReceiverId = ?";
    private static final String INSERT_NOTIFICATION = "INSERT INTO Notifications (RideId, ReceiverId, SenderId, Message, NotificationType) VALUES (?, ?, ?, ?, ?)";
    private static final String DELETE_NOTIFICATION = "DELETE FROM Notifications WHERE NotifId = ?";

    public Notification getNotificationById(int notifId) {
        Notification notification = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_NOTIFICATION_BY_ID)) {

            preparedStatement.setInt(1, notifId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                notification = new Notification();
                notification.setNotifId(resultSet.getInt("NotifId"));
                notification.setRideId(resultSet.getInt("RideId"));
                notification.setReceiverId(resultSet.getInt("ReceiverId"));
                notification.setSenderId(resultSet.getInt("SenderId"));
                notification.setMessage(resultSet.getString("Message"));
                notification.setNotificationType(resultSet.getString("NotificationType"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notification;
    }

    public List<Notification> getNotificationsByReceiverId(int receiverId) {
        List<Notification> notificationsList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_NOTIFICATIONS_BY_RECEIVER_ID)) {

            preparedStatement.setInt(1, receiverId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Notification notification = new Notification();
                notification.setNotifId(resultSet.getInt("NotifId"));
                notification.setRideId(resultSet.getInt("RideId"));
                notification.setReceiverId(resultSet.getInt("ReceiverId"));
                notification.setSenderId(resultSet.getInt("SenderId"));
                notification.setMessage(resultSet.getString("Message"));
                notification.setNotificationType(resultSet.getString("NotificationType"));
                notificationsList.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notificationsList;
    }

    public boolean insertNotification(Notification notification) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_NOTIFICATION)) {

            preparedStatement.setInt(1, notification.getRideId());
            preparedStatement.setInt(2, notification.getReceiverId());
            preparedStatement.setInt(3, notification.getSenderId());
            preparedStatement.setString(4, notification.getMessage());
            preparedStatement.setString(5, notification.getNotificationType());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteNotification(int notifId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_NOTIFICATION)) {

            preparedStatement.setInt(1, notifId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
