from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    # custom logging should print to the terminal in --debug mode (but would be grabbed automatically by a logging agent like Fluentd)
    app.logger.info("Hello World request received") 
    return "<p>Hello, World!</p>" # returns a simply HTML-formatted "Hello, World!" on a HTTP GET request
