from db import *
from flask import session


def valid_login(username: str):
    user = record("SELECT * FROM Users WHERE username = ?", username)
    return user is not None


def login_user(username: str):
    session['username'] = username
    session['usertype'] = get_usertype(username)


def get_usertype(username: str):
    return record("SELECT usertype FROM Users WHERE username = ?", username)


def close_session():
    # remove the username from the session if it is there
    session.pop('username', None)
    session.pop('usertype', None)