package com.example.models;

import java.util.Date;

public class RideHistory {

    private int rideHistoryId;
    private int userId;
    private int rideId;
    private String type; // "offered" or "taken"
    private Date date;
    private String pickupLocation; // Add pickup location
    private String dropoffLocation; // Add dropoff location

    // Constructors, getters, and setters

    public RideHistory() {}

    public RideHistory(int rideHistoryId, int userId, int rideId, String type, Date date,
                       String pickupLocation, String dropoffLocation) {
        this.rideHistoryId = rideHistoryId;
        this.userId = userId;
        this.rideId = rideId;
        this.type = type;
        this.date = date;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDropoffLocation() {
        return dropoffLocation;
    }

    public void setDropoffLocation(String dropoffLocation) {
        this.dropoffLocation = dropoffLocation;
    }
}
