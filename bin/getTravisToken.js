
var request=require('request');

var GITHUB_TOKEN = process.env.GITHUB_TOKEN;
var options = {
  url: `https://api.travis-ci.org/auth/github?github_token=${GITHUB_TOKEN}`,
  method: 'POST',
  headers: {
    'User-Agent': 'TravisReq',
    'Accept': 'application/vnd.travis-ci.2+json'
  }
};

request(options, function (error, response, body) {
  if (!error && response.statusCode == 200) {
    let authObj=JSON.parse(body);
    console.log(authObj.access_token);
  }
  else {
    console.log(response.statusCode);
  }
})
