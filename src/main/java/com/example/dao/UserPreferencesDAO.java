package com.example.dao;

import com.example.models.UserPreferences;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserPreferencesDAO {

    private static final String GET_PREFERENCES_BY_USER_ID = "SELECT * FROM UserPreferences WHERE UserId = ?";
    private static final String INSERT_PREFERENCE = "INSERT INTO UserPreferences (UserId, Pref_Name, Pref_Value) VALUES (?, ?, ?)";
    private static final String UPDATE_PREFERENCE = "UPDATE UserPreferences SET Pref_Value = ? WHERE UserId = ? AND Pref_Name = ?";
    private static final String DELETE_PREFERENCE = "DELETE FROM UserPreferences ences WHERE PreferenceId = ?";

    public List<UserPreferences> getPreferencesByUserId(int userId) {
        List<UserPreferences> preferencesList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_PREFERENCES_BY_USER_ID)) {

            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                UserPreferences preference = new UserPreferences();
                preference.setPreferenceId(resultSet.getInt("PreferenceId"));
                preference.setUserId(resultSet.getInt("UserId"));
                preference.setPrefName(resultSet.getString("Pref_Name"));
                preference.setPrefValue(resultSet.getString("Pref_Value"));
                preferencesList.add(preference);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return preferencesList;
    }

    public boolean insertPreference(UserPreferences preference) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PREFERENCE)) {

            preparedStatement.setInt(1, preference.getUserId());
            preparedStatement.setString(2, preference.getPrefName());
            preparedStatement.setString(3, preference.getPrefValue());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updatePreference(UserPreferences preference) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PREFERENCE)) {

            preparedStatement.setString(1, preference.getPrefValue());
            preparedStatement.setInt(2, preference.getUserId());
            preparedStatement.setString(3, preference.getPrefName());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deletePreference(int preferenceId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PREFERENCE)) {

            preparedStatement.setInt(1, preferenceId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
