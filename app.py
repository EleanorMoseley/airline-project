from flask import Flask, render_template, request, session, redirect, url_for
from datetime import date
import pymysql.cursors
import hashlib

app = Flask(__name__)
app.secret_key = "your_secret_key_here"

connection = pymysql.connect(host='localhost',
                        
                             user='root',
                             password='',
                             db='airline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

## HOME PAGE 
@app.route("/")
def home():
    return render_template("index.html")

# SEARCH 
@app.route("/search", methods=["POST"])
def search():
    source = request.form.get("source")
    destination = request.form.get("destination")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE departure_airport = %s AND arrival_airport = %s AND departure_date_time >= %s", (source, destination, date))
        Flight = cursor.fetchall()

    return render_template("search_results.html", flights=Flight)

##  LOGOUT
@app.route('/logout')
def logout():
    if 'user' in session:
        session.clear()
    return redirect('/')


#  REGISTER ACCOUNT 
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        role = request.form.get("role")
        password = hashlib.md5(request.form.get("password").encode()).hexdigest()
        with connection.cursor() as cursor:
        # customer 
            if role == "customer":
                print ("before execute")
                cursor.execute('Select * FROM customer WHERE email = \'%s\''% request.form.get('email'))
                print ("after execute")
                if (cursor.fetchone() != None):
                    return render_template('register.html', error = "Email Already In Use")
                customeratt = {
                    'name' : '',
                    'email' : '',
                    'password' : '',
                    'building_number' : '',
                    'street' : '',
                    'city' : '',
                    'state' : '',
                    'phone_number' : '',
                    'passport_number' : '',
                    'passport_expiration' : '',
                    'passport_country' : '',
                    'date_of_birth' : ''
                }
                for key in customeratt : 
                    # val = request.form.get(key)
                    customeratt[key] = str(request.form.get(key))
                    print(customeratt[key])
                    if (len(customeratt[key]) <1 or customeratt[key] == 'None'):
                        customeratt[key] = 'NULL'
                        continue
                    if (key == 'password'):
                        customeratt[key] = password
                    if (key != 'date_of_birth' or "building_number" or 'passport_expiration'):
                        customeratt[key] = "'" + customeratt[key] + "'"
               
                print("INSERT INTO Customer (name, email, password, address_building_number, address_street, address_city, address_state, phone_number, passport_number, passport_expiration, passport_country, date_of_birth) VALUES (%s)" % ', '.join(customeratt.values()))
                cursor.execute("INSERT INTO Customer (name, email, password, address_building_number, address_street, address_city, address_state, phone_number, passport_number, passport_expiration, passport_country, date_of_birth) VALUES ( % s)" % ', '.join(customeratt.values()))
            # staff 
            elif role == "staff":
                cursor.execute('Select * from AirlineStaff WHERE username = \'%s\''% request.form.get('username'))
                if (cursor.fetchone() != None):
                    return render_template('register.html', error = "Username Already In Use")
                cursor.execute('Select * from Airline WHERE name = \'%s\''% request.form.get('airline_name'))
                if (cursor.fetchone() == None):
                    return render_template('register.html', error = "Please Enter Valid Airline")
                staff = {
                    'username' : '',
                    'password' : '',
                    'first_name' : '',
                    'last_name': '',
                    'date_of_birth': '',
                    'airline_name': ''
                }

                for key in staff :
                    staff[key] = str(request.form.get(key))
                    if (len(staff[key]) <1 or staff[key] == 'None'):
                        staff[key] = 'NULL'
                        continue
                    if (key == 'password'):
                        staff[key] = password 
                    if (key != 'date_of_birth'):
                        staff[key] = "'" + staff[key] + "'"
               
                print ("INSERT INTO AirlineStaff (username, password, first_name, last_name, date_of_birth, airline_name) VALUES (%s)" %(', '.join(staff.values())))
                
                phone_numbers = request.form.getlist("phone_number_staff[]")
                
                if (len(set(phone_numbers)) != len(phone_numbers)):
                    return render_template('register.html', error = "Please submit each phone number only once")
    
                cursor.execute("INSERT INTO AirlineStaff (username, password, first_name, last_name, date_of_birth, airline_name) VALUES (%s)" %(', '.join(staff.values())))

                for phone_number in phone_numbers:
                    print("INSERT INTO StaffPhone (username, phone_number) VALUES (%s, \'%s\')"% (staff['username'], phone_number))
                    cursor.execute(
                        "INSERT INTO StaffPhone (username, phone_number) VALUES (%s, \'%s\')"% (staff['username'], phone_number))
            connection.commit()
            cursor.close()
        return redirect(url_for("home"))
    if request.method == "GET":
        return render_template('register.html')
    else:
        return render_template("index.html")



# CUSTOMER LOGIN 
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        password = hashlib.md5(request.form.get("password").encode()).hexdigest()


        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM Customer WHERE email = %s AND password = %s", (email, password))
            user = cursor.fetchone()
            print(user)

            if (user) is None:
                cursor.execute("SELECT * FROM AirlineStaff WHERE username = %s AND password = %s", (email, password))
                user = cursor.fetchone()
            cursor.close()
            
            if (user): 
                session["user"] = user
                session["role"] = "customer"
                return render_template('home.html')
                
            else:
                return render_template("login.html", error="Invalid username or password")
    else:
        # this assumes you have a login.html in your templates directory
        return render_template("login.html")



#  STAFF LOGIN
@app.route('/stafflogin', methods=['GET', 'POST'])
def stafflogin():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        password = hashlib.md5(request.form.get("password").encode()).hexdigest()
        cursor = connection.cursor()
        query = 'SELECT username,password FROM AirlineStaff WHERE username = %s and password = %s'
        cursor.execute(query, (username, password))
        data = cursor.fetchone()
        cursor.close()
        error = None
        if (data):
            session['user'] = username
            session["role"] = "staff"
            return redirect(url_for('staffhome'))
        else:
            error = 'Invalid login or username'
            return render_template('staffLogin.html', error=error)
    else:
        return render_template("stafflogin.html")


## USER HOME 
@app.route("/userhome")
def userhome():
    return render_template("home.html")


## STAFF HOME 
@app.route("/staffhome", methods=['GET', 'POST'])
def staffhome():
    return render_template('staffHome.html')

@app.route("/view_report", methods=["GET", "POST"])
def view_report():
    # Check if the user is logged in and is a staff
    if "user" not in session or session["role"] != "staff":
        return redirect(url_for("login"))

    def get_default_date_range():
        start_date = date.today().replace(day=1)
        end_date = date.today()

        return start_date, end_date

    if request.method == "POST":
        start_date = request.form.get("start_date")
        end_date = request.form.get("end_date")
    else:
        start_date, end_date = get_default_date_range()

    with connection.cursor() as cursor:
        # Total amount of tickets sold
        cursor.execute("SELECT COUNT(*) FROM Purchase WHERE purchase_date BETWEEN %s AND %s", (start_date, end_date))
        result = cursor.fetchone()
        print(result)
        total_tickets = result["COUNT(*)"] if result else 0

        # Month-wise tickets sold
        cursor.execute("SELECT MONTH(purchase_date) as month, COUNT(*) as count FROM Purchase WHERE purchase_date BETWEEN %s AND %s GROUP BY MONTH(purchase_date)", (start_date, end_date))
        month_wise_tickets = cursor.fetchall()

    return render_template("view_report.html", total_tickets=total_tickets, month_wise_tickets=month_wise_tickets)


##  CUSTOMER INFO
@app.route("/customerinfo", methods = ["GET", "POST"])
def customerinfo():
    updatedict = {'name': '',
            'phone_number':'', 
            'date_of_birth':'', 
            'address_street':'', 
            'address_city':'', 
            'address_state':'', 
            'address_building_number':'', 
            'passport_number':'', 
            'passport_expiration':'', 
            'passport_country':''}
    # get # 
    if request.method == "GET":
        if (session.get('logged_in')==False):
            return redirect(url_for('login'))
        user = session['user']
        email = user['email']
        with connection.cursor() as cursor:
            query = 'SELECT * FROM Customer WHERE email = %s'
            cursor.execute(query, (email))
            data = cursor.fetchone()
            cursor.close()
        for key in updatedict:
                var = str(data[key])
                print ("VAR: ", key, " ", var)
                if var == 'None' or var.isspace() or len(var)<1:
                    continue
                else:
                    updatedict[key]=var; 
        return render_template('customerinfo.html', name=updatedict['name'], email=email, phone_number=updatedict['phone_number'], date_of_birth = updatedict['date_of_birth'],
        address_street=updatedict['address_street'], address_city = updatedict['address_city'], address_state=updatedict['address_state'], address_building_number=updatedict['address_building_number'], 
        passport_expiration = updatedict['passport_expiration'], passport_number = updatedict['passport_number'], passport_country = updatedict['passport_country'])
    #  post # 
    if request.method == "POST":
        if(session.get('logged_in')== False):
            return redirect(url_for('login'))
        user = session['user']
        email = user['email']
        with connection.cursor() as cursor:
            changestring = ''
            for key in updatedict:
                var = str(request.form.get(key))
                # print ("VAR: ", key, " ", var)
                if var == 'None' or var.isspace() or len(var)<1:
                    changestring += (", %s = Null" % (key))
                else:
                    changestring += (", %s = '%s'" % (key, var))
            print ("CHANGESTRINGGG", changestring)
            if (len(changestring)>1): 
                changestring = changestring[1:]
                print("UPDATE CUSTOMER SET %s WHERE email = '%s'" % (changestring, email))
                cursor.execute("UPDATE CUSTOMER SET %s WHERE email = '%s'" % (changestring, email))
                print ("CHANGESTRINGGG", changestring)
                connection.commit()
            cursor.close()
            user = session['user']
    with connection.cursor() as cursor:
        query = 'SELECT * FROM Customer WHERE email = %s'
        cursor.execute(query, (email))
        data = cursor.fetchone()
        cursor.close()
        for key in updatedict:
                var = str(data[key])
                print ("VAR: ", key, " ", var)
                if var == 'None' or var.isspace() or len(var)<1:
                    continue
                else:
                    updatedict[key]=var; 
    return render_template('customerinfo.html', name=updatedict['name'], email=email, phone_number=updatedict['phone_number'], date_of_birth = updatedict['date_of_birth'],
    address_street=updatedict['address_street'], address_city = updatedict['address_city'], address_state=updatedict['address_state'], address_building_number=updatedict['address_building_number'], 
    passport_expiration = updatedict['passport_expiration'], passport_number = updatedict['passport_number'], passport_country = updatedict['passport_country'])
    

##  STAFF INFO
@app.route('/staffinfo', methods = ["GET", "POST"])
def staffinfo():
    updatedict = {'first_name': '',
                'last_name':'', 
                'date_of_birth':'', 
                'airline_name':''}
    if request.method == "GET":
        phonenos = []
        if (session.get('logged_in')==False):
            return redirect(url_for('stafflogin'))
        user = session['user']
        with connection.cursor() as cursor:
            query = 'SELECT * FROM AirlineStaff WHERE username = %s'
            cursor.execute(query, (user))
            data = cursor.fetchone()
            cursor.close()
        for key in updatedict:
                var = str(data[key])
                print ("VAR: ", key, " ", var)
                if var == 'None' or var.isspace() or len(var)<1:
                    continue
                else:
                    updatedict[key]=var; 
        with connection.cursor() as cursor:
            query = 'SELECT phone_number FROM StaffPhone WHERE username = %s'
            cursor.execute(query, (user))
            data = cursor.fetchall()
            cursor.close() 
        for i in data:
            phonenos.append(str(i['phone_number']))
        emails = []
        with connection.cursor() as cursor:
            query = 'SELECT email FROM StaffEmail WHERE username = %s'
            cursor.execute(query, (user))
            data = cursor.fetchall()
            cursor.close() 
        for i in data:
            emails.append(str(i['email']))
        print (phonenos)
        return render_template('staffinfo.html', username=user, first_name=updatedict['first_name'], last_name = updatedict['last_name'], date_of_birth = updatedict['date_of_birth'],
        airline_name=updatedict['airline_name'], phone_number=phonenos, emails = emails)
    

##  MY TICKETS 
@app.route("/my_tickets")
def my_tickets():
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("login"))

    user = session["user"]
    email = user["email"]

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Ticket WHERE customer_email = %s", [email])
        tickets = cursor.fetchall()

    return render_template("my_tickets.html", tickets=tickets)



