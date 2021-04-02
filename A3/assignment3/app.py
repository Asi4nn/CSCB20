from auth import *
from flask import Flask, redirect, render_template, request, session, abort, url_for
from os import urandom

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


@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/<name>')
def page(name: str):
    if 'username' not in session:
        abort(403)
    return render_template(name + ".html")

@app.route("/grades")
def grades():
    
    headings = ("username", "name", "A1 mark", "A2 mark", "A3 mark", "final exam mark")
    data = records("SELECT * FROM Marks WHERE username = ?", session['username'])
    return render_template('grades.html', headers=headings, data=data)


if __name__ == '__main__':
    app.secret_key = urandom(12)
    app.run(debug=True, port=5000)
