<%
    // Invalidate the session
    session.invalidate();

    // Redirect to login or main page
    response.sendRedirect("login.jsp");
%>
