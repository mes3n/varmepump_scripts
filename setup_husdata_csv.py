import requests
import json
import csv

import sys

def main():

    if len(sys.argv) < 1:
        print("Missing argument.")
        return 
    
    headers = ['time', 'price', json.loads(requests.get(f'http://{sys.argv[1]}/api/alldata').text).keys()]
    with open('varmescript/database/husdata.csv', 'w') as database_file:
        writer = csv.DictWriter(database_file, headers)
        writer.writeheader()


if __name__ == '__main__':
    main()