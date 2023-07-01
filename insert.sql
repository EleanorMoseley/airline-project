-- Airline
INSERT INTO Airline VALUES ('American Airlines');
INSERT INTO Airline VALUES ('Delta Airlines');
INSERT INTO Airline VALUES ('United Airlines');

-- Airport
INSERT INTO Airport VALUES ('JFK', 'New York', 'USA', 'International');
INSERT INTO Airport VALUES ('LAX', 'Los Angeles', 'USA', 'International');
INSERT INTO Airport VALUES ('LHR', 'London', 'UK', 'International');

-- Airplane
INSERT INTO Airplane VALUES ('American Airlines', 1, 200, 'Boeing', 10);
INSERT INTO Airplane VALUES ('Delta Airlines', 2, 150, 'Airbus', 8);
INSERT INTO Airplane VALUES ('United Airlines', 3, 180, 'Boeing', 12);

-- Flight
INSERT INTO Flight VALUES ('American Airlines', 100, 'JFK', '2023-07-01 08:00:00', 'LHR', '2023-07-01 20:00:00', 500.00, 1, 'Scheduled');
INSERT INTO Flight VALUES ('Delta Airlines', 200, 'LAX', '2023-07-01 09:00:00', 'JFK', '2023-07-01 18:00:00', 400.00, 2, 'Scheduled');
INSERT INTO Flight VALUES ('United Airlines', 300, 'JFK', '2023-07-01 10:00:00', 'LAX', '2023-07-01 13:00:00', 350.00, 3, 'Scheduled');

-- Customer
INSERT INTO Customer VALUES ('john@gmail.com', 'John Doe', 'password1', 123, 'Main St', 'New York', 'New York', '1234567890', 'A12345678', '2025-12-31', 'USA', '1980-01-01');

-- Ticket
INSERT INTO Ticket VALUES (1, 'john@gmail.com', 'American Airlines', 100, '2023-07-01 08:00:00', 500.00, 'Visa', '1111222233334444', 'John Doe', '2025-12-31', '2023-06-15 12:00:00');

-- AirlineStaff
INSERT INTO AirlineStaff VALUES ('jane_doe', 'password2', 'Jane', 'Doe', '1985-05-20', 'American Airlines');

-- StaffPhone
INSERT INTO StaffPhone VALUES ('jane_doe', '0987654321');

-- StaffEmail
INSERT INTO StaffEmail VALUES ('jane_doe', 'jane@airline.com');

-- Departure
INSERT INTO Departure VALUES ('JFK', 100, '2023-07-01 08:00:00', 'American Airlines');

-- Arrival
INSERT INTO Arrival VALUES ('LHR', 100, '2023-07-01 08:00:00', 'American Airlines');

-- Uses
INSERT INTO Uses VALUES (100, 1, '2023-07-01 08:00:00', 'American Airlines');

-- Has
INSERT INTO Has VALUES (100, 1, '2023-07-01 08:00:00', 'American Airlines');

-- Works
INSERT INTO Works VALUES ('jane_doe', 'American Airlines');

-- Rate
INSERT INTO Rate VALUES (100, 'john@gmail.com', '2023-07-01 08:00:00', 4, 'American Airlines', 'Good flight');

-- Purchase
INSERT INTO Purchase VALUES (1, 'john@gmail.com', 500.00, '2023-06-15', '12:00:00', 'Visa', '1111222233334444', '2025-12-31', 'John Doe');
