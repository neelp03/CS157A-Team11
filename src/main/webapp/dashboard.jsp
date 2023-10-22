<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page import="com.example.dao.UniversityDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css"></head>
<body>
<jsp:include page="navbar.jsp" />
<!-- Welcome Message -->
<h1>UniRide - Dashboard</h1>

<!-- Search Bar -->
<form action="dashboard.jsp" method="GET">
    <label for="searchQuery">Search Users (by name or email):</label>
    <input type="text" id="searchQuery" name="searchQuery" required>
    <input type="submit" value="Search">
</form>

<!-- Display Search Results -->
<%
    String searchQuery = request.getParameter("searchQuery");
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        UserDAO userDao = new UserDAO();
        List<Users> usersList = userDao.searchUsersByNameOrEmail(searchQuery);
%>

<h2>Search Results:</h2>
<table border="1">
    <thead>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>University Name</th>
    </tr>
    </thead>
    <tbody>
    <% for (Users user : usersList) { %>
    <tr>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <%
                UniversityDAO universityDao = new UniversityDAO();
                String universityName = universityDao.getUniversityNameById(user.getUniversityId());
            %>
            <%= universityName %>
        </td>

    </tr>
    <% } %>
    </tbody>
</table>

<% } %>

</body>
</html>
