package com.example.models;

import java.util.Objects;

public class UserPreferences {

    private int preferenceId;
    private int userId;
    private String prefName;
    private String prefValue;

    // Default Constructor
    public UserPreferences() {}

    // Constructor with all attributes
    public UserPreferences(int preferenceId, int userId, String prefName, String prefValue) {
        this.preferenceId = preferenceId;
        this.userId = userId;
        this.prefName = prefName;
        this.prefValue = prefValue;
    }

    // Getters and Setters
    public int getPreferenceId() {
        return preferenceId;
    }

    public void setPreferenceId(int preferenceId) {
        this.preferenceId = preferenceId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPrefName() {
        return prefName;
    }

    public void setPrefName(String prefName) {
        this.prefName = prefName;
    }

    public String getPrefValue() {
        return prefValue;
    }

    public void setPrefValue(String prefValue) {
        this.prefValue = prefValue;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserPreferences that = (UserPreferences) o;
        return preferenceId == that.preferenceId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(preferenceId);
    }

    @Override
    public String toString() {
        return "UserPreferences{" +
                "preferenceId=" + preferenceId +
                ", userId=" + userId +
                ", prefName='" + prefName + '\'' +
                ", prefValue='" + prefValue + '\'' +
                '}';
    }
}
