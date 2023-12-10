-- Creating University table
CREATE TABLE University (
    UniversityId SERIAL PRIMARY KEY,
    Name VARCHAR(255) UNIQUE NOT NULL,
    Address VARCHAR(255)
);

-- Creating Users table
CREATE TABLE Users (
    StudentId INT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,  -- Should be a hashed password.
    Role VARCHAR(50),                 -- Possible values: "Driver", "Passenger", "Both"
    UniversityId INT,
    FOREIGN KEY (UniversityId) REFERENCES University(UniversityId)
);

-- Creating UserPreferences table
CREATE TABLE UserPreferences (
    PrefId SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    Pref_Name VARCHAR(255),
    Pref_Value VARCHAR(255),
    FOREIGN KEY (UserId) REFERENCES Users(StudentId)
);

-- Creating Vehicle table
CREATE TABLE Vehicle (
    VehicleId VARCHAR(255) PRIMARY KEY, -- License plate number
    UserId INT NOT NULL,
    Manufacturer VARCHAR(255),
    Model VARCHAR(255),
    Color VARCHAR(255),
    FOREIGN KEY (UserId) REFERENCES Users(StudentId)
);

-- Creating Rides table
CREATE TABLE Rides (
    RideId SERIAL PRIMARY KEY,
    DriverId INT NOT NULL,
    Time TIME NOT NULL,
    PickupLocation VARCHAR(255) NOT NULL,
    DropoffLocation VARCHAR(255) NOT NULL,
    Status VARCHAR(50) NOT NULL, -- Possible values: "Scheduled", "In Progress", "Completed", "Cancelled"
    FOREIGN KEY (DriverId) REFERENCES Users(StudentId)
);

-- Creating RideRequests table
CREATE TABLE RideRequests (
    RequestId SERIAL PRIMARY KEY,
    RideId INT NOT NULL,
    PassengerId INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (RideId) REFERENCES Rides(RideId),
    FOREIGN KEY (PassengerId) REFERENCES Users(StudentId)
);

-- Creating RideReviews table
CREATE TABLE RideReviews (
    ReviewId SERIAL PRIMARY KEY,
    RideId INT NOT NULL,
    Feedback TEXT,
    Rating INT NOT NULL,
    FOREIGN KEY (RideId) REFERENCES Rides(RideId)
);

-- Creating Notifications table
CREATE TABLE Notifications (
    NotifId SERIAL PRIMARY KEY,
    RideId INT,
    ReceiverId INT NOT NULL,
    SenderId INT NOT NULL,
    Message TEXT,
    NotificationType VARCHAR(50),  -- Categories for notifications.
    FOREIGN KEY (RideId) REFERENCES Rides(RideId),
    FOREIGN KEY (ReceiverId) REFERENCES Users(StudentId),
    FOREIGN KEY (SenderId) REFERENCES Users(StudentId)
);

-- Creating UserFriends table
CREATE TABLE UserFriends (
    FriendshipId SERIAL PRIMARY KEY,
    StudentId1 INT NOT NULL,
    StudentId2 INT NOT NULL,
    CONSTRAINT uc_Friends UNIQUE (StudentId1, StudentId2),
    FOREIGN KEY (StudentId1) REFERENCES Users(StudentId),
    FOREIGN KEY (StudentId2) REFERENCES Users(StudentId)
);

-- Creating ScheduledRides table
CREATE TABLE ScheduledRides (
    ScheduleId SERIAL PRIMARY KEY,
    RideId INT NOT NULL,
    ScheduledDate DATE NOT NULL,
    ScheduledTime TIME NOT NULL,
    FOREIGN KEY (RideId) REFERENCES Rides(RideId)
);

