package com.example.models;

import java.util.Objects;
import java.sql.Time;

public class Ride {

    private int rideId;
    private int driverId;
    private Time time;
    private String pickupLocation;
    private String dropoffLocation;
    private String status;

    // Default Constructor
    public Ride() {}

    // Constructor with all attributes
    public Ride(int rideId, int driverId, Time time, String pickupLocation, String dropoffLocation, String status) {
        this.rideId = rideId;
        this.driverId = driverId;
        this.time = time;
        this.pickupLocation = pickupLocation;
        this.dropoffLocation = dropoffLocation;
        this.status = status;
    }

    // Getters and Setters
    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Ride ride = (Ride) o;
        return rideId == ride.rideId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(rideId);
    }

    @Override
    public String toString() {
        return "Ride{" +
                "rideId=" + rideId +
                ", driverId=" + driverId +
                ", time=" + time +
                ", pickupLocation='" + pickupLocation + '\'' +
                ", dropoffLocation='" + dropoffLocation + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
