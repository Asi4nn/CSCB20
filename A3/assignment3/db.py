from os.path import isfile
from sqlite3 import connect
from datetime import datetime

DB_PATH = "./assignment3.db"
if not isfile(DB_PATH):
    raise FileNotFoundError("assignment3.db not found")


cxn = connect(DB_PATH, check_same_thread=False)
cur = cxn.cursor()


def commit():
    time = datetime.now().strftime("[%H:%M:%S]")
    print(time, "Saving to Database")
    cxn.commit()


def close():
    cxn.close()

# Use these functions by using "?" as placeholder and pass in the values for *values
# Example: execute("INSERT INTO Table1(value1, value2) VALUES (?, ?)", value1, value2)


def field(command, *values):
    cur.execute(command, tuple(values))

    fetch = cur.fetchone()
    if fetch is not None:
        return fetch[0]


def record(command, *values):
    cur.execute(command, tuple(values))

    return cur.fetchone()


def records(commands, *values):
    cur.execute(commands, tuple(values))

    return cur.fetchall()


def column(command, *values):
    cur.execute(command, *values)

    return [item[0] for item in cur.fetchall()]


def execute(command, *values):
    cur.execute(command, tuple(values))
