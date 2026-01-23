import logging
from flask import Flask

app = Flask(__name__)

# Flask's default log level is WARNING, so it won't print INFO generally. This allows INFO logs to pass through/
app.logger.setLevel(logging.INFO)

@app.route("/")
def hello_world():
    # custom logging should print to the terminal in --debug mode (but would be grabbed automatically by a logging agent like Fluentd)
    app.logger.info(">>> SUCCESS: Ingress hit the Flask app!!! <<<") 
    return "<p>Hello, World! Welcome!</p>" # returns a simply HTML-formatted "Hello, World!" on a HTTP GET request
