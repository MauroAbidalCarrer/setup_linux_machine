import os
import requests
from pathlib import Path

if not os.path.exists(Path.home().joinpath(".vast_api_key")):
    print("No .vast_api_key found at home, please add your api key to this path.")
    print("Create a new api key at https://cloud.vast.ai/manage-keys/")
    exit(1)
# Read the API key from your ~/.vast_api_key file
api_key = Path.home().joinpath(".vast_api_key").read_text().strip()

# Define the headers and URL
headers = {"Authorization": f"Bearer {api_key}"}
url = "https://console.vast.ai/api/v0/instances/"

# Send the GET request
response = requests.get(url, headers=headers)

# Check the result
if response.ok:
    response = response.json()  # Parsed JSON response
else:
    print(f"Request failed: {response.status_code} - {response.text}")


BASE_INSTANCE_CFG = {
    "User": "root",
    "ForwardAgent": "yes",
    "IdentityFile": "~/.ssh/vast_ai_key",
}

ssh_cfg_path = os.path.expanduser("~/.ssh/config")
with open(ssh_cfg_path, "w") as f:
    for instance_i, instance in enumerate(response["instances"]):
        if instance_i > 0:
            f.write("\n")
        instance_cfg_dict = {
            "HostName": instance["ssh_host"],
            "Port": instance["ssh_port"],
        }
        instance_cfg_dict |= BASE_INSTANCE_CFG
        print(instance_cfg_dict)
        f.write("Host vast" + ("" if instance_i == 0 else "_" + str(instance_i)) + "\n")
        for k, v in instance_cfg_dict.items():
            f.write(f"\t{k} {v}\n")