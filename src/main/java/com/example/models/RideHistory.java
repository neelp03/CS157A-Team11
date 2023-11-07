package com.example.models;

import java.util.Date;

public class RideHistory {

    private int rideHistoryId;
    private int userId;
    private int rideId;
    private String type; // "offered" or "taken"
    private Date date;

    // Constructors, getters, and setters

    public RideHistory() {}

    public RideHistory(int rideHistoryId, int userId, int rideId, String type, Date date) {
        this.rideHistoryId = rideHistoryId;
        this.userId = userId;
        this.rideId = rideId;
        this.type = type;
        this.date = date;
    }

    public int getRideHistoryId() {
        return rideHistoryId;
    }

    public void setRideHistoryId(int rideHistoryId) {
        this.rideHistoryId = rideHistoryId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public java.sql.Date getDate() {
        return (java.sql.Date) date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
