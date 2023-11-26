<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO, com.example.dao.UniversityDAO, com.example.dao.FriendshipDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Users currentUser = (Users) session.getAttribute("loggedInUser");
    UserDAO userDao = new UserDAO();
    UniversityDAO universityDao = new UniversityDAO();
    FriendshipDAO friendshipDao = new FriendshipDAO();
    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("addFriendUserId") != null) {
        int friendUserId = Integer.parseInt(request.getParameter("addFriendUserId"));
        boolean isRequestSent = friendshipDao.sendFriendRequest(currentUser.getUserId(), friendUserId);
        message = isRequestSent ? "Friend request sent successfully!" : "Failed to send friend request.";
    }

    String searchQuery = request.getParameter("searchQuery");
    List<Users> usersList = null;
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        usersList = userDao.searchUsersByNameOrEmail(searchQuery);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Users</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<h1>UniRide - Search Users</h1>

<% if (message != null) { %>
<p><%= message %></p>
<% } %>

<!-- Search Bar -->
<form action="search.jsp" method="GET">
    <label for="searchQuery">Search Users (by name or email):</label>
    <input type="text" id="searchQuery" name="searchQuery" required>
    <input type="submit" value="Search">
</form>

<!-- Display Search Results -->
<% if (usersList != null) { %>
<h2>Search Results:</h2>
<table border="1" class="dashboard-table">
    <thead>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>University Name</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <% for (Users user : usersList) { %>
    <tr>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>
        <td><%= universityDao.getUniversityNameById(user.getUniversityId()) %></td>
        <td>
            <% if (!user.equals(currentUser)) { %>
            <form action="search.jsp" method="post">
                <input type="hidden" name="addFriendUserId" value="<%= user.getUserId() %>">
                <input type="submit" value="Add Friend">
            </form>
            <% } else { %>
            <span>Self</span>
            <% } %>
        </td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } %>

</body>
</html>
