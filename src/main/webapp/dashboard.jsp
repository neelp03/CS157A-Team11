<%@ page import="com.example.models.Users, com.example.models.Ride, com.example.models.Request" %>
<%@ page import="com.example.dao.RidesDAO, com.example.dao.RequestsDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container">
    <h1>Dashboard</h1>

    <!-- Rides Requested by You -->
    <h2>Rides Requested</h2>
    <%
        Users currentUser = (Users) session.getAttribute("loggedInUser");
        RequestsDAO requestsDAO = new RequestsDAO();
        List<Request> yourRequests = requestsDAO.getRequestsByPassengerId(currentUser.getUserId());
    %>
    <table>
        <tr>
            <th>Ride ID</th>
            <th>Status</th>
        </tr>
        <% for (Request req : yourRequests) { %>
        <tr>
            <td><%= req.getRideId() %></td>
            <td><%= req.getStatus() %></td>
        </tr>
        <% } %>
    </table>

    <!-- Requests Received for Your Rides -->
    <h2>Requests Received</h2>
    <%
        RidesDAO ridesDAO = new RidesDAO();
        List<Ride> yourRides = ridesDAO.getRidesByDriverId(currentUser.getUserId());
        for (Ride ride : yourRides) {
            List<Request> rideRequests = requestsDAO.getRequestsByRideId(ride.getRideId());
    %>
    <h3>Ride ID: <%= ride.getRideId() %></h3>
    <table>
        <tr>
            <th>Request ID</th>
            <th>Passenger ID</th>
            <th>Status</th>
        </tr>
        <% for (Request req : rideRequests) { %>
        <tr>
            <td><%= req.getRequestId() %></td>
            <td><%= req.getPassengerId() %></td>
            <td><%= req.getStatus() %></td>
        </tr>
        <% } %>
    </table>
    <%
        }
    %>
</div>
</body>
</html>
