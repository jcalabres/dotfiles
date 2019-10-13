# Download all public gist for a user
# by using v3 gist api (https://developer.github.com/v3/gists/)

import requests, json
from pathlib import Path

headers = {"content-type" : "application/json"}
url = 'https://api.github.com/users/jcalabres/gists'
r = requests.get(url, headers = headers)

# Downloading files 
data = r.json()
counter = 0
for i in data:
    files_node = i['files']
    file_name = [k for k in files_node][0]
    r = requests.get(files_node[file_name]['raw_url'])
    f = open(str(Path.home())+'/scripts/gists/{}'.format(file_name), 'w')
    f.write(r.text)
    f.close()
    print('Downloaded {}'.format(file_name))
    counter += 1

print('{} files successfully downloaded.'.format(counter))
