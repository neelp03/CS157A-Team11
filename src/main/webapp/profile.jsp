<%@ page import="com.example.models.Users" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<div class="container">

    <!-- Welcome Message -->
    <h2>Welcome, <%= ((Users) session.getAttribute("loggedInUser")).getName() %>!</h2>

    <!-- Change Password Section -->
    <div class="profile-section">
        <h3>Change Password</h3>
        <form action="ChangePasswordProcessing.jsp" method="post">
            <label for="currentPassword">Current Password:</label>
            <input id="currentPassword" type="password" name="currentPassword" required>

            <label for="newPassword">New Password:</label>
            <input id="newPassword" type="password" name="newPassword" required>

            <label for="confirmNewPassword">Confirm New Password:</label>
            <input id="confirmNewPassword" type="password" name="confirmNewPassword" required>

            <input type="submit" value="Change Password">
        </form>
        <%
            String message = (String) session.getAttribute("message");
            if (message != null && !message.isEmpty()) {
        %>
        <div class="alert">
            <%= message %>
        </div>
        <%
                session.removeAttribute("message");
            }
        %>
    </div>

<%--    <!-- Manage Friends Section -->--%>
<%--    <div class="profile-section">--%>
<%--        <h3>Manage Friends</h3>--%>
<%--        <!-- You can link to another page where friends are listed and managed, or embed the friends list here. -->--%>
<%--        <a href="FriendsList.jsp" class="btn">View Friends</a>--%>
<%--        <a href="AddFriend.jsp" class="btn">Add a Friend</a>--%>
<%--    </div>--%>

<%--    <!-- Manage Reviews Section -->--%>
<%--    <div class="profile-section">--%>
<%--        <h3>Manage Reviews</h3>--%>
<%--        <!-- You can link to another page where reviews are listed and managed, or embed the reviews list here. -->--%>
<%--        <a href="ReviewsList.jsp" class="btn">View My Reviews</a>--%>
<%--        <a href="AddReview.jsp" class="btn">Add a Review</a>--%>
<%--    </div>--%>

</div>
</body>
</html>
