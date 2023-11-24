<%@ page import="com.example.models.Users" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

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
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="rides.jsp">Rides</a></li>
        <li><a href="search.jsp">Search</a></li>
        <li><a href="profile.jsp">Profile</a></li>
        <li><a href="logout.jsp">Logout</a></li>

        <li class="welcome-message">Welcome, <%= loggedInUser.getName() %>!</li>
        <li class="notification-icon" id="notificationIcon">
            <a href="notifications.jsp"><i class="fa fa-bell"></i></a>
            <span id="notificationCount"></span>
        </li>
        <% } %>
    </ul>
</div>

</body>
</html>