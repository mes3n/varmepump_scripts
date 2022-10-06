#!/bin/sh

cd $(dirname "$0")  # change working directory to install parent

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install git

mkdir varmeweb
git clone https://github.com/mes3n/varmeweb varmeweb
sudo pip install -r varmeweb/requirements.txt

mkdir varmescript
git clone https://github.com/mes3n/varmescript varmescript
sudo pip install -r varmescript/requirements.txt

mkdir logs
mkdir varmescript/config
mkdir varmescript/database

echo "[]" > varmescript/config/parameters.json

echo "{
    \"TOKEN\": \"\",
    \"husdata_ip\": \"\",
    \"low_mid\": 1.0,
    \"mid_high\": 2.0
}" > varmescript/config/config.json

python setup_husdata_csv.py 192.168.1.194

echo "{
    \"script_dir\": \"$(realpath varmescript)\",
    \"script_config\": \"$(realpath varmescript/config/config.json)\",
    \"script_parameters\": \"$(realpath varmescript/config/parameters.json)\",
    \"script_database\": \"$(realpath varmescript/database/husdata.csv)\"
}" > varmeweb/paths.json

(sudo crontab -l ; echo "@reboot sh $(pwd)/run.sh > $(pwd)/logs/varmepump.log 2>&1") | sudo crontab
echo "Set up crontab for launching server on pi start."