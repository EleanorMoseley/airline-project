-- Insert data into Airline table
INSERT INTO Airline (name) VALUES
    ('Airline1'),
    ('Airline2'),
    ('Airline3');

-- Insert data into Airport table
INSERT INTO Airport (name, city, country, airport_type) VALUES
    ('Airport1', 'City1', 'Country1', 'Type1'),
    ('Airport2', 'City2', 'Country2', 'Type2'),
    ('Airport3', 'City3', 'Country3', 'Type3');

-- Insert data into Airplane table
INSERT INTO Airplane (airline_name, id, num_seats, manufacturer, age) VALUES
    ('Airline1', 1, 100, 'Manufacturer1', 5),
    ('Airline2', 2, 150, 'Manufacturer2', 3),
    ('Airline3', 3, 200, 'Manufacturer3', 2);

-- Insert data into Flight table
INSERT INTO Flight (airline_name, flight_number, departure_airport, departure_date_time, arrival_airport, arrival_date_time, base_price, airplane_id, status) VALUES
    ('Airline1', 1, 'Airport1', '2023-07-01 09:00:00', 'Airport2', '2023-07-01 11:00:00', 200.00, 1, 'On Time'),
    ('Airline2', 2, 'Airport2', '2023-07-01 12:00:00', 'Airport3', '2023-07-01 14:00:00', 250.00, 2, 'Delayed'),
    ('Airline3', 3, 'Airport3', '2023-07-01 15:00:00', 'Airport1', '2023-07-01 17:00:00', 300.00, 3, 'On Time');

-- Insert data into Customer table
INSERT INTO Customer (email, name, password, address_building_number, address_street, address_city, address_state, phone_number, passport_number, passport_expiration, passport_country, date_of_birth) VALUES
    ('customer1@example.com', 'Customer1', 'password1', 123, 'Street1', 'City1', 'State1', '1234567890', 'ABC123', '2025-12-31', 'Country1', '1990-01-01'),
    ('customer2@example.com', 'Customer2', 'password2', 456, 'Street2', 'City2', 'State2', '9876543210', 'DEF456', '2024-10-15', 'Country2', '1985-05-20'),
    ('customer3@example.com', 'Customer3', 'password3', 789, 'Street3', 'City3', 'State3', '5555555555', 'GHI789', '2023-06-30', 'Country3', '1995-09-10');

-- Insert data into Ticket table
INSERT INTO Ticket (id, customer_email, airline_name, flight_number, departure_date_time, sold_price, payment_info_card_type, payment_info_card_number, payment_info_name_on_card, payment_info_expiration_date, purchase_date_time) VALUES
    (1, 'customer1@example.com', 'Airline1', 1, '2023-07-01 09:00:00', 200.00, 'Credit', '1111222233334444', 'John Doe','2024-01-01', '2023-06-30 10:30:00'),
(2, 'customer2@example.com', 'Airline2', 2, '2023-07-01 12:00:00', 250.00, 'Credit', '5555666677778888', 'Jane Smith', '2025-05-01', '2023-06-30 11:45:00'),
(3, 'customer3@example.com', 'Airline3', 3, '2023-07-01 15:00:00', 300.00, 'Debit', '9999000011112222', 'Bob Johnson', '2024-03-01', '2023-06-30 13:15:00');
-- Insert data into AirlineStaff table
INSERT INTO AirlineStaff (username, password, first_name, last_name, date_of_birth, airline_name) VALUES
('staff1', 'staffpassword1', 'Staff1', 'Member1', '1990-01-01', 'Airline1'),
('staff2', 'staffpassword2', 'Staff2', 'Member2', '1985-05-20', 'Airline2'),
('staff3', 'staffpassword3', 'Staff3', 'Member3', '1995-09-10', 'Airline3');

-- Insert data into StaffPhone table
INSERT INTO StaffPhone (username, phone_number) VALUES
('staff1', '1234567890'),
('staff2', '9876543210'),
('staff3', '5555555555');

-- Insert data into StaffEmail table
INSERT INTO StaffEmail (username, email) VALUES
('staff1', 'staff1@example.com'),
('staff2', 'staff2@example.com'),
('staff3', 'staff3@example.com');

-- Insert data into Departure table
INSERT INTO Departure (airport_name, flight_number, departure_date_time, airline_name) VALUES
('Airport1', 1, '2023-07-01 09:00:00', 'Airline1'),
('Airport2', 2, '2023-07-01 12:00:00', 'Airline2'),
('Airport3', 3, '2023-07-01 15:00:00', 'Airline3');

-- Insert data into Arrival table

INSERT INTO Arrival (airport_name, flight_number, departure_date_time, airline_name)
VALUES
    ('Airport2', 1, '2023-07-01 11:00:00', 'Airline1'),
    ('Airport3', 2, '2023-07-01 14:00:00', 'Airline2'),
    ('Airport1', 3, '2023-07-01 17:00:00', 'Airline3');


-- Insert data into Uses table
INSERT INTO Uses (flight_number, airplane_id, departure_date_time, airline_name) VALUES
(1, 1, '2023-07-01 09:00:00', 'Airline1'),
(2, 2, '2023-07-01 12:00:00', 'Airline2'),
(3, 3, '2023-07-01 15:00:00', 'Airline3');

-- Insert data into Has table
INSERT INTO Has (flight_number, ticket_id, departure_date_time, airline_name) VALUES
(1, 1, '2023-07-01 09:00:00', 'Airline1'),
(2, 2, '2023-07-01 12:00:00', 'Airline2'),
(3, 3, '2023-07-01 15:00:00', 'Airline3');

-- Insert data into Works table
INSERT INTO Works (staff_username, airline_name) VALUES
('staff1', 'Airline1'),
('staff2', 'Airline2'),
('staff3', 'Airline3');

-- Insert data into Rate table
INSERT INTO Rate (flight_number, customer_email, departure_date_time, rating, airline_name, comment) VALUES
(1, 'customer1@example.com', '2023-07-01 09:00:00', 4, 'Airline1', 'Great flight'),
(2, 'customer2@example.com', '2023-07-01 12:00:00', 3, 'Airline2', 'Average flight'),
(3, 'customer3@example.com', '2023-07-01 15:00:00', 5, 'Airline3', 'Excellent flight');

-- Insert data into Purchase table
INSERT INTO Purchase (ticket_id, customer_email, sold_price, purchase_date, purchase_time, card_type, card_number, expiration_date, name_on_card) VALUES
(1, 'customer1@example.com', 200.00, '2023-07-01', '09:00:00', 'Credit', '1111222233334444', '2024-01-01', 'John Doe'),
(2, 'customer2@example.com', 250.00, '2023-07-01', '12:00:00', 'Credit', '5555666677778888', '2025-05-01', 'Jane Smith'),
(3, 'customer3@example.com', 300.00, '2023-07-01', '15:00:00', 'Debit', '9999000011112222', '2024-03-01', 'Bob Johnson');