package com.example.dao;

import com.example.models.ScheduledRides;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ScheduledRidesDAO {

    private static final String INSERT_SCHEDULE = "INSERT INTO ScheduledRides (RideId, ScheduledDate, ScheduledTime) VALUES (?, ?, ?)";
    private static final String DELETE_SCHEDULE = "DELETE FROM ScheduledRides WHERE ScheduleId = ?";
    private static final String GET_SCHEDULE_BY_ID = "SELECT * FROM ScheduledRides WHERE ScheduleId = ?";
    private static final String GET_SCHEDULES_BY_RIDE_ID = "SELECT * FROM ScheduledRides WHERE RideId = ?";

    public boolean addSchedule(ScheduledRides schedule) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SCHEDULE)) {

            preparedStatement.setInt(1, schedule.getRideId());
            preparedStatement.setDate(2, schedule.getScheduledDate());
            preparedStatement.setTime(3, schedule.getScheduledTime());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteSchedule(int scheduleId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SCHEDULE)) {

            preparedStatement.setInt(1, scheduleId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public ScheduledRides getScheduleById(int scheduleId) {
        ScheduledRides schedule = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_SCHEDULE_BY_ID)) {

            preparedStatement.setInt(1, scheduleId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                schedule = new ScheduledRides();
                schedule.setScheduleId(resultSet.getInt("ScheduleId"));
                schedule.setRideId(resultSet.getInt("RideId"));
                schedule.setScheduledDate(resultSet.getDate("ScheduledDate"));
                schedule.setScheduledTime(resultSet.getTime("ScheduledTime"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedule;
    }

    public List<ScheduledRides> getSchedulesByRideId(int rideId) {
        List<ScheduledRides> schedules = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_SCHEDULES_BY_RIDE_ID)) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                ScheduledRides schedule = new ScheduledRides();
                schedule.setScheduleId(resultSet.getInt("ScheduleId"));
                schedule.setRideId(resultSet.getInt("RideId"));
                schedule.setScheduledDate(resultSet.getDate("ScheduledDate"));
                schedule.setScheduledTime(resultSet.getTime("ScheduledTime"));
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return schedules;
    }
}
