<%@ page import="com.example.models.Users" %>
<%@ page import="com.example.models.Friendship" %>
<%@ page import="com.example.dao.UserDAO" %>
<%@ page import="com.example.dao.FriendshipDAO" %>
<%@ page import="com.example.models.UserPreferences" %>
<%@ page import="com.example.dao.UserPreferencesDAO" %>
<%@ page import="com.example.dao.VehicleDAO" %>
<%@ page import="com.example.models.Vehicle" %>
<%@ page import="java.util.List" %>
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

    <%-- Fetching and Setting Necessary Data --%>
    <%
        Users currentUser = (Users) session.getAttribute("loggedInUser");
        String preferenceAction = request.getParameter("preferenceAction");
        String preferenceIdStr = request.getParameter("preferenceId");
        int preferenceId = 0;

        if (preferenceIdStr != null) {
            try {
                preferenceId = Integer.parseInt(preferenceIdStr);
            } catch (NumberFormatException e) {
                // Log the error, can be improved with proper logging tools
            }
        }

        UserPreferencesDAO preferencesDAO = new UserPreferencesDAO();
        String feedbackMessage = null;  // Message to inform user about success or failure of their actions.

        if (preferenceAction != null && currentUser != null) {
            try {
                switch (preferenceAction) {
                    case "addPreference":
                        String prefName = request.getParameter("prefName");
                        String prefValue = request.getParameter("prefValue");
                        UserPreferences newPreference = new UserPreferences();
                        newPreference.setUserId(currentUser.getUserId());
                        newPreference.setPrefName(prefName);
                        newPreference.setPrefValue(prefValue);
                        preferencesDAO.insertPreference(newPreference);
                        feedbackMessage = "Preference added successfully!";
                        break;

                    case "editPreference":
                        String newPrefValue = request.getParameter("newPrefValue");
                        String prefNameForEdit = request.getParameter("prefName");
                        if (prefNameForEdit != null) {
                            UserPreferences editPreference = new UserPreferences();
                            editPreference.setUserId(currentUser.getUserId());
                            editPreference.setPrefName(prefNameForEdit);
                            editPreference.setPrefValue(newPrefValue);
                            preferencesDAO.updatePreference(editPreference);
                            feedbackMessage = "Preference updated successfully!";
                        } else {
                            feedbackMessage = "Error fetching preference name for editing.";
                        }
                        break;

                    case "deletePreference":
                        preferencesDAO.deletePreference(preferenceId);
                        feedbackMessage = "Preference deleted successfully!";
                        break;

                    default:
                        feedbackMessage = "Invalid action specified.";
                }
            } catch (Exception e) {
                feedbackMessage = "An error occurred: " + e.getMessage();
                // Log the error, can be improved with proper logging tools.
            }
        }
    %>

    <%-- Display Section --%>
    <div class="profile-section">
        <div class="container">
            <h2>Your Preferences</h2>
            <% if (currentUser != null) { %>
            <%-- Display feedback message if available --%>
            <% if (feedbackMessage != null) { %>
            <p><%= feedbackMessage %></p>
            <% } %>

            <%-- Fetch user preferences from the database --%>
            <%
                UserPreferencesDAO userPreferencesDAO = new UserPreferencesDAO();
                List<UserPreferences> preferences = userPreferencesDAO.getPreferencesByUserId(currentUser.getUserId());
            %>

            <%-- Display user preferences in a table format --%>
            <table class="dashboard-table">
                <thead>
                <tr>
                    <th>Preference Name</th>
                    <th>Preference Value</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <% if (preferences != null && !preferences.isEmpty()) { %>
                <% for (UserPreferences pref : preferences) { %>
                <tr>
                    <td>
                        <span id="prefNameDisplay_<%= pref.getPreferenceId() %>"><%= pref.getPrefName() %></span>
                    </td>
                    <td>
                        <span id="prefValueDisplay_<%= pref.getPreferenceId() %>"><%= pref.getPrefValue() %></span>
                        <div class="action-container" id="editForm_<%= pref.getPreferenceId() %>" style="display:none;">
                            <form class="action-form" action="profile.jsp?preferenceAction=editPreference&preferenceId=<%= pref.getPreferenceId() %>" method="post">
                                <input type="hidden" name="prefName" value="<%= pref.getPrefName() %>">
                                <input type="text" name="newPrefValue" value="<%= pref.getPrefValue() %>">
                                <input type="submit" value="Save" class="action-btn">
                            </form>
                        </div>
                    </td>
                    <td>
                        <div class="action-container">
                            <button onclick="showEditForm('<%= pref.getPreferenceId() %>')" class="action-btn">Edit</button>
                            <form class="action-form-inline" action="profile.jsp?preferenceAction=deletePreference" method="post">
                                <input type="hidden" name="preferenceId" value="<%= pref.getPreferenceId() %>">
                                <input type="submit" value="Delete" class="action-btn">
                            </form>
                        </div>
                    </td>
                </tr>
                <% } %>
                <% } else { %>
                <tr>
                    <td colspan="3">You don't have any preferences set yet.</td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <%-- Form to add new user preferences --%>
            <form class="prefAddForm" action="profile.jsp?preferenceAction=addPreference" method="post">
                <label for="prefName">Preference Name:</label>
                <input type="text" id="prefName" name="prefName">
                <label for="prefValue">Preference Value:</label>
                <input type="text" id="prefValue" name="prefValue">
                <input type="submit" value="Add Preference">
            </form>

            <%-- JavaScript function to toggle the edit form visibility --%>
            <script>
                function showEditForm(preferenceId) {
                    let isEditing = document.getElementById('editForm_' + preferenceId).style.display == 'block';

                    document.getElementById('editForm_' + preferenceId).style.display = isEditing ? 'none' : 'block';
                    document.getElementById('prefValueDisplay_' + preferenceId).style.display = isEditing ? 'block' : 'none';
                }
            </script>

            <% } else { %>
            <p>Please log in to view your preferences.</p>
            <% } %>
        </div>
    </div>
    <div class="profile-section">
        <h2>Your Vehicles</h2>
        <%-- Display Vehicle Management Interface --%>
        <%
            VehicleDAO vehicleDAO = new VehicleDAO();
            List<Vehicle> vehicles = vehicleDAO.getVehiclesByUserId(currentUser.getUserId());
        %>

        <%-- Display feedback message if available --%>
        <% if (feedbackMessage != null) { %>
        <p><%= feedbackMessage %></p>
        <% } %>

        <%-- List User Vehicles --%>
        <table class="dashboard-table">
            <thead>
            <tr>
                <th>Make</th>
                <th>Model</th>
                <th>Year</th>
                <th>License Plate</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Vehicle vehicle : vehicles) { %>
            <tr>
                <td><%= vehicle.getManufacturer() %></td>
                <td><%= vehicle.getModel() %></td>
                <td><%= vehicle.getColor() %></td>
                <td><%= vehicle.getLicensePlate() %></td>
                <td>
                    <!-- Actions like Edit and Delete -->
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <%-- Form to Add New Vehicle --%>
        <form action="profile.jsp?vehicleAction=addVehicle" method="post">
            <label for="make">Make:</label>
            <input type="text" id="make" name="make">
            <label for="model">Model:</label>
            <input type="text" id="model" name="model">
            <label for="year">Year:</label>
            <input type="text" id="year" name="year">
            <label for="licensePlate">License Plate:</label>
            <input type="text" id="licensePlate" name="licensePlate">
            <input type="submit" value="Add Vehicle">
        </form>
    </div>

    <!-- Manage Friends Section -->
    <div class="profile-section">
        <div class="container">
            <h2>Your Friends</h2>
            <div class="container">
                <h2>Your Friends</h2>

                <%
                    String friendshipAction = request.getParameter("friendshipAction");
                    String friendshipIdStr = request.getParameter("friendshipId");
                    message = "";

                    if ("unfriend".equals(friendshipAction) && friendshipIdStr != null) {
                        int friendshipId = Integer.parseInt(friendshipIdStr);
                        FriendshipDAO friendshipDAO = new FriendshipDAO();
                        boolean isDeleted = friendshipDAO.deleteFriendship(friendshipId);

                        if (isDeleted) {
                            message = "Successfully unfriended!";
                        } else {
                            message = "Error occurred while unfriending.";
                        }
                    }

                    if (currentUser != null) {
                        FriendshipDAO friendshipDAO = new FriendshipDAO();
                        UserDAO userDAO = new UserDAO();
                        List<Friendship> friendships = friendshipDAO.getFriendsOfStudent(currentUser.getUserId());

                        if (friendships != null && !friendships.isEmpty()) {
                %>

                <p><%= message %></p>

                <table class="dashboard-table">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Friendship friendship : friendships) {
                        int friendId = (friendship.getStudentId1() == currentUser.getUserId()) ?
                                friendship.getStudentId2() : friendship.getStudentId1();
                        Users friend = userDAO.getUserByID(friendId);
                    %>
                    <tr>
                        <td><%= friend.getName() %></td>
                        <td><%= friend.getEmail() %></td>
                        <td>
                            <a href="profile.jsp?friendshipAction=unfriend&friendshipId=<%= friendship.getFriendshipId() %>">Unfriend</a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p>You don't have any friends yet. Start adding!</p>
                <%
                    }
                } else {
                %>
                <p>Please log in to view your friends.</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Manage Reviews Section -->
    <div class="profile-section">
        <h3>Manage Reviews</h3>
        <!-- You can link to another page where reviews are listed and managed, or embed the reviews list here. -->
        <a href="ReviewsList.jsp" class="btn">View My Reviews</a>
    </div>
</div>
</body>
</html>
