from auth import *
from flask import Flask, redirect, render_template, request, session, url_for
from os import urandom
from re import match

app = Flask(__name__)


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


# @app.route('/<name>')
# def page(name: str):
#     check_login()
#     return render_template(name + ".html")


@app.route("/grades")
def grades():
    check_login()
    if session['usertype'] == 'student':
        # render student template
        headings = ("username", "name", "A1 mark", "A2 mark", "A3 mark", "final exam mark")
        data = record("SELECT * FROM Marks WHERE username = ?", session['username'])
        return render_template('grades.html', headings=headings, data=data)
    elif session['usertype'] == 'instructor':
        # render instructor template
        headings = ("username", "name", "A1 mark", "A2 mark", "A3 mark", "final exam mark")
        data = records("SELECT * FROM Marks")
        return render_template('grades.html', headings=headings, data=data)
    else:
        raise ValueError('Invalid usertype: ' + session['usertype'])


if __name__ == '__main__':
    app.secret_key = urandom(12)
    app.run(debug=True, port=5000)
