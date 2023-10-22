<%@ page import="com.example.models.University" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.UniversityDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>UniRide - Register</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<h2>User Registration</h2>
<form action="registerProcessing.jsp" method="post">
    <div>
        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required>
    </div>

    <div>
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" required>
    </div>

    <div>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
    </div>

    <div>
        <label for="role">Role:</label>
        <select name="role" id="role">
            <option value="Driver">Driver</option>
            <option value="Passenger">Passenger</option>
            <option value="Both">Both</option>
        </select>
    </div>

    <div>
        <label for="university">University:</label>
        <select name="universityId" id="university">
            <%
                UniversityDAO universityDAO = new UniversityDAO();
                List<University> universities = universityDAO.getAllUniversities();
                for (University university : universities) {
            %>
            <option value="<%= university.getUniversityId() %>"><%= university.getName() %></option>
            <%
                }
            %>
        </select>
    </div>

    <input type="submit" value="Register">
</form>
</body>
</html>
