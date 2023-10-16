package com.example.models;

import java.util.Objects;

public class Friendship {

    private int friendshipId;
    private int studentId1;
    private int studentId2;

    // Default Constructor
    public Friendship() {}

    // Constructor with all attributes
    public Friendship(int friendshipId, int studentId1, int studentId2) {
        this.friendshipId = friendshipId;
        this.studentId1 = studentId1;
        this.studentId2 = studentId2;
    }

    // Getters and Setters
    public int getFriendshipId() {
        return friendshipId;
    }

    public void setFriendshipId(int friendshipId) {
        this.friendshipId = friendshipId;
    }

    public int getStudentId1() {
        return studentId1;
    }

    public void setStudentId1(int studentId1) {
        this.studentId1 = studentId1;
    }

    public int getStudentId2() {
        return studentId2;
    }

    public void setStudentId2(int studentId2) {
        this.studentId2 = studentId2;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Friendship that = (Friendship) o;
        return friendshipId == that.friendshipId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(friendshipId);
    }

    @Override
    public String toString() {
        return "Friendship{" +
                "friendshipId=" + friendshipId +
                ", studentId1=" + studentId1 +
                ", studentId2=" + studentId2 +
                '}';
    }
}