##  BOOKING 
@app.route("/book/<flight_number>", methods=["GET"])
def book(flight_number):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE flight_number = %s", [flight_number])
        flight = cursor.fetchone()
    return render_template("book.html", flight=flight)



##  CONFIRM BOOKING 
@app.route("/confirm_booking/<flight_number>", methods=["POST"])
def confirm_booking(flight_number):
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("login"))

    # Get the payment information
    card_number = request.form.get("card_number")
    expiry_date = request.form.get("expiry_date")
    cvv = request.form.get("cvv")

    # Assume that the flight's base price is the sold price
    # Get the logged-in user's email
    user = session["user"]
    email = user["email"]
    
    # Get the current date and time as the purchase date and time
    from datetime import datetime
    purchase_date_time = datetime.now()

    with connection.cursor() as cursor:
        # Get the airline_name and departure_date_time for the given flight_number
        cursor.execute("SELECT * FROM Flight WHERE flight_number = %s", (flight_number,))
        flight = cursor.fetchone()

        if flight is None:
            return render_template("error.html", message="No such flight.")

        # Generate a unique ticket id
        cursor.execute("SELECT MAX(id) AS max_id FROM Ticket")
        max_id = cursor.fetchone()["max_id"]
        ticket_id = max_id + 1 if max_id is not None else 1
        print(flight)
        # Add the new booking to the Ticket table
        cursor.execute("INSERT INTO Ticket (id, customer_email, airline_name, flight_number, departure_date_time, sold_price, payment_info_card_type, payment_info_card_number, payment_info_name_on_card, payment_info_expiration_date, purchase_date_time) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                       (ticket_id, email, flight["airline_name"], flight_number, flight["departure_date_time"], flight["base_price"], 'Credit', card_number, user["name"], expiry_date, purchase_date_time))

        # Add the payment details to the Purchase table
        cursor.execute("INSERT INTO Purchase (ticket_id, customer_email, sold_price, purchase_date, purchase_time, card_type, card_number, expiration_date, name_on_card) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
                       (ticket_id, email, flight["base_price"], purchase_date_time.date(), purchase_date_time.time(), 'Credit', card_number, expiry_date, user["name"]))
        
        # Commit the transaction
        connection.commit()

    return redirect(url_for("home"))



## CANCEL BOOKING 
@app.route("/cancel_booking/<int:ticket_id>")
def cancel_booking(ticket_id):
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("login"))

    with connection.cursor() as cursor:
        # First, ensure that the ticket belongs to the logged-in user
        cursor.execute("SELECT * FROM Ticket WHERE id = %s AND customer_email = %s", (ticket_id, session["user"]["email"]))
        ticket = cursor.fetchone()

        if ticket is None:
            return render_template("error.html", message="No such ticket.")

        # Delete the purchase associated with the ticket
        cursor.execute("DELETE FROM Purchase WHERE ticket_id = %s", [ticket_id])
        # Delete the ticket
        cursor.execute("DELETE FROM Ticket WHERE id = %s", [ticket_id])

        # Commit the transaction
        connection.commit()

    return redirect(url_for("my_tickets"))



