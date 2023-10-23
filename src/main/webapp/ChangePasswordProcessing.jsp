<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>

<%
    // Get session object
    Users currentUser = (Users) session.getAttribute("loggedInUser");

    // Get form data
    String oldPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmNewPassword");

    String message = ""; // To store any messages (success/error)
    boolean isPasswordChanged = false;

    if (currentUser != null && oldPassword != null && newPassword != null && confirmPassword != null) {
        // Instantiate UserDAO
        UserDAO userDAO = new UserDAO();

        // Verify old password
        if (userDAO.verifyPassword(currentUser.getUserId(), oldPassword)) {

            // Check if new password and confirm password match
            if (newPassword.equals(confirmPassword)) {

                // Change password in the database
                isPasswordChanged = userDAO.changePassword(currentUser.getUserId(), newPassword);

                if (isPasswordChanged) {
                    message = "Password successfully changed!";
                } else {
                    message = "Error occurred. Password not changed.";
                }

            } else {
                message = "New password and confirm password do not match!";
            }
        } else {
            message = "Incorrect old password!";
        }
    } else {
        message = "All fields are required!";
    }

    if (isPasswordChanged) {
%>
<html>
<head>
    <title>Password Change Successful</title>
</head>
<body>
<h2>Password successfully changed!</h2>
<p>You will be logged out shortly...</p>

<script>
    setTimeout(function(){
        window.location.href = "logout.jsp"; // Replace with the path to your logout page
    }, 5000); // 5000 milliseconds = 5 seconds
</script>
</body>
</html>
<% } else {
    // Redirecting back to profile page with a message if password change is unsuccessful
    session.setAttribute("message", message);
    response.sendRedirect("profile.jsp");
} %>
