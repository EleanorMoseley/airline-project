from flask import Flask, render_template, request, session, redirect, url_for
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

@app.route("/")
def home():
    return render_template("index.html")

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
        cursor.execute("SELECT airline_name, departure_date_time FROM Flight WHERE flight_number = %s", (flight_number,))
        flight = cursor.fetchone()

        if flight is None:
            return render_template("error.html", message="No such flight.")

        # Generate a unique ticket id
        cursor.execute("SELECT MAX(id) AS max_id FROM Ticket")
        max_id = cursor.fetchone()["max_id"]
        ticket_id = max_id + 1 if max_id is not None else 1

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
    if request == 'POST':
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
        cursor.execute("SELECT * FROM Flight WHERE airline_name = %s AND flight_number = %s AND departure_time = %s", (airline, flight_number, date))
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
            cursor.execute("INSERT INTO Customer (name, email, password) VALUES (%s, %s, %s)", (name, email, password))
            connection.commit()
            cursor.close()
        return redirect(url_for("index"))
    if request.method == "GET":
        return render_template('register.html')
    else:
        # this assumes you have a register.html in your templates directory
        return render_template("index.html")



@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        # for testing purposes, the following line checks unhashed passwords
        password = request.form.get("password")   
        #password = hashlib.md5(request.form.get("password").encode()).hexdigest()


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
                return render_template('home.html')
                
            else:
                return render_template("login.html", error="Invalid username or password")
    else:
        # this assumes you have a login.html in your templates directory
        return render_template("login.html")

@app.route('/logout')
def logout():
    if (session.get('logged_in')==True):
        session.pop('username')
    return redirect('/')

if __name__ == "__main__":
	app.run('127.0.0.1', 5000, debug = True)
