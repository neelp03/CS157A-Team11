<%@ page import="com.example.models.Users" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<div class="navbar">
    <ul>
        <li><a href="home.jsp">Home</a></li>

        <%
            Users loggedInUser = (Users) session.getAttribute("loggedInUser");
        %>

        <% if (loggedInUser == null) { %>
        <li><a href="register.jsp">Register</a></li>
        <li><a href="login.jsp">Login</a></li>
        <% }
        else { %>
        <li class="welcome-message">Welcome, <%= loggedInUser.getName() %>!</li>
        <li><a href="dashboard.jsp">Rides</a></li>
        <li><a href="rides.jsp">Rides</a></li>
        <li><a href="search.jsp">Search</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li><a href="logout.jsp">Logout</a></li>
        <% } %>
    </ul>
</div>

</body>
</html>
