package com.example.dao;

import com.example.models.Review;
import com.example.utils.DatabaseUtility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewsDAO {

    private static final String GET_REVIEW_BY_ID = "SELECT * FROM Reviews WHERE ReviewId = ?";
    private static final String GET_REVIEWS_BY_RIDE_ID = "SELECT * FROM Reviews WHERE RideId = ?";
    private static final String INSERT_REVIEW = "INSERT INTO Reviews (RideId, Feedback, Rating) VALUES (?, ?, ?)";
    private static final String DELETE_REVIEW = "DELETE FROM Reviews WHERE ReviewId = ?";

    public Review getReviewById(int reviewId) {
        Review review = null;

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_REVIEW_BY_ID)) {

            preparedStatement.setInt(1, reviewId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                review = new Review();
                review.setReviewId(resultSet.getInt("ReviewId"));
                review.setRideId(resultSet.getInt("RideId"));
                review.setFeedback(resultSet.getString("Feedback"));
                review.setRating(resultSet.getInt("Rating"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return review;
    }

    public List<Review> getReviewsByRideId(int rideId) {
        List<Review> reviewsList = new ArrayList<>();

        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(GET_REVIEWS_BY_RIDE_ID)) {

            preparedStatement.setInt(1, rideId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Review review = new Review();
                review.setReviewId(resultSet.getInt("ReviewId"));
                review.setRideId(resultSet.getInt("RideId"));
                review.setFeedback(resultSet.getString("Feedback"));
                review.setRating(resultSet.getInt("Rating"));
                reviewsList.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviewsList;
    }

    public boolean insertReview(Review review) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_REVIEW)) {

            preparedStatement.setInt(1, review.getRideId());
            preparedStatement.setString(2, review.getFeedback());
            preparedStatement.setInt(3, review.getRating());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean deleteReview(int reviewId) {
        try (Connection connection = DatabaseUtility.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_REVIEW)) {

            preparedStatement.setInt(1, reviewId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
