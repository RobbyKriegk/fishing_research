import subprocess
from flask import Flask

app = Flask(__name__)

@app.route("/start_main")
def start_main():
    subprocess.call(["python", "main.py"])
    return "Started main.py"