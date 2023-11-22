<%@ page import="com.example.models.Users, com.example.models.Ride, com.example.models.Request" %>
<%@ page import="com.example.dao.RidesDAO, com.example.dao.RequestsDAO, com.example.dao.UserDAO" %>
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

    <!-- Process Cancel/Decline Request -->
    <%
        String action = request.getParameter("action");
        Users currentUser = (Users) session.getAttribute("loggedInUser");
        RequestsDAO requestsDAO = new RequestsDAO();
        String requestProcessingMessage = null;

        if ("cancelRequest".equals(action) && currentUser != null) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            // Assuming the cancelRequest method updates the status of the request to 'Cancelled'
            boolean isCancelled = requestsDAO.deleteRequest(requestId);
            if (isCancelled) {
                requestProcessingMessage = "Request cancelled successfully.";
            } else {
                requestProcessingMessage = "Failed to cancel the request.";
            }
        }
    %>

    <!-- Display a message after processing -->
    <% if (requestProcessingMessage != null) { %>
    <p><%= requestProcessingMessage %></p>
    <% } %>

    <!-- Rides Requested by You -->
    <h2>Rides Requested</h2>
    <%
        List<Request> yourRequests = requestsDAO.getRequestsByPassengerId(currentUser.getUserId());
    %>
    <table>
        <tr>
            <th>Driver Name</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <% for (Request req : yourRequests) {
            Ride ride = new RidesDAO().getRideById(req.getRideId());
            Users driver = ride != null ? new UserDAO().getUserByID(ride.getDriverId()) : null;
        %>
        <tr>
            <td><%= driver != null ? driver.getName() : "Unknown" %></td>
            <td><%= req.getStatus() %></td>
            <td>
                <form action="dashboard.jsp" method="post">
                    <input type="hidden" name="action" value="cancelRequest">
                    <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                    <input type="submit" value="Cancel Request">
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <!-- Requests Received for Your Rides -->
    <h2>Requests Received for Your Rides</h2>
    <%
        List<Ride> yourRides = new RidesDAO().getRidesByDriverId(currentUser.getUserId());
        String currentLabel = "";
        for (Ride ride : yourRides) {
            String rideLabel = ride.getDate() + " at " + ride.getTime(); // Assuming getDate and getTime methods exist
            if (!rideLabel.equals(currentLabel)) {
                currentLabel = rideLabel;
    %>
    <h3>Rides on <%= ride.getDate() %> at <%= ride.getTime() %>:</h3>
    <%
        }
        List<Request> rideRequests = requestsDAO.getRequestsByRideId(ride.getRideId());
    %>
    <table>
        <tr>
            <th>Passenger Name</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <% for (Request req : rideRequests) {
            Users passenger = new UserDAO().getUserByID(req.getPassengerId());
        %>
        <tr>
            <td><%= passenger != null ? passenger.getName() : "Unknown" %></td>
            <td><%= req.getStatus() %></td>
            <td>
                <form action="dashboard.jsp" method="post">
                    <input type="hidden" name="action" value="cancelRequest">
                    <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                    <input type="submit" value="Decline Request">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <%
        }
    %>
</div>
</body>
</html>
