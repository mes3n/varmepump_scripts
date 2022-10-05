#!/bin/sh


cd $(dirname "$0")  # set working directory to parent of run.sh

# !! Should probably be controlled from server
# cd varmescript
# .venv/bin/python main.py &
# scriptPID=$!
# cd ..

cd varmeweb
python main.py &
webPID=$!
cd ..

echo "Running server with pid=$webPID."

safe_exit () {

    echo "Stopping server with pid=$webPID."

    kill $webPID || echo "$webPID is not running"

    exit 0

}
trap "safe_exit" 2

while [ 1 ]
do
    true
done

safe_exit()
