#!/bin/sh

# echo "Authenticate to BlueMix and push application"
# cf login -a api.ng.bluemix.net -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD"
# cf push

# echo "see env --------------------------------------------------"
# env
# echo "see env --------------------------------------------------"
echo "TRAVIS_JOB_ID== $TRAVIS_JOB_ID"

BIN_PATH=$(dirname $0)
TRAVIS_TOKEN=$(node "$BIN_PATH/getTravisToken.js")


STATUS=$(curl -s -o /dev/null -w '%{http_code}' "http://troll-gate.mybluemix.net?travis_token=$TRAVIS_TOKEN&build_id=$TRAVIS_BUILD_ID")
# STATUS=400
if [ $STATUS -eq 200 ]; then
  echo "Deployment approved."
  cd ansible && ansible-playbook cf_push.yml && cd -
else
  echo "Deployment not approved. $STATUS"
  CANCEL_URL="https://api.travis-ci.org/builds/$TRAVIS_BUILD_ID/cancel"
  echo "Exiting build with error."
  # echo "cancel build in 10"
  # sleep 10
  # curl -X POST -H "Accept: application/vnd.travis-ci.2+json" -H "User-Agent: Travis Req" -H "Authorization: token $TRAVIS_TOKEN" -d "" "$CANCEL_URL"
  exit 1
fi
