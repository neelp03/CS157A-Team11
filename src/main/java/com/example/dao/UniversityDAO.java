package com.example.dao;

import com.example.models.University;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UniversityDAO {

    private static final String INSERT_UNIVERSITY_QUERY = "INSERT INTO University(Name, Address) VALUES(?, ?)";
    private static final String SELECT_UNIVERSITY_BY_ID = "SELECT * FROM University WHERE UniversityId = ?";
    private static final String SELECT_ALL_UNIVERSITIES = "SELECT * FROM University";
    private static final String UPDATE_UNIVERSITY = "UPDATE University SET Name = ?, Address = ? WHERE UniversityId = ?";
    private static final String DELETE_UNIVERSITY = "DELETE FROM University WHERE UniversityId = ?";
    private static final String GET_UNIVERSITY_NAME_BY_ID_QUERY = "SELECT Name FROM University WHERE UniversityId = ?";

    public String getUniversityNameById(int id) {
        String universityName = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_UNIVERSITY_NAME_BY_ID_QUERY)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                universityName = resultSet.getString("Name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return universityName;
    }
    public boolean insertUniversity(University university) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_UNIVERSITY_QUERY)) {

            preparedStatement.setString(1, university.getName());
            preparedStatement.setString(2, university.getAddress());

            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public University getUniversityById(int id) {
        University university = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_UNIVERSITY_BY_ID)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("Name");
                String address = resultSet.getString("Address");
                university = new University(id, name, address);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return university;
    }

    // ... existing code ...

    public List<University> getAllUniversities() {
        List<University> universityList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_UNIVERSITIES)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int universityId = rs.getInt("UniversityId");
                String name = rs.getString("Name");
                String address = rs.getString("Address");

                University university = new University(universityId, name, address);
                universityList.add(university);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return universityList;
    }

    public boolean updateUniversity(University university) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_UNIVERSITY)) {

            preparedStatement.setString(1, university.getName());
            preparedStatement.setString(2, university.getAddress());
            preparedStatement.setInt(3, university.getUniversityId());

            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUniversity(int id) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_UNIVERSITY)) {

            preparedStatement.setInt(1, id);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
