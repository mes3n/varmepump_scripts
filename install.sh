#!/bin/sh

cd $(dirname "$0")  # change working directory to install parent

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install git

server_dir=varmeserver
mkdir $server_dir
git clone https://github.com/mes3n/varmeserver $server_dir
sudo pip install -r $server_dir/requirements.txt

script_dir=varmescript
mkdir $script_dir
git clone https://github.com/mes3n/varmescript $script_dir
sudo pip install -r $script_dir/requirements.txt

cd $server_dir
ln -s ../$script_dir varmescript
cd ..

mkdir logs
touch logs/varmepump.log
mkdir $script_dir/config
mkdir $script_dir/database

echo "[]" > $script_dir/config/parameters.json

echo "{
    \"TOKEN\": \"\",
    \"husdata_ip\": \"\",
    \"low_mid\": 1.0,
    \"mid_high\": 2.0
}" > $script_dir/config/config.json

touch $script_dir/database/husdata.csv

echo "{
    \"script_dir\": \"$(realpath varmescript)\",
    \"script_config\": \"$(realpath varmescript/config/config.json)\",
    \"script_parameters\": \"$(realpath varmescript/config/parameters.json)\",
    \"script_database\": \"$(realpath varmescript/database/husdata.csv)\"
}" > $server_dir/paths.json

(sudo crontab -l ; echo "@reboot sh $(pwd)/run.sh > $(pwd)/logs/varmepump.log 2>&1") | sudo crontab
echo "Set up crontab for launching server on pi start."
