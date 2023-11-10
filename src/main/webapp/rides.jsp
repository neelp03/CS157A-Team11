<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.models.Ride" %>
<%@ page import="com.example.dao.RidesDAO" %>
<%@ page import="com.example.dao.UniversityDAO" %>
<%@ page import="java.util.List" %>

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
        <th>Ride ID</th>
        <th>Driver ID</th>
        <th>Driver Name</th>
        <th>Time</th>
        <th>Pickup Location</th>
        <th>Dropoff Location</th>
    </tr>
    </thead>
    <tbody>
    <% for (Ride ride : ridesList) { %>
    <tr>
        <td><%= ride.getRideId() %></td>
        <td><%= ride.getDriverId() %></td>
        <td><%= ride.getDriverName() %></td>
        <td><%= ride.getTime() %></td>
        <td><%= ride.getPickupLocation() %></td>
        <td><%= ride.getDropoffLocation() %></td>

    </tr>
    <% } %>
    </tbody>
</table>

<% } %>

</body>
</html>
