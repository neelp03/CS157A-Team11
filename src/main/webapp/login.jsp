<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>UniRide - Login</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<jsp:include page="navbar.jsp" />
<h2>Login to UniRide</h2>

<form action="loginProcessing.jsp" method="post">
    <div>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
    </div>

    <div>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
    </div>

    <div>
        <input type="submit" value="Login">
    </div>
</form>

<p>If you don't have an account, <a href="register.jsp">register here</a>.</p>

</body>
</html>
