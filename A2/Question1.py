from flask import Flask, request

app = Flask(__name__)


@app.route("/<name>")
def generateResponse(name: str):
    if name.isupper() and name.isalpha():
        return "Welcome, " + name.lower() + ", to my CSCB20 website"
    elif name.islower() and name.isalpha():
        return "Welcome, " + name.upper() + ", to my CSCB20 website"
    else:
        out = ""
        for char in name:
            if char.isalpha():
                out += char
        return "Welcome, " + out + ", to my CSCB20 website"


if __name__ == "__main__":
    app.run(debug=True)
