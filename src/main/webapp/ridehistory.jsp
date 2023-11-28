<%@ page import="com.example.models.RideHistory" %>
<%@ page import="com.example.dao.RideHistoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
                <th>Ride Date</th>
                <th>Pickup Location</th>
                <th>Dropoff Location</th>
            </tr>
            </thead>
            <tbody>
            <% if (rideHistoryList != null && !rideHistoryList.isEmpty()) { %>
            <% for (RideHistory rideHistory : rideHistoryList) { %>
            <tr>
                <td><%= rideHistory.getType() %></td>
                <td><%= formatDate(rideHistory.getDate()) %></td>
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

        <%! private String formatDate(Date date) {
            if (date != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                return sdf.format(date);
            }
            return "N/A";
        } %>

    </div>
</div>

</body>
</html>

