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
                    <th style="text-align: center">Actions</th>
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
                                <label>
                                    <input type="text" name="newPrefValue" value="<%= pref.getPrefValue() %>">
                                </label>
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

    <%
        String vehicleAction = request.getParameter("vehicleAction");
        VehicleDAO vehicleDAO = new VehicleDAO();
        if ("addVehicle".equals(vehicleAction)) {
            String make = request.getParameter("make");
            String model = request.getParameter("model");
            String color = request.getParameter("color");
            String licensePlate = request.getParameter("licensePlate");

            if (make != null && model != null && color != null && licensePlate != null) {
                try {
                    Vehicle newVehicle = new Vehicle();
                    assert currentUser != null;
                    newVehicle.setUserId(currentUser.getUserId()); // assuming the Vehicle object has a userId field
                    newVehicle.setManufacturer(make);
                    newVehicle.setModel(model);
                    newVehicle.setLicensePlate(licensePlate);
                    newVehicle.setColor(color);
                    vehicleDAO.insertVehicle(newVehicle);
                    feedbackMessage = "Vehicle added successfully!";
                }  catch (Exception e) {
                    feedbackMessage = "An error occurred while adding the vehicle: " + e.getMessage();
                }
            } else {
                feedbackMessage = "All fields are required.";
            }
        }
        if ("deleteVehicle".equals(vehicleAction)) {
            String licensePlate = request.getParameter("licensePlate");

            if (licensePlate != null) {
                boolean isDeleted = vehicleDAO.deleteVehicle(licensePlate);
                feedbackMessage = isDeleted ? "Vehicle deleted successfully!" : "Error occurred while deleting the vehicle.";
            } else {
                feedbackMessage = "License Plate is required.";
            }
        }

        if ("updateVehicle".equals(vehicleAction)) {
            String originalLicensePlate = request.getParameter("originalLicensePlate");
            String newLicensePlate = request.getParameter("licensePlate");
            String make = request.getParameter("make");
            String model = request.getParameter("model");
            String color = request.getParameter("color");

            if (originalLicensePlate != null && newLicensePlate != null && make != null && model != null && color != null) {
                Vehicle vehicleToUpdate = vehicleDAO.getVehicleByLicense(originalLicensePlate);
                if (vehicleToUpdate != null) {
                    vehicleToUpdate.setLicensePlate(newLicensePlate);
                    vehicleToUpdate.setManufacturer(make);
                    vehicleToUpdate.setModel(model);
                    vehicleToUpdate.setColor(color);

                    boolean updateSuccess = vehicleDAO.updateVehicle(vehicleToUpdate);
                    feedbackMessage = updateSuccess ? "Vehicle updated successfully!" : "Error occurred while updating the vehicle.";
                } else {
                    feedbackMessage = "Vehicle not found.";
                }
            } else {
                feedbackMessage = "All fields are required.";
            }
        }
    %>


    <div class="profile-section">
        <h2>Your Vehicles</h2>
        <%-- Display Vehicle Management Interface --%>
        <%
            assert currentUser != null;
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
                <th>Color</th>
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
                    <div class="action-container">
                        <button onclick="showEditVehicleForm('<%= vehicle.getLicensePlate() %>')" class="action-btn">Edit</button>
                        <form class="action-form-inline" action="profile.jsp?vehicleAction=deleteVehicle" method="post">
                            <input type="hidden" name="licensePlate" value="<%= vehicle.getLicensePlate() %>">
                            <input type="submit" value="Delete" class="action-btn">
                        </form>
                    </div>
                    <div id="editVehicleForm_<%= vehicle.getLicensePlate() %>" style="display:none;">
                        <form action="profile.jsp?vehicleAction=updateVehicle" method="post">
                            <input type="hidden" name="originalLicensePlate" value="<%= vehicle.getLicensePlate() %>">

                            <label for="make_<%= vehicle.getLicensePlate() %>">Make:</label>
                            <input type="text" id="make_<%= vehicle.getLicensePlate() %>" name="make" value="<%= vehicle.getManufacturer() %>">

                            <label for="model_<%= vehicle.getLicensePlate() %>">Model:</label>
                            <input type="text" id="model_<%= vehicle.getLicensePlate() %>" name="model" value="<%= vehicle.getModel() %>">

                            <label for="color_<%= vehicle.getLicensePlate() %>">Color:</label>
                            <input type="text" id="color_<%= vehicle.getLicensePlate() %>" name="color" value="<%= vehicle.getColor() %>">

                            <label for="licensePlate_<%= vehicle.getLicensePlate() %>">License Plate:</label>
                            <input type="text" id="licensePlate_<%= vehicle.getLicensePlate() %>" name="licensePlate" value="<%= vehicle.getLicensePlate() %>">

                            <input type="submit" value="Save">
                        </form>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <script>
            function showEditVehicleForm(licensePlate) {
                var editForm = document.getElementById('editVehicleForm_' + licensePlate);
                var displayStatus = editForm.style.display;
                editForm.style.display = displayStatus === 'none' ? 'block' : 'none';
            }
        </script>

    <%-- Form to Add New Vehicle --%>
        <form action="profile.jsp?vehicleAction=addVehicle" method="post">
            <label for="licensePlate">License Plate:</label>
            <input type="text" id="licensePlate" name="licensePlate">
            <label for="make">Manufacturer:</label>
            <input type="text" id="make" name="make">
            <label for="model">Model:</label>
            <input type="text" id="model" name="model">
            <label for="color">Color:</label>
            <input type="text" id="color" name="color">
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

    <div class="profile-section">
        <h3>Ride History</h3>
        <a href="ridehistory.jsp" class="btn">View Ride History</a>
    </div>
</div>
</body>
</html>
