from auth import *
from flask import Flask, redirect, render_template, request, session, url_for
from os import urandom
from re import match

app = Flask(__name__)

# Temp page to reset the db


@app.route("/reset")
def reset():
    build()
    return redirect(url_for('index'))


# Login Routes


@app.route('/')
def index():
    if 'username' not in session:
        return redirect(url_for('login'))
    return render_template('index.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    error = None
    if request.method == 'POST':
        if valid_login(request.form['username']):
            login_user(request.form['username'])
            return redirect(url_for('index'))
        else:
            error = "Invalid username or password"
    elif 'username' in session:
        return redirect(url_for('index'))
    return render_template('login.html', error=error)


@app.route('/logout')
def logout():
    close_session()
    return redirect(url_for('login'))


@app.route('/register',  methods=['POST', 'GET'])
def register():
    close_session()
    msg = None
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        name = request.form['name']
        usertype = request.form['usertype']

        account = record("SELECT * FROM Users WHERE username = ?", username)

        if account:
            msg = "Account already exists!"
        elif not match(r"[^@]+[@][^@]+\.[a-zA-Z]+", email):
            msg = "Invalid email address!"
        elif not match(r"[A-Za-z0-9]+", username):
            msg = 'Username must contain only characters and numbers!'
        else:
            execute("INSERT INTO Users VALUES (?, ?, ?, ?, ?)", username, name, password, email, usertype)
            commit()
            msg = 'Account successfully created!'
    return render_template('register.html', msg=msg)


# Website Pages

@app.route('/<name>')
def page(name: str):
    check_login()
    return render_template(name + ".html")


@app.route("/grades", methods=['POST', 'GET'])
def grades():
    check_login()
    if session['usertype'] == 'student':
        # render student template
        headings = ("A1", "A2", "A3", "final")
        data = records("SELECT A1, A2, A3, final FROM Marks WHERE username = ?", session['username'])
        if request.method == 'POST':
            A1_reason = request.form['A1_reason']
            A2_reason = request.form['A2_reason']
            A3_reason = request.form['A3_reason']
            final_reason = request.form['final_reason']
        
            execute("INSERT OR REPLACE INTO Marks(username, a1_reason, a2_reason, a3_reason, final_reason) VALUES (?, ?, ?, ?, ?)",
                    session['username'], A1_reason, A2_reason, A3_reason, final_reason)
            commit()
        return render_template('grades.html', headings=headings, data=data)
    elif session['usertype'] == 'instructor':
        # render instructor template
        headings = ("Username", "Name", "A1", "A2", "A3", "Final", "A1 Remark Request", "A2 Remark Request", "A3 Remark Request", "Final Remark Request")
        data = records("SELECT * FROM Marks")

        if request.method == "POST":
            mark = request.form['mark']
            print(mark)

        return render_template('grades.html', headings=headings, data=data)
    else:
        raise ValueError('Invalid usertype: ' + session['usertype'])


@app.route("/feedback", methods = ['wPOST', 'GET'])
def feedbackpage():
    check_login()
    # render student template
    if session['usertype'] == 'student':
        # get instructor names from database
        query1 = "SELECT username FROM Users WHERE usertype = '{instructor}'".format(instructor = "instructor")
        instructors = records(query1)
        if request.method == "GET":
            result = []
            for i in instructors:
                result.append(i[0])
            return render_template('feedback.html', instructors=result)
        elif request.method == "POST":
            instructor = request.form['instructor-dropdown']
            Q1 = request.form['feedback1']
            Q2 = request.form['feedback2']
            Q3 = request.form['feedback3']
            Q4 = request.form['feedback4']
            query2 = "INSERT INTO Feedback VALUES ('{instructor}', '{q1}', '{q2}', '{q3}', '{q4}')".format(instructor = instructor, q1 = Q1, q2 = Q2, q3 = Q3, q4 = Q4)
            execute(query2)
            commit()
            return render_template('index.html')
    # render instructor template
    elif session['usertype'] == 'instructor':
        if request.method == "GET":
            result = []
            feedback = records("SELECT * FROM Feedback WHERE username = ?", session['username'])
            #===========================
            # need improvement later
            for i in feedback:
                result.append(i[1])
                result.append(i[2])
                result.append(i[3])
                result.append(i[4])
            #=========================
            return render_template('feedback.html', feedback=result)
    else:
        raise ValueError('Invalid usertype: ' + session['usertype'])


if __name__ == '__main__':
    app.secret_key = urandom(12)
    app.run(debug=True, port=5000)
