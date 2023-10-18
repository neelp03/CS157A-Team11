<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Confirmation</title>
</head>
<body>

<%
    // Collect data from form
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    int universityId = Integer.parseInt(request.getParameter("universityId"));

    // Create User object
    Users user = new Users();
    user.setEmail(email);
    user.setName(name);
    user.setPassword(password);
    user.setRole(role);
    user.setUniversityId(universityId);

    // Use DAO to insert user
    UserDAO userDAO = new UserDAO();
    boolean success = userDAO.insertUser(user);

    if (success) {
%>
<h2>Registration Successful</h2>
<p>Welcome <%= name %>! You have been successfully registered.</p>
<a href="login.jsp">Go to login</a>
<%
} else {
%>
<h2>Registration Failed</h2>
<p>Sorry, there was an issue processing your registration. Please try again later.</p>
<a href="register.jsp">Go back to registration</a>
<%
    }
%>

</body>
</html>
