-- Inserting into Airline
INSERT INTO Airline VALUES ('Jet Blue');

-- Inserting into Airport
INSERT INTO Airport VALUES ('JFK', 'New York City', 'USA', 'International');
INSERT INTO Airport VALUES ('PVG', 'Shanghai', 'China', 'International');

-- Inserting into Customer
INSERT INTO Customer VALUES ('customer1@example.com', 'Customer One', 'pass123', 123, 'Street', 'City', 'State', '111-222-333', 'P123456', '2025-12-31', 'USA', '1990-01-01');
INSERT INTO Customer VALUES ('customer2@example.com', 'Customer Two', 'pass456', 456, 'Street', 'City', 'State', '222-333-444', 'P789012', '2025-12-31', 'USA', '1990-01-01');
INSERT INTO Customer VALUES ('customer3@example.com', 'Customer Three', 'pass789', 789, 'Street', 'City', 'State', '333-444-555', 'P345678', '2025-12-31', 'USA', '1990-01-01');

-- Inserting into Airplane
INSERT INTO Airplane VALUES ('Jet Blue', 1, 150, 'Boeing', 10);
INSERT INTO Airplane VALUES ('Jet Blue', 2, 200, 'Airbus', 5);
INSERT INTO Airplane VALUES ('Jet Blue', 3, 250, 'Boeing', 2);

-- Inserting into AirlineStaff
INSERT INTO AirlineStaff VALUES ('staff1', 'passStaff', 'Staff', 'One', '1980-01-01', 'Jet Blue');
INSERT INTO StaffPhone VALUES ('staff1', '444-555-666');
INSERT INTO StaffEmail VALUES ('staff1', 'staff1@jetblue.com');

-- Inserting into Flight
INSERT INTO Flight VALUES ('Jet Blue', 101, 'JFK', '2023-07-01 09:00:00', 'PVG', '2023-07-02 11:00:00', 500.00, 1);
INSERT INTO Flight VALUES ('Jet Blue', 102, 'PVG', '2023-07-03 14:00:00', 'JFK', '2023-07-04 16:00:00', 600.00, 2);

-- Inserting into Ticket
INSERT INTO Ticket VALUES (1, 'customer1@example.com', 'Jet Blue', 101, 500.00, 'credit', '1111-2222-3333-4444', 'Customer One', '2024-12-31', '2023-06-01 10:00:00');
INSERT INTO Ticket VALUES (2, 'customer2@example.com', 'Jet Blue', 101, 500.00, 'debit', '5555-6666-7777-8888', 'Customer Two', '2024-12-31', '2023-06-01 10:30:00');
