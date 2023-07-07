INSERT INTO Airline (name) 
VALUES 
    ('United'),
    ('American Airline');

INSERT INTO airplane (airline_name, id, num_seats, manufacturer, age) VALUES 
('United', 1, 4, 'Boeing', 10),
('United', 2, 4, 'Airbus', 12),
('United', 3, 50, 'Boeing', 8);
INSERT INTO airport (name, city, country, airport_type) VALUES 
('JFK', 'NYC', 'USA', 'Both'),
('BOS', 'Boston', 'USA', 'Both'),
('PVG', 'Shanghai', 'China', 'Both'),
('BEI', 'Beijing', 'China', 'Both'),
('SFO', 'San Francisco', 'USA', 'Both'),
('LAX', 'Los Angeles', 'USA', 'Both'),
('HKA', 'Hong Kong', 'China', 'Both'),
('SHEN', 'Shenzhen', 'China', 'Both');
INSERT INTO Customer (email, name, password, address_building_number, address_street, address_city, address_state, phone_number, passport_number, passport_expiration, passport_country, date_of_birth)
VALUES 
    ('testcustomer@nyu.edu', 'Jon Snow', '81dc9bdb52d04dc20036dbd8313ed055', 1555, 'Jay St', 'Brooklyn', 'New York', '123-4321-4321', '54321', '2025-12-24', 'USA', '1999-12-19'),
    ('user1@nyu.edu', 'Alice Bob', '81dc9bdb52d04dc20036dbd8313ed055', 5405, 'Jay Street', 'Brooklyn', 'New York', '123-4322-4322', '54322', '2025-12-25', 'USA', '1999-11-19'),
    ('user2@nyu.edu', 'Cathy Wood', '81dc9bdb52d04dc20036dbd8313ed055', 1702, 'Jay Street', 'Brooklyn', 'New York', '123-4323-4323', '54323', '2025-10-24', 'USA', '1999-10-19'),
    ('user3@nyu.edu', 'Trudy Jones', '81dc9bdb52d04dc20036dbd8313ed055', 1890, 'Jay Street', 'Brooklyn', 'New York', '123-4324-4324', '54324', '2025-09-24', 'USA', '1999-09-19');
