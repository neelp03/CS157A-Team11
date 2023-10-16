package com.example.models;

import java.util.Objects;

public class University {

    private int universityId;
    private String name;
    private String address;

    // Default Constructor
    public University() {}

    // Constructor with all attributes
    public University(int universityId, String name, String address) {
        this.universityId = universityId;
        this.name = name;
        this.address = address;
    }

    // Getters and Setters
    public int getUniversityId() {
        return universityId;
    }

    public void setUniversityId(int universityId) {
        this.universityId = universityId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        University that = (University) o;
        return universityId == that.universityId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(universityId);
    }

    @Override
    public String toString() {
        return "University{" +
                "universityId=" + universityId +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
