from flask import Flask, request, render_template, redirect
import os 
import sqlite3

dbLocation = os.path.dirname(os.path.relpath(__file__))

app = flask(__name__)

@app.route("/")
def homepage():
    return render_template('login.html')

@app.route("/", methods = ['POST'])
def checklogin():
    USNM = request.form['username']
    PSWD = request.form['password']

    sqlconnection = sqlite3.Connection(dbLocation + "\assignment3.db")
    cursor = sqlconnection.cursor()
    query1 = "SELECT username, password from Users WHERE username = '{usnm}' AND password = '{pswd}'".format(usnm = USNM, pswd = PSWD)

    rows = cursor.execute(query1)
    rows = rows.fetchall()
    if len(rows) == 1:
        return render_template('index.html')
    else:
        return redirect ('register.html')


@app.route("/register", methods = ["GET", "POST"])
def registerpage():
    if request.method == "POST":
        RUN = request.form['rusername']
        RPW = request.form['rpassword']
        RE = request.form['remail']
        sqlconnection = sqlite3.Connection(dbLocation + "\assignment3.db")
        cursor = sqlconnection.cursor()
        query1 = "INSERT INTO Users VALUES ( '{u}', '{p}', '{e}')".format(u = RUN, p = RPW, e = RE)
        cursor.execute(query1)
        sqlconnection.commit()
        return redirect("/")
    return render_template('register.html')

@app.route("/feedback", methods = ['POST'])
def feedbackpage():
    if request.method == "POST":
        Q1 = request.form['feedback1']
        Q2 = request.form['feedback2']
        Q3 = request.form['feedback3']
        Q4 = request.form['feedback4']
        sqlconnection = sqlite3.Connection(dbLocation + "\assignment3.db")
        cursor = sqlconnection.cursor()
        query1 = "INSERT INTO Feedback VALUES ( '{q1}', '{q2}', '{q3}', '{q4}')".format(q1 = Q1, q2 = Q2, q3 = Q3, q4 = Q4)
        cursor.execute(query1)
        sqlconnection.commit()
        #add here if usertype = student render_template register.html else dont. also add code for dropdown
        return render_template('register.html')
