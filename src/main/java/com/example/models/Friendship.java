package com.example.models;

public class Friendship {
    private int friendshipId;
    private int studentId1;
    private int studentId2;
    private String status;

    // Constructors
    public Friendship() {}

    public Friendship(int friendshipId, int studentId1, int studentId2, String status) {
        this.friendshipId = friendshipId;
        this.studentId1 = studentId1;
        this.studentId2 = studentId2;
        this.status = status;
    }

    // Getters and setters
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
