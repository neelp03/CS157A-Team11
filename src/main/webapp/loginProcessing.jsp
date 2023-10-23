<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserDAO userDao = new UserDAO();
    Users user = userDao.getUserByEmailAndPassword(email, password);

    if (user != null) {
        session.setAttribute("loggedInUser", user);
        response.sendRedirect("dashboard.jsp");
    } else {
        session.setAttribute("errorMessage", "Invalid email or password!");
        response.sendRedirect("login.jsp");
    }
%>