## STAFF FLIGHTS
@app.route("/staff_flights")
def staff_flights():
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("stafflogin"))

    username = session["user"]

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight INNER JOIN AirlineStaff ON Flight.airline_name = AirlineStaff.airline_name WHERE AirlineStaff.username = %s", [username])
        flights = cursor.fetchall()

    return render_template("staff_flights.html", flights=flights)



## STATUS
@app.route("/status", methods=["POST"])
def status():
    airline = request.form.get("airline")
    flight_number = request.form.get("flight_number")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE airline_name = %s AND flight_number = %s AND departure_date_time = %s", (airline, flight_number, date))
        flight = cursor.fetchone()

    return render_template("flight_status.html", flight=flight)



##  EDIT FLIGHTS 
@app.route("/edit_flight/<int:flight_number>", methods=["GET", "POST"])
def edit_flight(flight_number):
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("stafflogin"))

    with connection.cursor() as cursor:
        if request.method == "POST":
            new_departure_date_time = request.form.get("departure_date_time")
            new_arrival_date_time = request.form.get("arrival_date_time")
            new_status = request.form.get("status")

            cursor.execute("UPDATE Flight SET departure_date_time = %s, arrival_date_time = %s, status = %s WHERE flight_number = %s", (new_departure_date_time, new_arrival_date_time,new_status, flight_number))

            # Commit the transaction
            connection.commit()

            return redirect(url_for("staff_flights"))

        # For GET requests, fetch the flight and render the form
        cursor.execute("SELECT * FROM Flight WHERE flight_number = %s", [flight_number])
        flight = cursor.fetchone()

        if flight is None:
            return render_template("error.html", message="No such flight.")

        return render_template("edit_flight.html", flight=flight)


