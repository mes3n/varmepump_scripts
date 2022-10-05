#!/bin/sh

sudo apt update
sudo apt upgrade

sudo apt install git

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
