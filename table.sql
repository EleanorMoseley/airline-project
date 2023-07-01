CREATE TABLE Airline (
    name VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Airport (
    name VARCHAR(100) PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100),
    airport_type VARCHAR(100)
);

CREATE TABLE Airplane (
    airline_name VARCHAR(100) REFERENCES Airline(name),
    id INT PRIMARY KEY,
    num_seats INT,
    manufacturer VARCHAR(100),
    age INT
);

CREATE TABLE Flight (
    airline_name VARCHAR(100),
    flight_number INT,
    departure_airport VARCHAR(100),
    departure_date_time TIMESTAMP,
    arrival_airport VARCHAR(100),
    arrival_date_time TIMESTAMP,
    base_price DECIMAL(8, 2),
    airplane_id INT,
    status VARCHAR(100),
    PRIMARY KEY (flight_number, departure_date_time, airline_name),
    FOREIGN KEY (airline_name) REFERENCES Airline(name),
    FOREIGN KEY (departure_airport) REFERENCES Airport(name),
    FOREIGN KEY (arrival_airport) REFERENCES Airport(name),
    FOREIGN KEY (airplane_id) REFERENCES Airplane(id)
);

CREATE TABLE Customer (
    email VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100),
    password VARCHAR(100),
    address_building_number INT,
    address_street VARCHAR(100),
    address_city VARCHAR(100),
    address_state VARCHAR(100),
    phone_number VARCHAR(15),
    passport_number VARCHAR(100),
    passport_expiration DATE,
    passport_country VARCHAR(100),
    date_of_birth DATE
);
CREATE TABLE Ticket (
    id INT PRIMARY KEY,
    customer_email VARCHAR(100) REFERENCES Customer(email),
    airline_name VARCHAR(100),
    flight_number INT,
    departure_date_time TIMESTAMP,
    sold_price DECIMAL(8, 2),
    payment_info_card_type VARCHAR(10),
    payment_info_card_number VARCHAR(20),
    payment_info_name_on_card VARCHAR(100),
    payment_info_expiration_date DATE,
    purchase_date_time TIMESTAMP,
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time)
);


CREATE TABLE AirlineStaff (
   username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    airline_name VARCHAR(100) REFERENCES Airline(name)
);

CREATE TABLE StaffPhone (
    username VARCHAR (100),
    phone_number VARCHAR(15),
    PRIMARY KEY (username, phone_number),
    FOREIGN KEY (username) REFERENCES AirlineStaff(username)
);

CREATE TABLE StaffEmail (
    username VARCHAR (100),
    email VARCHAR (100),
    PRIMARY KEY (username, email),
    FOREIGN KEY (username) REFERENCES AirlineStaff(username)
);  

CREATE TABLE Departure (
    airport_name VARCHAR(50),
    flight_number INT,
    departure_date_time TIMESTAMP,
    airline_name VARCHAR(100),
    PRIMARY KEY (airport_name, flight_number, departure_date_time),
    FOREIGN KEY (airport_name) REFERENCES Airport(name),
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time)
);
CREATE TABLE Arrival (
    airport_name VARCHAR(50),
    flight_number INT,
    departure_date_time TIMESTAMP,
    airline_name VARCHAR(100),
    PRIMARY KEY (airport_name, flight_number, departure_date_time),
    FOREIGN KEY (airport_name) REFERENCES Airport(name),
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time)
);

CREATE TABLE Uses (
    flight_number INT,
    airplane_id INT,
    departure_date_time TIMESTAMP,
    airline_name VARCHAR(100),
    PRIMARY KEY (flight_number, airplane_id, departure_date_time),
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time),
    FOREIGN KEY (airplane_id) REFERENCES Airplane(id)
);

CREATE TABLE Has (
    flight_number INT,
    ticket_id INT,
    departure_date_time TIMESTAMP,
    airline_name VARCHAR(100),
    PRIMARY KEY (flight_number, ticket_id, departure_date_time),
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time),
    FOREIGN KEY (ticket_id) REFERENCES Ticket(id)
);

CREATE TABLE Works (
    staff_username VARCHAR(100),
    airline_name VARCHAR(100),
    PRIMARY KEY (staff_username, airline_name),
    FOREIGN KEY (staff_username) REFERENCES AirlineStaff(username),
    FOREIGN KEY (airline_name) REFERENCES Airline(name)
);

CREATE TABLE Rate (
    flight_number INT,
    customer_email VARCHAR(100),
    departure_date_time TIMESTAMP,
    rating INT,
    airline_name VARCHAR(100),
    comment VARCHAR(255),
    PRIMARY KEY (flight_number, customer_email, departure_date_time),
    FOREIGN KEY (airline_name, flight_number, departure_date_time) REFERENCES Flight(airline_name, flight_number, departure_date_time),
    FOREIGN KEY (customer_email) REFERENCES Customer(email)
);


CREATE TABLE Purchase (
    ticket_id INT,
    customer_email VARCHAR(100),
    sold_price DECIMAL(10, 2),
    purchase_date DATE,
    purchase_time TIME,
    card_type VARCHAR(20),
    card_number VARCHAR(20),
    expiration_date DATE,
    name_on_card VARCHAR(100),
    PRIMARY KEY (ticket_id, customer_email),
    FOREIGN KEY (ticket_id) REFERENCES Ticket(id),
    FOREIGN KEY (customer_email) REFERENCES Customer(email)
);
