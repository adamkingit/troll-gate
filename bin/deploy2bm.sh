#!/bin/sh

# echo "Authenticate to BlueMix and push application"
# cf login -a api.ng.bluemix.net -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD"
# cf push

# echo "see env --------------------------------------------------"
# env
# echo "see env --------------------------------------------------"
echo "TRAVIS_JOB_ID== $TRAVIS_JOB_ID"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://troll-gate.mybluemix.net)
# STATUS=400
if [ $STATUS -eq 200 ]; then
  echo "Deployment approved."
  cd ansible && ansible-playbook cf_push.yml && cd -
else
  echo "Deployment not approved. $STATUS"
  RESTART_URL="https://api.travis-ci.org/jobs/$TRAVIS_JOB_ID/restart"
  CANCEL_URL="https://api.travis-ci.org/jobs/$TRAVIS_JOB_ID/cancel"
  BIN_PATH=$(dirname $0)
  TRAVIS_TOKEN=$(node "$BIN_PATH/getTravisToken.js")

  echo "cancel build"
  curl -X POST -H "Accept: application/vnd.travis-ci.2+json" -H "User-Agent: Travis Req" -H "Authorization: token $TRAVIS_TOKEN" -d "" "$CANCEL_URL"


  echo "sleep 10 while we simulate the gate clearing"
  sleep 10
  # https://api.travis-ci.org/build/175825525/restart
  echo "restart build"
  #TRAVIS_TOKEN="e989fd1c0a4e04474d563b01c21d5769942506cf"
  curl -X POST -H "Accept: application/vnd.travis-ci.2+json" -H "User-Agent: Travis Req" -H "Authorization: token $TRAVIS_TOKEN" -d "" "$RESTART_URL"
fi
