#!/bin/sh


cd $(dirname "$0")  # set working directory to parent of run.sh

cd varmeserver
python main.py &
webPID=$!
cd ..

echo "Running server with pid=$webPID."

safe_exit () {

    echo "Stopping server with pid=$webPID."

    kill $webPID || echo "$webPID cant be found."

    exit 0

}
trap "safe_exit" 2

while [ 1 ]
do
    true
done

safe_exit()
