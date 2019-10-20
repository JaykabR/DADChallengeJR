/*
Tour (TourName, Description)
Primary: Key TourName
    ----
Event (EventYear, EventMonth, EventDay, Fee)
Primary Key: EventYear, EventMonth, EventDay
Foreign Key: TourName REFERENCES Tour
    ----
Booking (DateBooked, Payment)
Foreign Key: EventYear, EventMonth, EventDay REFERENCES Event
Foreign Key: ClientID REFERENCES Client
    ----
Client (ClientID, Surname, GivenName, Gender)
Primary Key: ClientID
*/

DROP TABLE IF EXISTS dbo.Booking;
DROP TABLE IF EXISTS dbo.Event;
DROP TABLE IF EXISTS dbo.Client;
DROP TABLE IF EXISTS dbo.Tour;

CREATE TABLE Tour (
    TourName    NVARCHAR(100)   
,   Description NVARCHAR(500)
    PRIMARY KEY (TourName)
);
CREATE TABLE Client (
    ClientID    INT             
,   Surname     NVARCHAR(100) 
,   GivenName   NVARCHAR(100)  
,   Gender      NVARCHAR(1)     CHECK (Gender='F' OR Gender='M' OR Gender='I')
    PRIMARY KEY (ClientID)
);
CREATE TABLE Event (
    TourName    NVARCHAR(100)   
,   EventYear   INT             
,   EventMonth  NVARCHAR(3)     CHECK (EventMonth= 'Jan' OR EventMonth= 'Feb' OR EventMonth= 'Mar' OR EventMonth= 'Apr' OR EventMonth= 'May' OR EventMonth= 'Jun' OR EventMonth= 'Jul' OR EventMonth= 'Aug' OR EventMonth= 'Sep' OR EventMonth= 'Oct' OR EventMonth= 'Nov' OR EventMonth= 'Dec')
,   EventDay    INT             CHECK (EventDay <= 31)
,   EventFee    MONEY           CHECK (EventFee > 0)
,   PRIMARY KEY (EventYear, EventMonth, EventDay)
,   FOREIGN KEY (TourName) References Tour
);
CREATE TABLE Booking (
    TourName    NVARCHAR(100)   
,   ClientID    INT             
,   EventYear   INT             
,   EventMonth  NVARCHAR(3)             
,   EventDay    INT              
,   DateBooked  DATE             NOT NULL
,   Payment     MONEY            CHECK (Payment > 0)
,   PRIMARY KEY (DateBooked)
,   FOREIGN KEY (TourName) REFERENCES Tour 
,   FOREIGN KEY (ClientID) REFERENCES Client 
,   FOREIGN KEY (EventYear, EventMonth, EventDay) REFERENCES Event
);

INSERT INTO Tour (TourName, Description) VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region')
INSERT INTO Tour (TourName, Description) VALUES ('South', 'Tour of wineries and outlets of Mornington Penisula')
INSERT INTO Tour (TourName, Description) VALUES ('West', 'Tour of wineries and outlets of the Geelong and Otways region')

INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES (102559627, 'Redfern', 'Jaykab', 'M')
INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES (1, 'Price', 'Taylor', 'M')
INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES (2, 'Gamble', 'Ellyse', 'F')
INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES (3, 'Tan', 'Tilly', 'F')

INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('North', 'Jan', 9, 2016, 200)
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('North', 'Feb', 13, 2016, 225)
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('South', 'Jan', 9, 2016, 200)
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('South', 'Jan', 16, 2016, 200)
INSERT INTO Event (TourName, EventMonth, EventDay, EventYear, EventFee) VALUES ('West', 'Jan', 29, 2016, 225)

INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'North', 'Jan', 9, 2016, 200, '2015-12-9')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'North', 'Jan', 9, 2016, 200, '2015-12-9')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'North', 'Feb', 13, 2016, 225, '2016-01-8')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'North', 'Feb', 13, 2016, 125, '2016-01-14')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'North', 'Feb', 13, 2016, 225, '2016-02-3')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (1, 'South', 'Feb', 9, 2016, 225, '2016-12-10')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'South', 'Feb', 16, 2016, 225, '2016-12-18')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'South', 'Feb', 16, 2016, 225, '2016-01-9')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (2, 'West', 'Jan', 29, 2016, 225, '2015-12-17')
INSERT INTO Booking (ClientId, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES (3, 'West', 'Jan', 29, 2016, 200, '2015-12-18')

CREATE VIEW Q1 AS
SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
FROM Client C, Tour T, Event E, Booking B;

SELECT EventMonth, TourName, COUNT(*) as "Num Booking"
FROM Booking
GROUP BY EventMonth, TourName;

SELECT *
FROM Booking
WHERE Payment >
(SELECT AVG(Payment) FROM Booking);

SELECT Q1;

/*
This Query proves that all the data in booking is valid due to no result being
provided when exicuted. If you where to put a '=' next to the '<' then is would
produce all booking results.
*/

SELECT EventYear
FROM Booking
WHERE EventYear < 2016;

/*
This Query is the opposite to Line 91's Query, it displays the result under the AVG
of 200 which is one result being 125.
*/

SELECT *
FROM Booking
WHERE Payment <
(SELECT AVG(Payment) FROM Booking);

/*
This Query displays all the clients inside the data base in number order.
You can see that I have inputed myself and it is down the bottom becuase of the
length of my ClientID. 
*/

SELECT *
FROM Client
ORDER BY len(ClientID), ClientID;