from flask import Flask, render_template, request, session, redirect, url_for
import pymysql.cursors
import hashlib

# Set up a connection to the database
connection = pymysql.connect(host='localhost',
                             user='your_username',
                             password='your_password',
                             db='your_db_name',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
