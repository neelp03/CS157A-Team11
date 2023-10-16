package com.example.models;

import java.util.Objects;

public class Review {

    private int reviewId;
    private int rideId;
    private String feedback;
    private int rating;

    // Default Constructor
    public Review() {}

    // Constructor with all attributes
    public Review(int reviewId, int rideId, String feedback, int rating) {
        this.reviewId = reviewId;
        this.rideId = rideId;
        this.feedback = feedback;
        this.rating = rating;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getRideId() {
        return rideId;
    }

    public void setRideId(int rideId) {
        this.rideId = rideId;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    // equals(), hashCode() and toString() methods

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Review review = (Review) o;
        return reviewId == review.reviewId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(reviewId);
    }

    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", rideId=" + rideId +
                ", feedback='" + feedback + '\'' +
                ", rating=" + rating +
                '}';
    }
}
