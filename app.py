from flask import Flask, render_template, request, session, redirect, url_for
import pymysql.cursors
import hashlib

app = Flask(__name__)
app.secret_key = "your_secret_key_here"

connection = pymysql.connect(host='localhost',
                             port = 8889,
                             user='root',
                             password='root',
                             db='airline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/searchs", methods=["GET"])
def searchs():
    return render_template("home.html")

@app.route("/search", methods=["POST"])
def search():
    source = request.form.get("source")
    destination = request.form.get("destination")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE departure_airport = %s AND arrival_airport = %s AND departure_date_time >= %s", (source, destination, date))
        Flight = cursor.fetchall()

    return render_template("search_results.html", flights=Flight)

@app.route("/book/<flight_number>", methods=["GET"])
def book(flight_number):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE flight_number = %s", [flight_number])
        flight = cursor.fetchone()
    return render_template("book.html", flight=flight)

@app.route("/customerinfo", methods = ["GET", "POST"])
def customerinfo():
    
    # list = ['name', 'phone_number', 'date_of_birth', 'address_street', 'address_city', 
    #     'address_state', 'address_building_number', 'passport_number', 'passport_expiration', 'passport_country']
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
    
@app.route("/userhome")
def userhome():
    return render_template("home.html")

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


@app.route("/staffhome", methods=['GET', 'POST'])
def staffhome():
    return render_template('staffHome.html')


@app.route('/stafflogin', methods=['GET', 'POST'])
def stafflogin():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        #password = hashlib.md5(request.form.get("password").encode()).hexdigest()
        cursor = connection.cursor()
        query = 'SELECT username,password FROM AirlineStaff WHERE username = %s and password = %s'
        cursor.execute(query, (username, password))
        data = cursor.fetchone()
        cursor.close()
        error = None
        if (data):
            session['username'] = username
            session["role"] = "Staff"
            return redirect(url_for('staffhome'))
        else:
            error = 'Invalid login or username'
            return render_template('staffLogin.html', error=error)
    else:
        return render_template("stafflogin.html")


@app.route("/status", methods=["POST"])
def status():
    airline = request.form.get("airline")
    flight_number = request.form.get("flight_number")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight WHERE airline_name = %s AND flight_number = %s AND departure_date_time = %s", (airline, flight_number, date))
        flight = cursor.fetchone()

    return render_template("flight_status.html", flight=flight)

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        name = request.form.get("name")
        email = request.form.get("email")
        password = hashlib.md5(request.form.get("password").encode()).hexdigest()
        # role = request.form.get("role")

        with connection.cursor() as cursor:
            # Check if user already exists
            cursor.execute("SELECT * FROM Customer WHERE email = %s", (email,))
            existing_user = cursor.fetchone()
            if existing_user:
                # If user exists, render the registration page again with an error message
                return render_template("register.html", error="User with this email already exists.")
            else:
                # If user does not exist, register the user
                cursor.execute("INSERT INTO Customer (name, email, password) VALUES (%s, %s, %s)", (name, email, password))
                connection.commit()
            cursor.close()
        return redirect(url_for("home"))

    elif request.method == "GET":
        return render_template('register.html')
    else:
        # this assumes you have a register.html in your templates directory
        return render_template("index.html")



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

@app.route('/logout')
def logout():
    if 'user' in session:
        session.pop('user')
    return redirect('/')

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

        # Delete the ticket
        cursor.execute("DELETE FROM Ticket WHERE id = %s", [ticket_id])

        # Commit the transaction
        connection.commit
@app.route("/staff_flights")
def staff_flights():
    # Redirect to login page if user is not logged in
    if "username" not in session:
        return redirect(url_for("stafflogin"))

    username = session["username"]

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flight INNER JOIN AirlineStaff ON Flight.airline_name = AirlineStaff.airline_name WHERE AirlineStaff.username = %s", [username])
        flights = cursor.fetchall()

    return render_template("staff_flights.html", flights=flights)

@app.route("/edit_flight/<int:flight_number>", methods=["GET", "POST"])
def edit_flight(flight_number):
    # Redirect to login page if user is not logged in
    if "username" not in session:
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

@app.route("/add_flight", methods=["GET", "POST"])
def add_flight():
    # Redirect to login page if user is not logged in
    if "username" not in session:
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
        return render_template("add_flight.html")
@app.route("/add_airplane", methods=["GET", "POST"])
def add_airplane():
    if 'username' not in session:
        return redirect(url_for('stafflogin'))

    if request.method == 'POST':
        airplane_id = request.form.get("airplane_id")
        airline_name = session["username"]
        seats = request.form.get("seats")
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Airplane (id, airline_name, num_seats) VALUES (%s, %s, %s)", (airplane_id, airline_name, seats))
            connection.commit()

        return redirect(url_for("staffhome"))
    
    return render_template('add_airplane.html')

@app.route("/add_airport", methods=["GET", "POST"])
def add_airport():
    if 'username' not in session:
        return redirect(url_for('stafflogin'))

    if request.method == 'POST':
        airport_name = request.form.get("airport_name")
        airport_city = request.form.get("airport_city")
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Airport (name, city) VALUES (%s, %s)", (airport_name, airport_city))
            connection.commit()

        return redirect(url_for("staffhome"))
    
    return render_template('add_airport.html')

@app.route("/customers")
def customers():
    # Redirect to login page if user is not logged in
    if "username" not in session:
        return redirect(url_for("stafflogin"))

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Customer")
        customers = cursor.fetchall()

    return render_template("customers.html", customers=customers)


@app.route("/rate_flight", methods=["GET", "POST"])
def rate_flight():
    if 'username' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        flight_id = request.form.get("flight_id")
        rating = request.form.get("rating")
        comment = request.form.get("comment")
        email = session["username"]
        
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO Flight_Rating (flight_id, email, rating, comment) VALUES (%s, %s, %s, %s)", 
                            (flight_id, email, rating, comment))
            connection.commit()

        return redirect(url_for("home"))
    
    return render_template('rate_flight.html')
@app.route("/spending")
def spending():
    if 'username' not in session:
        return redirect(url_for('login'))

    email = session["username"]
    with connection.cursor() as cursor:
        cursor.execute("SELECT MONTH(purchase_date) AS Month, YEAR(purchase_date) AS Year, SUM(price) AS Total FROM Ticket WHERE email = %s AND purchase_date > DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR) GROUP BY YEAR(purchase_date), MONTH(purchase_date)", (email,))
        spending = cursor.fetchall()

    return render_template('spending.html', spending=spending)

if __name__ == "__main__":
	app.run('127.0.0.1', 5000, debug = True)