INSERT INTO Flight (Airline_Name, Flight_Number, Departure_Airport, Departure_Date_Time, Arrival_Airport, Arrival_Date_Time, Base_Price, Status, Airplane_ID) VALUES 
('United', 102, 'SFO', '2023-04-09 13:25:25', 'LAX', '2023-04-09 16:50:25', 300, 'on-time', 3),
('United', 104, 'PVG', '2023-05-04 13:25:25', 'BEI', '2023-05-04 16:50:25', 300, 'on-time', 3),
('United', 106, 'SFO', '2023-03-04 13:25:25', 'LAX', '2023-03-04 16:50:25', 350, 'delayed', 3),
('United', 206, 'SFO', '2023-09-04 13:25:25', 'LAX', '2023-09-04 16:50:25', 400, 'on-time', 2),
('United', 207, 'LAX', '2023-10-05 13:25:25', 'SFO', '2023-10-05 16:50:25', 300, 'on-time', 2),
('United', 134, 'JFK', '2023-02-11 13:25:25', 'BOS', '2023-02-11 16:50:25', 300, 'delayed', 3),
('United', 296, 'PVG', '2023-07-30 13:25:25', 'SFO', '2023-07-30 16:50:25', 3000, 'on-time', 1),
('United', 715, 'PVG', '2023-04-28 10:25:25', 'BEI', '2023-04-28 13:50:25', 500, 'delayed', 1),
('United', 839, 'SHEN', '2022-08-26 13:25:25', 'BEI', '2022-08-26 16:50:25', 300, 'on-time', 3);
INSERT INTO Ticket (
    id, customer_email, airline_name, flight_number, departure_date_time, 
    sold_price, payment_info_card_type, payment_info_card_number, 
    payment_info_name_on_card, payment_info_expiration_date, purchase_date_time
)
VALUES
    (1, 'testcustomer@nyu.edu', 'United', 102, '2023-04-09 13:25:25', 300, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-04 11:55:55'),
    (2, 'user1@nyu.edu', 'United', 102, '2023-04-09 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 1', '2027-03-01', '2023-03-03 11:55:55'),
    (3, 'user2@nyu.edu', 'United', 102, '2023-04-09 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 2', '2027-03-01', '2023-04-04 11:55:55'),
    (4, 'user1@nyu.edu', 'United', 104, '2023-05-04 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-03-21 11:55:55'),
    (5, 'testcustomer@nyu.edu', 'United', 104, '2023-05-04 13:25:25', 300, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-04-28 11:55:55'),
    (6, 'testcustomer@nyu.edu', 'United', 106, '2023-03-04 13:25:25', 350, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-03-02 11:55:55'),
    (7, 'user3@nyu.edu', 'United', 106, '2023-03-04 13:25:25', 350, 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2023-02-03 11:55:55'),
    (8, 'user3@nyu.edu', 'United', 839, '2022-08-26 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2022-08-03 11:55:55'),
    (9, 'user3@nyu.edu', 'United', 102, '2023-08-09 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2023-02-04 11:55:55'),
    (11, 'user3@nyu.edu', 'United', 134, '2023-02-11 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01', '2022-12-23 11:55:55'),
    (12, 'testcustomer@nyu.edu', 'United', 715, '2023-04-28 10:25:25', 500, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01', '2022-12-02 11:55:55'),
    (14, 'user3@nyu.edu', 'United', 206, '2023-09-04 13:25:25', 400, 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01', '2023-06-20 11:55:55'),
    (15, 'user1@nyu.edu', 'United', 206, '2023-09-04 13:25:25', 400, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-06-21 11:55:55'),
    (16, 'user2@nyu.edu', 'United', 206, '2023-09-04 13:25:25', 400, 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01', '2023-06-25 11:55:55'),
    (17, 'user2@nyu.edu', 'United', 207, '2023-10-05 13:25:25', 400, 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01', '2023-07-03 11:55:55'),
    (18, 'user1@nyu.edu', 'United', 207, '2023-10-05 13:25:25', 400, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-07-04 11:55:55'),
    (19, 'testcustomer@nyu.edu', 'United', 296, '2023-07-30 13:25:25', 300, 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01', '2023-07-01 11:55:55'),
    (20, 'user1@nyu.edu', 'United', 296, '2023-07-30 13:25:25', 300, 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01', '2023-07-01 11:55:55');
INSERT INTO Purchase (ticket_id, customer_email, sold_price, purchase_date, purchase_time, card_type, card_number, name_on_card, expiration_date)
VALUES 
    (1, 'testcustomer@nyu.edu', 300, '2023-03-04', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01'),
    (2, 'user1@nyu.edu', 300, '2023-03-03', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 1', '2027-03-01'),
    (3, 'user2@nyu.edu', 300, '2023-04-04', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 2', '2027-03-01'),
    (4, 'user1@nyu.edu', 300, '2023-03-21', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01'),
    (5, 'testcustomer@nyu.edu', 300, '2023-04-28', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01'),
    (6, 'testcustomer@nyu.edu', 350, '2023-03-02', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2027-03-01'),
    (7, 'user3@nyu.edu', 350, '2023-02-03', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01'),
    (8, 'user3@nyu.edu', 300, '2022-08-03', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01'),
    (9, 'user3@nyu.edu', 300, '2023-02-04', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01'),
    (11, 'user3@nyu.edu', 300, '2022-12-23', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 3', '2027-03-01'),
    (12, 'testcustomer@nyu.edu', 500, '2022-12-02', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01'),
    (14, 'user3@nyu.edu', 400, '2023-06-20', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 3', '2023-03-01'),
    (15, 'user1@nyu.edu', 400, '2023-06-21', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01'),
    (16, 'user2@nyu.edu', 400, '2023-04-19', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 2', '2023-03-01'),
    (17, 'user1@nyu.edu', 300, '2023-03-11', '11:55:55', 'credit', '1111-2222-3333-5555', 'User 1', '2023-03-01'),
    (18, 'testcustomer@nyu.edu', 300, '2023-04-25', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01'),
    (19, 'user1@nyu.edu', 3000, '2023-06-22', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01'),
    (20, 'testcustomer@nyu.edu', 3000, '2023-02-12', '11:55:55', 'credit', '1111-2222-3333-4444', 'Test Customer 1', '2023-03-01');

INSERT INTO Rate (flight_number, customer_email, departure_date_time, rating, airline_name, comment) VALUES 
    (102, 'testcustomer@nyu.edu', TIMESTAMP '2023-04-09 13:25:25', 4, 'United', 'Very Comfortable'),
    (102, 'user1@nyu.edu', TIMESTAMP '2023-04-09 13:25:25', 5, 'United', 'Relaxing, check-in and onboarding very professional'),
    (102, 'user2@nyu.edu', TIMESTAMP '2023-04-09 13:25:25', 3, 'United', 'Satisfied and will use the same flight again'),
    (104, 'testcustomer@nyu.edu', TIMESTAMP '2023-05-04 13:25:25', 1, 'United', 'Customer Care services are not good'),
    (104, 'user1@nyu.edu', TIMESTAMP '2023-05-04 13:25:25', 5, 'United', 'Comfortable journey and Professional');
