<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.models.Ride" %>
<%@ page import="com.example.dao.RidesDAO" %>
<%@ page import="com.example.dao.UniversityDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Request" %>
<%@ page import="com.example.dao.RequestsDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rides</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css"></head>
<body>
<jsp:include page="navbar.jsp" />
<!-- Welcome Message -->
<h1>UniRide - Rides</h1>

<!-- Search Bar -->
<form action="rides.jsp" method="GET">
    <label for="searchQuery">Search For Rides (by location or time):</label>
    <input type="text" id="searchQuery" name="searchQuery" required>
    <input type="submit" value="Search">
</form>

<!-- Display Search Results -->
<%
    String searchQuery = request.getParameter("searchQuery");
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        RidesDAO ridesDao = new RidesDAO();
        List<Ride> ridesList = ridesDao.searchRidesByLocationOrTime(searchQuery);
%>

<h2>Search Results:</h2>
<table border="1" class="rides-table">
    <thead>
    <tr>
        <th>Driver Name</th>
        <th>Time</th>
        <th>Pickup Location</th>
        <th>Dropoff Location</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        String action = request.getParameter("action");
        String alertMessage = null; // Initialize a variable for alert message

        if ("requestRide".equals(action)) {
            int rideId = Integer.parseInt(request.getParameter("rideId"));
            int passengerId = ((Users) session.getAttribute("loggedInUser")).getUserId(); // Assuming you store the logged-in user in the session

            Request newRequest = new Request();
            newRequest.setRideId(rideId);
            newRequest.setPassengerId(passengerId);
            newRequest.setStatus("Requested"); // Set the initial status, adjust as per your system's design

            boolean isRequested = new RequestsDAO().insertRequest(newRequest);
            if (isRequested) {
                alertMessage = "Ride requested successfully!";
            } else {
                alertMessage = "Failed to request ride.";
            }
        }
    %>
    <% if (alertMessage != null) { %>
    <script>
        alert("<%= alertMessage %>");
    </script>
    <% } %>

    <% for (Ride ride : ridesList) { %>
    <tr>
        <td><%= ride.getDriverName() %></td>
        <td><%= ride.getTime() %></td>
        <td><%= ride.getPickupLocation() %></td>
        <td><%= ride.getDropoffLocation() %></td>
        <td>
            <!-- Button to request a ride -->
            <form action="rides.jsp" method="post">
                <input type="hidden" name="rideId" value="<%= ride.getRideId() %>">
                <input type="hidden" name="action" value="requestRide">
                <input type="submit" value="Request Ride">
            </form>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<% } %>

</body>
</html>
