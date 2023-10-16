package com.example.models;

import java.util.Objects;

public class Vehicle {

    private String licensePlate;
    private int userId;
    private String manufacturer;
    private String model;
    private String color;

    // Default Constructor
    public Vehicle() {}

    // Constructor with all attributes
    public Vehicle(String licensePlate, int userId, String manufacturer, String model, String color) {
        this.licensePlate = licensePlate;
        this.userId = userId;
        this.manufacturer = manufacturer;
        this.model = model;
        this.color = color;
    }

    // Getters and Setters
    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Vehicle vehicle = (Vehicle) o;
        return licensePlate.equals(vehicle.licensePlate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(licensePlate);
    }

    @Override
    public String toString() {
        return "Vehicle{" +
                "licensePlate='" + licensePlate + '\'' +
                ", userId=" + userId +
                ", manufacturer='" + manufacturer + '\'' +
                ", model='" + model + '\'' +
                ", color='" + color + '\'' +
                '}';
    }
}
