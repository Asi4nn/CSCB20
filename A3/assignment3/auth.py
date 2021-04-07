from db import *
from flask import session, abort


def valid_login(username: str):
    user = record("SELECT * FROM Users WHERE username = ?", username)
    return user is not None


def login_user(username: str):
    session['username'] = username
    session['usertype'] = get_usertype(username)


def get_usertype(username: str):
    row = record("SELECT usertype FROM Users WHERE username = ?", username)
    return row[0]


def close_session():
    # remove the username from the session if it is there
    if 'username' in session:
        session.pop('username', None)
        session.pop('usertype', None)
    else:
        print("No user logged in")


def check_login():
    if 'username' not in session:
        abort(403)
