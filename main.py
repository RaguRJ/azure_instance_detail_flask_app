from flask import Flask, render_template
import requests
import json

app = Flask(__name__)

metadata_server = "http://169.254.169.254/metadata/instance/network?api-version=2019-08-15"
metadata_header = {'Metadata' : 'true'}
azure_network = requests.get(metadata_server, headers = metadata_header).text
network_parsed = json.dumps(json.loads(azure_network), indent=4, sort_keys=True)
compute_parsed = json.loads(requests.get("http://169.254.169.254/metadata/instance/compute?api-version=2019-08-15", headers = metadata_header).text)
server_name = compute_parsed["name"]
server_location = compute_parsed["location"]


@app.route("/", methods=["GET"])
def hello():
    return render_template('index.html', network_parsed=network_parsed, server_name=server_name, server_location=server_location)


if __name__ == "__main__":
    app.run()

