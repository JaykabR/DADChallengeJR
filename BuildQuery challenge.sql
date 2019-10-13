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