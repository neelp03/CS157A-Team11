<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>

<%
    Users currentUser = (Users) session.getAttribute("loggedInUser");

    String oldPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmNewPassword");

    String message = ""; // To store any messages (success/error)
    boolean isPasswordChanged = false;

    if (currentUser != null && oldPassword != null && newPassword != null && confirmPassword != null) {
        UserDAO userDAO = new UserDAO();
        if (userDAO.verifyPassword(currentUser.getUserId(), oldPassword)) {
            if (newPassword.equals(confirmPassword)) {
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
        window.location.href = "logout.jsp";
    }, 5000);
</script>
</body>
</html>
<% } else {
    session.setAttribute("message", message);
    response.sendRedirect("profile.jsp");
} %>
