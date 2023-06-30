
-- Show all the future flights in the system

SELECT *
From Flight
Where departure_date > CURRENT_DATE() or (departure_date = CURRENT_DATE() and departure_time > CURRENT_TIME())

-- 

B. 
Select * 
From Flight
Where status = 'delayed';

C.
Select Distinct Customer.name
From Customer
INNER JOIN Purchase ON Customer.email = Purchase.customer_email;

D.
Select * 
From Airplane
Where airline_name ='Jet Blue';
