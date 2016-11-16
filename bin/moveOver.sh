#!/bin/bash

#Make account.yml
echo "---" > account.yml
echo "username: $BLUEMIX_USER" >> account.yml
echo "password: $BLUEMIX_PASSWORD" >> account.yml
echo "org: $BLUEMIX_ORG" >> account.yml
echo "space: $BLUEMIX_SPACE" >> account.yml
echo "" >> account.yml
echo "Created account.yml"

#make app.yml
echo "---" > app.yml
echo "app_name: what-a-todd" >> app.yml
echo "manifest_path: manifest.yml" >> app.yml
echo "" >> app.yml
echo "Created app.yml"

#copy over our key
echo -e $SERVER_KEY > ~/.ssh/id_rsa
chmod 700 ~/.ssh/id_rsa

echo "Created id_rsa"

#Copy over artifacts
ssh -oStrictHostKeyChecking=no "root@$TOWER_IP" "mkdir /var/lib/awx/projects/$PROJECT_PATH"
echo "mkdir /var/lib/awx/projects/$PROJECT_PATH"
scp -r ./ "root@$TOWER_IP":/var/lib/awx/projects/$PROJECT_PATH
echo "scp complete"

git clone https://github.com/jcantosz/towerTalker.git
#run node app
cd towerTalker

echo "npm install"
npm install
echo "npm start"
npm start
echo "DONE"
