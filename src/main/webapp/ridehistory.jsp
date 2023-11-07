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
            RideHistoryDAO rideHistoryDAO = new RideHistoryDAO();
            List<RideHistory> rideHistoryList = rideHistoryDAO.getRideHistoryByUserId(((Users) session.getAttribute("loggedInUser")).getUserId());
        %>

        <table class="dashboard-table">
            <thead>
            <tr>
                <th>Ride Type</th>
                <th>Ride Date</th>
            </tr>
            </thead>
            <tbody>
            <% if (rideHistoryList != null && !rideHistoryList.isEmpty()) { %>
            <% for (RideHistory rideHistory : rideHistoryList) { %>
            <tr>
                <td><%= rideHistory.getType() %></td>
                <td><%= rideHistory.getDate() %></td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="2">No ride history available.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>

