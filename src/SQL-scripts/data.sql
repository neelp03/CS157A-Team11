USE UniRide;

-- Inserting universities
INSERT INTO University (Name, Address)
VALUES
    ("San Jose State University", "1 Washington Sq, San Jose, CA 95192"),
    ("Santa Clara University", "500 El Camino Real, Santa Clara, CA 95053"),
    ("De Anza College", "21250 Stevens Creek Blvd, Cupertino, CA 95014");

-- Inserting users
INSERT INTO Users (Email, Name, Password, Role, UniversityId)
VALUES
    ("john.doe@sjsu.edu", "John Doe", "hashedpassword1", "Driver", 1),
    ("mary.smith@scu.edu", "Mary Smith", "hashedpassword2", "Passenger", 2),
    ("alex.jones@deanza.edu", "Alex Jones", "hashedpassword3", "Both", 3),
    ("lucy.white@sjsu.edu", "Lucy White", "hashedpassword4", "Driver", 1),
    ("james.brown@scu.edu", "James Brown", "hashedpassword5", "Passenger", 2),
    ("chris.taylor@sjsu.edu", "Chris Taylor", "hashedpassword6", "Both", 1),
    ("emma.wilson@deanza.edu", "Emma Wilson", "hashedpassword7", "Passenger", 3),
    ("olivia.green@scu.edu", "Olivia Green", "hashedpassword8", "Driver", 2),
    ("sophia.harris@sjsu.edu", "Sophia Harris", "hashedpassword9", "Both", 1),
    ("isabella.jackson@sjsu.edu", "Isabella Jackson", "hashedpassword10", "Passenger", 1);

-- Inserting vehicles
INSERT INTO Vehicle (LicensePlate, UserId, Manufacturer, Model, Color)
VALUES
    ("XYZ123", 1, "Toyota", "Camry", "Blue"),
    ("ABC789", 4, "Honda", "Civic", "Red"),
    ("LMN456", 8, "Ford", "Focus", "Black"),
    ("DEF012", 7, "Chevrolet", "Impala", "Silver"),
    ("GHI345", 3, "Hyundai", "Elantra", "Green");

-- Inserting rides
INSERT INTO Rides (DriverId, Time, PickupLocation, DropoffLocation, Status)
VALUES
    (1, "15:00:00", "Downtown San Jose", "SJSU", "Scheduled"),
    (4, "17:30:00", "SJSU", "Santa Clara", "In Progress"),
    (8, "14:00:00", "Santa Clara University", "De Anza College", "Scheduled"),
    (3, "09:00:00", "De Anza College", "SJSU", "Completed"),
    (7, "12:00:00", "SJSU Library", "De Anza", "In Progress");

-- Inserting requests
INSERT INTO Requests (RideId, PassengerId, Status)
VALUES
    (1, 2, "Accepted"),
    (1, 3, "Pending"),
    (2, 5, "Accepted"),
    (3, 6, "Accepted"),
    (3, 7, "Declined"),
    (4, 10, "Pending"),
    (5, 9, "Accepted");

-- Inserting reviews
INSERT INTO Reviews (RideId, Feedback, Rating)
VALUES
    (1, "Great ride!", 5),
    (2, "Smooth journey, thanks!", 4),
    (3, "Quick and comfortable!", 5),
    (4, "Driver was late.", 3),
    (5, "Pleasant trip.", 4);

-- Inserting notifications
INSERT INTO Notifications (RideId, ReceiverId, SenderId, Message, NotificationType)
VALUES
    (1, 1, 2, "I'll be waiting outside the library.", "Message"),
    (2, 4, 5, "I'm at the pickup point.", "Pickup Alert"),
    (3, 3, 6, "Thanks for the ride!", "Thank you Message"),
    (4, 8, 10, "Are you on your way?", "Query"),
    (5, 7, 9, "Thanks for the lift!", "Appreciation");

-- Inserting friendships
INSERT INTO Friendship (StudentId1, StudentId2)
VALUES
    (1, 3),
    (2, 5),
    (4, 6),
    (7, 9),
    (8, 10),
    (1, 7),
    (3, 5);

-- Inserting user preferences
INSERT INTO UserPreferences (UserId, Pref_Name, Pref_Value)
VALUES
    (1, "Language", "English"),
    (2, "Notification Frequency", "Weekly"),
    (3, "Privacy", "Public"),
    (4, "Language", "Spanish"),
    (5, "Notification Frequency", "Daily"),
    (6, "Privacy", "Friends Only"),
    (7, "Language", "English"),
    (8, "Notification Frequency", "Never"),
    (9, "Privacy", "Public"),
    (10, "Language", "English");

-- Inserting scheduled rides
INSERT INTO ScheduledRides (RideId, ScheduledDate, ScheduledTime)
VALUES
    (1, "2023-12-20", "15:00:00"),
    (2, "2023-12-21", "17:30:00"),
    (3, "2023-12-22", "09:00:00"),
    (4, "2023-12-23", "12:00:00"),
    (5, "2023-12-24", "13:00:00");
