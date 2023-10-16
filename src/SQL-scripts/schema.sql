CREATE DATABASE UniRide;
USE UniRide;

-- University Table
CREATE TABLE University (
                            UniversityId INT PRIMARY KEY AUTO_INCREMENT,
                            Name VARCHAR(255) UNIQUE NOT NULL,
                            Address VARCHAR(255) NOT NULL
);

-- User Table
CREATE TABLE Users (
                       UserId INT PRIMARY KEY AUTO_INCREMENT,
                       Email VARCHAR(255) UNIQUE NOT NULL,
                       Name VARCHAR(255) NOT NULL,
                       Password VARCHAR(255) NOT NULL, -- This should be a hashed password.
                       Role VARCHAR(50), -- Possible values: "Driver", "Passenger", "Both"
                       UniversityId INT,
                       FOREIGN KEY (UniversityId) REFERENCES University(UniversityId)
);

-- Vehicle Table
CREATE TABLE Vehicle (
                         LicensePlate VARCHAR(255) PRIMARY KEY,
                         UserId INT NOT NULL,
                         Manufacturer VARCHAR(255) NOT NULL,
                         Model VARCHAR(255) NOT NULL,
                         Color VARCHAR(255),
                         FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- Ride Table
CREATE TABLE Rides (
                       RideId INT PRIMARY KEY AUTO_INCREMENT,
                       DriverId INT NOT NULL,
                       Time TIME NOT NULL,
                       PickupLocation VARCHAR(255) NOT NULL,
                       DropoffLocation VARCHAR(255) NOT NULL,
                       Status VARCHAR(50), -- Possible values: "Scheduled", "In Progress", "Completed", "Cancelled"
                       FOREIGN KEY (DriverId) REFERENCES Users(UserId)
);

-- Request Table
CREATE TABLE Requests (
                          RequestId INT PRIMARY KEY AUTO_INCREMENT,
                          RideId INT NOT NULL,
                          PassengerId INT NOT NULL,
                          Status VARCHAR(50) NOT NULL,
                          FOREIGN KEY (RideId) REFERENCES Rides(RideId),
                          FOREIGN KEY (PassengerId) REFERENCES Users(UserId)
);

-- Review Table
CREATE TABLE Reviews (
                         ReviewId INT PRIMARY KEY AUTO_INCREMENT,
                         RideId INT NOT NULL,
                         Feedback TEXT,
                         Rating INT NOT NULL,
                         FOREIGN KEY (RideId) REFERENCES Rides(RideId)
);

-- Notification Table
CREATE TABLE Notifications (
                               NotifId INT PRIMARY KEY AUTO_INCREMENT,
                               RideId INT NOT NULL,
                               ReceiverId INT NOT NULL,
                               SenderId INT NOT NULL,
                               Message TEXT NOT NULL,
                               NotificationType VARCHAR(50),
                               FOREIGN KEY (RideId) REFERENCES Rides(RideId),
                               FOREIGN KEY (ReceiverId) REFERENCES Users(UserId),
                               FOREIGN KEY (SenderId) REFERENCES Users(UserId)
);

-- Friendship Table
CREATE TABLE Friendship (
                            FriendshipId INT PRIMARY KEY AUTO_INCREMENT,
                            StudentId1 INT NOT NULL,
                            StudentId2 INT NOT NULL,
                            UNIQUE (StudentId1, StudentId2),
                            FOREIGN KEY (StudentId1) REFERENCES Users(UserId),
                            FOREIGN KEY (StudentId2) REFERENCES Users(UserId)
);

-- UserPreferences Table
CREATE TABLE UserPreferences (
                                 PreferenceId INT PRIMARY KEY AUTO_INCREMENT,
                                 UserId INT NOT NULL,
                                 Pref_Name VARCHAR(255) NOT NULL,
                                 Pref_Value VARCHAR(255) NOT NULL,
                                 FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- ScheduledRides Table
CREATE TABLE ScheduledRides (
                                ScheduleId INT PRIMARY KEY AUTO_INCREMENT,
                                RideId INT NOT NULL,
                                ScheduledDate DATE NOT NULL,
                                ScheduledTime TIME NOT NULL,
                                FOREIGN KEY (RideId) REFERENCES Rides(RideId)
);