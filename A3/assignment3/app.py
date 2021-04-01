from db import *
from flask import Flask, redirect, render_template, request, session, abort, url_for
import os

app = Flask(__name__)


def valid_login(username: str, password: str):
    user = record("SELECT * FROM Users WHERE username = ? AND password = ?", username, password)
    return user is not None


def login_user(username: str):
    session['username'] = username


@app.route('/')
def index():
    if 'username' not in session:
        return redirect(url_for('login'))
    return render_template('index.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    error = None
    if request.method == 'POST':
        if valid_login(request.form['username'], request.form['password']):
            login_user(request.form['username'])
            return redirect(url_for('index'))
        else:
            error = "Invalid username or password"
    elif 'username' in session:
        return redirect(url_for('index'))
    return render_template('login.html', error=error)


@app.route('/logout')
def logout():
    # remove the username from the session if it is there
    session.pop('username', None)
    return redirect(url_for('login'))


@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/<name>')
def page(name: str):
    return render_template(name + ".html")


if __name__ == '__main__':
    app.secret_key = os.urandom(12)
    app.run(debug=True, port=5000)
