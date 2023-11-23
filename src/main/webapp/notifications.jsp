<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page import="com.example.models.Notification" %>
<%@ page import="com.example.dao.NotificationsDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Notifications</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<div class="container">
    <%
        Users loggedUser = (Users) session.getAttribute("loggedInUser");
        if(loggedUser != null){
            NotificationsDAO notificationsDAO = new NotificationsDAO();
            UserDAO usersDAO = new UserDAO();
            List<Notification> notificationsList = notificationsDAO.getNotificationsByReceiverId(((Users) session.getAttribute("loggedInUser")).getUserId());

            for (Notification notification : notificationsList) {
                Users sender = usersDAO.getUserByID(notification.getSenderId());
    %>
    <!-- Notifications Table -->
    <h2>Your Notifications</h2>

    <table class="dashboard-table">
        <thead>
        <tr>
            <th>Ride ID</th>
            <th>Sender Name</th>
            <th>Notification Type</th>
            <th>Message</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><%= notification.getRideId() %></td>
            <td><%= sender.getName() %></td> <!-- Assuming there's a getName() method in your Users class -->
            <td><%= notification.getNotificationType() %></td>
            <td><%= notification.getMessage() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<% } else { %>
    <p>User not logged in</p>
<% } %>
</body>
</html>
