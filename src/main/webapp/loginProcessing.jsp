<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Getting form data
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserDAO userDao = new UserDAO();
    // Check credentials
    Users user = userDao.getUserByEmailAndPassword(email, password);

    if (user != null) {
        // Successful login, setting user into session, redirect to dashboard
        session.setAttribute("loggedInUser", user);
        response.sendRedirect("dashboard.jsp");
    } else {
        // Unsuccessful login, setting error message, redirect back to login page
        session.setAttribute("errorMessage", "Invalid email or password!");
        response.sendRedirect("login.jsp");
    }
%>
