import subprocess
from flask import Flask
from main2 import * ;
from main import * ;

app = Flask(__name__)


@app.route("/")
def start_main():
    #subprocess.call(["python", "main.py"])
    return returnCSV()