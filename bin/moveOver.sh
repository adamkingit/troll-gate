#!/bin/bash

#Make account.yml
echo "---" > account.yml
echo "username: $BLUEMIX_USER" >> account.yml
echo "password: $BLUEMIX_PASSWORD" >> account.yml
echo "org: $BLUEMIX_ORG" >> account.yml
echo "space: $BLUEMIX_SPACE" >> account.yml
echo "" >> account.yml

#make app.yml
echo "---" > app.yml
echo "app_name: what-a-todd" >> app.yml
echo "manifest_path: manifest.yml" >> app.yml
echo "" >> app.yml

#copy over our key
echo -e $SERVER_KEY > ~/.ssh/id_rsa
chmod 700 ~/.ssh/id_rsa

#Copy over artifacts
ssh "root@$TOWER_IP" "mkdir /var/lib/awx/projects/$PROJECT_PATH"
scp -r ./ "root@$TOWER_IP":/var/lib/awx/projects/$PROJECT_PATH

git clone https://github.com/jcantosz/towerTalker.git
#run node app
cd towerTalker
npm install
npm start
