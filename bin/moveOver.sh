#!/bin/bash

# echo "Check the gate."
# ./bin/deploy2bm.sh
# if [ $?  != 0 ]; then
#   exit 1
# fi
#
# echo "Gate checked."
#
# #Make account.yml
# echo "---" > account.yml
# echo "username: $BLUEMIX_USER" >> account.yml
# echo "password: $BLUEMIX_PASSWORD" >> account.yml
# echo "org: $BLUEMIX_ORG" >> account.yml
# echo "space: $BLUEMIX_SPACE" >> account.yml
# echo "" >> account.yml
# echo "Created account.yml"
#
# #make app.yml
# echo "---" > app.yml
# echo "app_name: openfirst-gate" >> app.yml
# echo "manifest_path: manifest.yml" >> app.yml
# echo "" >> app.yml
# echo "Created app.yml"
#
# #copy over our key
# echo -e $SERVER_KEY > ~/.ssh/id_rsa
# chmod 700 ~/.ssh/id_rsa
#
# echo "Created id_rsa"
#
# #Copy over artifacts
# tar -cvzf jesse.tar -X .tarignore  .
# ssh -oStrictHostKeyChecking=no "root@$TOWER_IP" "mkdir /var/lib/awx/projects/$PROJECT_PATH"
# echo "mkdir /var/lib/awx/projects/$PROJECT_PATH"
# scp jesse.tar "root@$TOWER_IP":/var/lib/awx/projects/$PROJECT_PATH
# echo "scp complete"
# ssh -oStrictHostKeyChecking=no "root@$TOWER_IP" "tar -xvzf /var/lib/awx/projects/$PROJECT_PATH/jesse.tar -C  /var/lib/awx/projects/$PROJECT_PATH"

# git clone https://github.com/jcantosz/towerTalker.git
git clone -b tarballs https://github.com/jcantosz/towerTalker.git
#run node app
cd towerTalker

echo "npm install"
npm install
echo "npm start"
npm start
echo "DONE"
