package com.example.models;

import java.sql.Date;
import java.sql.Time;
import java.util.Objects;

public class ScheduledRides {

    private int scheduleId;
    private int rideId;
    private Date scheduledDate;
    private Time scheduledTime;

    // Default constructor
    public ScheduledRides() {}

    // Constructor with all attributes
    public ScheduledRides(int scheduleId, int rideId, Date scheduledDate, Time scheduledTime) {
        this.scheduleId = scheduleId;
        this.rideId = rideId;
        this.scheduledDate = scheduledDate;
        this.scheduledTime = scheduledTime;
    }

    // Getters and Setters
    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public Date getScheduledDate() {
        return scheduledDate;
    }

    public void setScheduledDate(Date scheduledDate) {
        this.scheduledDate = scheduledDate;
    }

    public Time getScheduledTime() {
        return scheduledTime;
    }

    public void setScheduledTime(Time scheduledTime) {
        this.scheduledTime = scheduledTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ScheduledRides that = (ScheduledRides) o;
        return scheduleId == that.scheduleId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(scheduleId);
    }

    @Override
    public String toString() {
        return "ScheduledRides{" +
                "scheduleId=" + scheduleId +
                ", rideId=" + rideId +
                ", scheduledDate=" + scheduledDate +
                ", scheduledTime=" + scheduledTime +
                '}';
    }
}