## ADD FLIGHTS
@app.route("/add_flight", methods=["GET", "POST"])
def add_flight():
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("stafflogin"))

    with connection.cursor() as cursor:
        if request.method == "POST":
            flight_number = request.form.get("flight_number")
            departure_date_time = request.form.get("departure_date_time")
            arrival_date_time = request.form.get("arrival_date_time")
            status = request.form.get("status")

            cursor.execute("INSERT INTO Flight (flight_number, departure_date_time, arrival_date_time,status) VALUES (%s, %s, %s, %s)", (flight_number, departure_date_time, arrival_date_time, status ))

            # Commit the transaction
            connection.commit()

            return redirect(url_for("staff_flights"))

        # For GET requests, render the form
        return render_template("add_flights.html")

## ADD AIRPLANES
@app.route("/add_airplane", methods=["GET", "POST"])
def add_airplane():
    if 'user' not in session:
        return redirect(url_for('stafflogin'))

    if request.method == 'POST':
        airplane_id = request.form.get("airplane_id")
        airline_name = session["user"]
        seats = request.form.get("seats")
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Airplane (id, airline_name, num_seats) VALUES (%s, %s, %s)", (airplane_id, airline_name, seats))
            connection.commit()

        return redirect(url_for("staffhome"))
    
    return render_template('add_airplane.html')


