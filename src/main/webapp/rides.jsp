<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.models.Ride" %>
<%@ page import="com.example.dao.RidesDAO" %>
<%@ page import="com.example.dao.RequestsDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.models.Request" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rides</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<h1>UniRide - Rides</h1>

<form action="rides.jsp" method="GET">
    <label for="searchQuery">Search For Rides (by location or time):</label>
    <input type="text" id="searchQuery" name="searchQuery" required>
    <input type="submit" value="Search">
</form>

<%
    String action = request.getParameter("action");
    String alertMessage = null; // Initialize a variable for alert message
    Users currentUser = (Users) session.getAttribute("loggedInUser");

    if ("requestRide".equals(action) && currentUser != null) {
        int rideId = Integer.parseInt(request.getParameter("rideId"));
        int passengerId = currentUser.getUserId();

        Request newRequest = new Request();
        newRequest.setRideId(rideId);
        newRequest.setPassengerId(passengerId);
        newRequest.setStatus("Requested");

        RequestsDAO requestsDAO = new RequestsDAO();
        boolean isRequested = requestsDAO.insertRequest(newRequest);
        if (isRequested) {
            alertMessage = "Ride requested successfully!";
        } else {
            alertMessage = "Failed to request ride.";
        }
    }

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
    <% for (Ride ride : ridesList) { %>
    <tr>
        <td><%= ride.getDriverName() %></td>
        <td><%= ride.getTime() %></td>
        <td><%= ride.getPickupLocation() %></td>
        <td><%= ride.getDropoffLocation() %></td>
        <td>
            <% if (currentUser != null && currentUser.getUserId() != ride.getDriverId()) { %>
            <form action="rides.jsp" method="post">
                <input type="hidden" name="rideId" value="<%= ride.getRideId() %>">
                <input type="hidden" name="action" value="requestRide">
                <input type="submit" value="Request Ride">
            </form>
            <% } else { %>
            <span>Cannot request your own ride</span>
            <% } %>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>

<%
    }
    if (alertMessage != null) {
%>
<script type="text/javascript">
    alert("<%= alertMessage %>");
</script>
<%
    }
%>

</body>
</html>
