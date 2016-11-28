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
echo "app_name: openfirst-gate" >> app.yml
echo "manifest_path: manifest.yml" >> app.yml
echo "" >> app.yml
echo "Created app.yml"

echo "deploy to ...$AWS_DEFAULT_REGION..."

#Copy over artifacts
tar -cvzf jesse.tar -X .tarignore  .
mkdir s3
mv jesse.tar s3

pwd
ls -la s3
