<%@ page import="com.example.models.RideHistory" %>
<%@ page import="com.example.dao.RideHistoryDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Ride History</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<div class="container">
    <!-- Welcome Message -->
    <h2>Your Ride History</h2>

    <div class="profile-section">
        <%
            Users loggedUser = (Users) session.getAttribute("loggedInUser");
            if (loggedUser != null) {
                RideHistoryDAO rideHistoryDAO = new RideHistoryDAO();
                List<RideHistory> rideHistoryList = rideHistoryDAO.getRideHistoryByUserId(loggedUser.getUserId());
        %>


        <table class="dashboard-table">
            <thead>
            <tr>
                <th>Ride Type</th>
                <th>Ride Time</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
            </tr>
            </thead>
            <tbody>
            <% if (rideHistoryList != null && !rideHistoryList.isEmpty()) { %>
            <% for (RideHistory rideHistory : rideHistoryList) { %>
            <tr>
                <td><%= rideHistory.getType() %></td>
                <td><%= rideHistory.getDate() %></td>
                <td><%= rideHistory.getPickupLocation() %></td>
                <td><%= rideHistory.getDropoffLocation() %></td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="2">No ride history available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>User not logged in</p>
        <% } %>

    </div>
</div>

</body>
</html>

