# Author: Leo Wang

from flask import Flask, render_template, url_for, request

app = Flask(__name__)

comments = []


@app.route("/")
def root():
    return render_template("index.html", todo_list=comments)


@app.route("/add-comment")
def add_comment():
    global comments
    comments.append(request.args.get("comment-input"))

    return render_template('index.html', todo_list=comments)


if __name__ == '__main__':
    app.run(debug=True)
