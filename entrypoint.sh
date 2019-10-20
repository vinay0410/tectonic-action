#!/bin/sh -l

echo "Compiling $1"
tectonic $1

curl -i -X PUT -H "Authorization: token $ACTIONS_RUNTIME_TOKEN" -d '{
  "message": "update resume",
  "committer": {
    "name": "Vinay Sharma",
    "email": "vinay0410@github.com"
  },
  "content": "'"$(base64 -w 0 myResume.pdf)"'",
  "sha": '$(curl -X GET https://api.github.com/repos/vinay0410/webpage/contents/resume/myResume.pdf | jq .sha)'
}' https://api.github.com/repos/vinay0410/webpage/contents/resume/myResume.pdf
