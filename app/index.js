var coinflip = require('coinflip');
var request=require('request');
var express = require('express');
var app = express();

/*
RESTART_URL="https://api.travis-ci.org/builds/$TRAVIS_BUILD_ID/restart"
curl -X POST -H "Accept: application/vnd.travis-ci.2+json" -H "User-Agent: Travis Req" -H "Authorization: token $TRAVIS_TOKEN" -d "" "$RESTART_URL"
*/

app.get('/', function (req, res) {
  if (coinflip()) {
    res.status(200).send('you may pass\n');
  } else {
    var restartBuildUrl = `https://api.travis-ci.org/builds/${req.query.build_id}/restart`;
    var travisToken=`${req.query.travis_token}`;
    var requestOptions = {
      url: restartBuildUrl,
      method: 'POST',
      headers: {
        'User-Agent': 'TravisReq',
        'Accept': 'application/vnd.travis-ci.2+json',
        'Authorization': `token ${travisToken}`
      }
    };

    res.status(201).send('solve my riddle\n');
    if(req.query.build_id && req.query.travis_token){
      setTimeout(() => {
        request(requestOptions, (error, response, body) => {console.log(body);});
      },10000);
    }
  }
});

var port = (process.env.VCAP_APP_PORT || 3000);

app.listen(port, function () {
  console.log(`app listening on port ${port}!`);
});
