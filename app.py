from flask import Flask, render_template, request, session, redirect, url_for
import pymysql.cursors
import hashlib

app = Flask(__name__)
app.secret_key = "your_secret_key_here"

connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='airline',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

@app.route("/")
def home():
    return render_template("home.html")

@app.route("/search", methods=["POST"])
def search():
    source = request.form.get("source")
    destination = request.form.get("destination")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flights WHERE departure_airport = %s AND arrival_airport = %s AND departure_time >= %s", (source, destination, date))
        flights = cursor.fetchall()

    return render_template("search_results.html", flights=flights)

@app.route("/status", methods=["POST"])
def status():
    airline = request.form.get("airline")
    flight_number = request.form.get("flight_number")
    date = request.form.get("date")

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Flights WHERE airline_name = %s AND flight_number = %s AND departure_time = %s", (airline, flight_number, date))
        flight = cursor.fetchone()

    return render_template("flight_status.html", flight=flight)

@app.route("/register", methods=["POST"])
def register():
    name = request.form.get("name")
    email = request.form.get("email")
    password = hashlib.md5(request.form.get("password").encode()).hexdigest()
    role = request.form.get("role")

    with connection.cursor() as cursor:
        if role == "customer":
            cursor.execute("INSERT INTO Customers (name, email, password) VALUES (%s, %s, %s)", (name, email, password))
        else:
            cursor.execute("INSERT INTO AirlineStaff (username, password) VALUES (%s, %s)", (email, password))

    return redirect(url_for("home"))

@app.route("/login", methods=["POST"])
def login():
    email = request.form.get("email")
    password = hashlib.md5(request.form.get("password").encode()).hexdigest()

    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Customers WHERE email = %s AND password = %s", (email, password))
        user = cursor.fetchone()

        if user is None:
            cursor.execute("SELECT * FROM AirlineStaff WHERE username = %s AND password = %s", (email, password))
            user = cursor.fetchone()

        if user is not None:
            session["user"] = user
            return redirect(url_for("home"))
        else:
            return render_template("login.html", error="Invalid username or password")

if __name__ == "__main__":
    app.run(debug=True)
