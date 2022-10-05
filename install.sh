#!/bin/sh

cd $(dirname "$0")  # change working directory to install parent

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install git

sudo pip install pyTibber

sudo pip install Flask
sudo pip install waitress

mkdir varmeweb
git clone https://github.com/mes3n/varmeweb varmeweb

mkdir varmescript
git clone https://github.com/mes3n/varmescript varmescript

mkdir logs
mkdir varmescript/config
mkdir varmescript/database

(sudo crontab -l ; echo "@reboot sh $(pwd)/run.sh > $(pwd)/logs/varmepump.log 2>&1") | sudo crontab
echo "Set up crontab for launching server on pi start."