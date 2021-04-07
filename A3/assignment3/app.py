from auth import *
from flask import Flask, redirect, render_template, request, session, url_for
from os import urandom
from re import match

app = Flask(__name__)

# Page to reset the db (for developers)


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
            execute("INSERT INTO Marks VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    username, name, None, None, None, None, None, None, None, None)
            commit()
            msg = 'Account successfully created!'
    return render_template('register.html', msg=msg)


# Website Pages

@app.route('/assignments')
def assignments():
    check_login()
    return render_template("assignments.html")


@app.route('/calendar')
def calendar():
    check_login()
    return render_template("calendar.html")


@app.route('/exams')
def exams():
    check_login()
    return render_template("exams.html")


@app.route('/labs')
def labs():
    check_login()
    return render_template("labs.html")


@app.route('/lectures')
def lectures():
    check_login()
    return render_template("lectures.html")


@app.route('/resources')
def resources():
    check_login()
    return render_template("resources.html")


@app.route('/syllabus')
def syllabus():
    check_login()
    return render_template("syllabus.html")


@app.route("/grades", methods=['POST', 'GET'])
def grades():
    check_login()
    if session['usertype'] == 'student':
        # render student template
        headings = ("A1", "A2", "A3", "final")

        if request.method == 'POST':
            reason = request.form['reason']
            execute(f"UPDATE Marks SET {request.form['asn']} = ? WHERE username = ?", reason, session['username'])
            commit()
        data = records("SELECT A1, A2, A3, final FROM Marks WHERE username = ?", session['username'])
        return render_template('grades.html', headings=headings, data=data)
    elif session['usertype'] == 'instructor':
        # render instructor template
        headings = ("Username", "Name", "A1", "A2", "A3", "final", "A1 Remark Request", "A2 Remark Request",
                    "A3 Remark Request", "Final Remark Request")
        data = records("SELECT * FROM Marks")

        if request.method == "POST":
            mark = request.form['mark']
            execute(f"UPDATE Marks SET {request.form['asn']} = ? WHERE username = ?", mark, request.form['student'])
            commit()
        data = records("SELECT * FROM Marks")
        return render_template('grades.html', headings=headings, data=data)
    else:
        raise ValueError('Invalid usertype: ' + session['usertype'])


@app.route("/feedback", methods=['POST', 'GET'])
def feedback():
    check_login()
    # render student template
    if session['usertype'] == 'student':
        # get instructor names from database
        instructors = records("SELECT username FROM Users WHERE usertype = ?", "instructor")
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
            execute("INSERT INTO Feedback VALUES (?, ?, ?, ?, ?)", instructor, Q1, Q2, Q3, Q4)
            commit()
            return render_template('index.html')
    # render instructor template
    elif session['usertype'] == 'instructor':
        if request.method == "GET":
            result = []
            feedback = records("SELECT q1, q2, q3, q4 FROM Feedback WHERE username = ?", session['username'])
            return render_template('feedback.html', feedback=feedback)
    else:
        raise ValueError('Invalid usertype: ' + session['usertype'])


if __name__ == '__main__':
    app.secret_key = urandom(12)
    app.run(debug=True, port=5000)
