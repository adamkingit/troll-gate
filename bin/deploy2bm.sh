#!/bin/sh

# echo "Authenticate to BlueMix and push application"
# cf login -a api.ng.bluemix.net -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD"
# cf push

# echo "see env --------------------------------------------------"
# env
# echo "see env --------------------------------------------------"

echo "try travis token"
travis token --org
echo "end travis token"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' http://troll-gate.mybluemix.net)
if [ $STATUS -eq 200 ]; then
  echo "Deployment approved."
  cd ansible && ansible-playbook cf_push.yml && cd -
else
  echo "Deployment not approved. $STATUS"
  sleep 10
  # https://api.travis-ci.org/build/175825525/restart
  RESTART_URL="https://api.travis-ci.org/build/$TRAVIS_BUILD_ID/restart"
  echo "curl -X POST \"$RESTART_URL\" -HAuthorization:\"token $1\"  -d \"\""
  curl -X POST "$RESTART_URL" -HAuthorization:"token $1"  -d ""
fi
