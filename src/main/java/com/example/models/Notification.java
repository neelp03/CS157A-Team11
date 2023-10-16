package com.example.models;

import java.util.Objects;

public class Notification {

    private int notifId;
    private int rideId;
    private int receiverId;
    private int senderId;
    private String message;
    private String notificationType;

    // Default Constructor
    public Notification() {}

    // Constructor with all attributes
    public Notification(int notifId, int rideId, int receiverId, int senderId, String message, String notificationType) {
        this.notifId = notifId;
        this.rideId = rideId;
        this.receiverId = receiverId;
        this.senderId = senderId;
        this.message = message;
        this.notificationType = notificationType;
    }

    // Getters and Setters
    public int getNotifId() {
        return notifId;
    }

    public void setNotifId(int notifId) {
        this.notifId = notifId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Notification that = (Notification) o;
        return notifId == that.notifId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(notifId);
    }

    @Override
    public String toString() {
        return "Notification{" +
                "notifId=" + notifId +
                ", rideId=" + rideId +
                ", receiverId=" + receiverId +
                ", senderId=" + senderId +
                ", message='" + message + '\'' +
                ", notificationType='" + notificationType + '\'' +
                '}';
    }
}
