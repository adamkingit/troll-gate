#!/bin/sh

echo "Authenticate to BlueMix and push application"
cf login -a api.ng.bluemix.net -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD"
cf push
