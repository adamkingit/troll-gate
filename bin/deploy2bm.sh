#!/bin/sh

# echo "Authenticate to BlueMix and push application"
# cf login -a api.ng.bluemix.net -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD"
# cf push

echo "see env --------------------------------------------------"
env
echo "see env --------------------------------------------------"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://troll-gate.mybluemix.net)
if [ $STATUS -eq 200 ]; then
  echo "Deployment approved."
  cd ansible && ansible-playbook cf_push.yml && cd -
else
  echo "Deployment not approved. $STATUS"
  sleep 10
  # https://api.travis-ci.org/build/175825525/restart
  RESTART_URL="https://api.travis-ci.org/build/$TRAVIS_BUILD_ID/restart"
  curl -X POST http://example.com/myconfigs/status -HAuthorization:"token $TRAVIS_TOKEN"
fi
