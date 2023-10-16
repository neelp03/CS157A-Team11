package com.example.models;

import java.util.Objects;

public class Request {

    private int requestId;
    private int rideId;
    private int passengerId;
    private String status;

    // Default Constructor
    public Request() {}

    // Constructor with all attributes
    public Request(int requestId, int rideId, int passengerId, String status) {
        this.requestId = requestId;
        this.rideId = rideId;
        this.passengerId = passengerId;
        this.status = status;
    }

    // Getters and Setters
    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public int getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(int passengerId) {
        this.passengerId = passengerId;
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
        Request request = (Request) o;
        return requestId == request.requestId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(requestId);
    }

    @Override
    public String toString() {
        return "Request{" +
                "requestId=" + requestId +
                ", rideId=" + rideId +
                ", passengerId=" + passengerId +
                ", status='" + status + '\'' +
                '}';
    }
}