##  ADD AIRPORTS
@app.route("/add_airport", methods=["GET", "POST"])
def add_airport():
    if 'user' not in session:
        return redirect(url_for('stafflogin'))

    if request.method == 'POST':
        airport_name = request.form.get("airport_name")
        airport_city = request.form.get("airport_city")
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Airport (name, city) VALUES (%s, %s)", (airport_name, airport_city))
            connection.commit()

        return redirect(url_for("staffhome"))
    
    return render_template('add_airport.html')


##  FLIGHT RATING
@app.route("/flight_rating", methods=["GET", "POST"])
def flight_rating():
    return render_template("flight_rating_result.html")


## VIEW FLIGHT RATINGS
@app.route("/view_flight_rating", methods=["GET", "POST"])
def view_flight_rating():
    if 'user' not in session:
        return redirect(url_for('stafflogin'))
    if request.method == "POST":
        airline_name = request.form.get("airline_name")
        flight_number = request.form.get("flight_number")
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT rating,comment FROM Rate WHERE airline_name = %s and flight_number = %s", [airline_name, flight_number])
            rates = cursor.fetchall()
        return render_template(("flight_rating_result.html"), rates=rates)
    return render_template("view_flight_rating.html")



## RATE FLIGHT
@app.route("/rate_flight", methods=["GET", "POST"])
def rate_flight():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        flight_id = request.form.get("flight_id")
        rating = request.form.get("rating")
        comment = request.form.get("comment")
        email = session["user"]
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Flight_Rating (flight_id, email, rating, comment) VALUES (%s, %s, %s, %s)", 
                            (flight_id, email, rating, comment))
            connection.commit()

        return redirect(url_for("home"))
    
    return render_template('rate_flight.html')


## VIEW CUSTMERS
@app.route("/customers")
def customers():
    # Redirect to login page if user is not logged in
    if "user" not in session:
        return redirect(url_for("stafflogin"))

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Customer")
        customers = cursor.fetchall()

    return render_template("customers.html", customers=customers)

## VIEW SPENDING 
@app.route("/spending")
def spending():
    if 'user' not in session:
        return redirect(url_for('login'))

    email = session["user"]
    with connection.cursor() as cursor:
        cursor.execute("SELECT MONTH(purchase_date) AS Month, YEAR(purchase_date) AS Year, SUM(price) AS Total FROM Ticket WHERE email = %s AND purchase_date > DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR) GROUP BY YEAR(purchase_date), MONTH(purchase_date)", (email,))
        spending = cursor.fetchall()

    return render_template('spending.html', spending=spending)







##   RUN   ###
if __name__ == "__main__":
	app.run('127.0.0.1', 5000, debug = True)
