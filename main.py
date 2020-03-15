from flask import Flask, render_template
import requests
import json

app = Flask(__name__)

metadata_server = "http://169.254.169.254/metadata/instance/network?api-version=2019-08-15"
metadata_header = {'Metadata' : 'true'}
azure_all = requests.get(metadata_server, headers = metadata_header).text
azure_parsed = json.dumps(json.loads(azure_all), indent=4, sort_keys=True)



@app.route("/", methods=["GET"])
def hello():
    return render_template('index.html', azure_parsed=azure_parsed)


if __name__ == "__main__":
    app.run()
