#!/usr/bin/env bash

set -e
echo "Compiling $1"
tectonic $1

PUSH_OUTPUT=$(echo "$2" | tr '[:upper:]' '[:lower:]')

if [[ $PUSH_OUTPUT != "yes" ]]; then # Don't push PDF
  exit 0;
fi

OUTPUT_PDF="${1%.*}.pdf"

if [[ ${OUTPUT_PDF:0:1} == "/" ]]; then
  OUTPUT_PDF=${OUTPUT_PDF:1}
fi

FILE_NAME=$(basename $OUTPUT_PDF)
DIR=$(dirname $OUTPUT_PDF)

STATUSCODE=$(curl --silent --output resp.json --write-out "%{http_code}" -X GET -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/$DIR)

if [ $((STATUSCODE/100)) -ne 2 ]; then
  echo "Github's API returned $STATUSCODE"
  cat resp.json
  exit 22;
fi

SHA=""
for i in $(jq -c '.[]' resp.json);
do
    NAME=$(echo $i | jq -r .name)
    if [ "$NAME" = "$FILE_NAME" ]; then
        SHA=$(echo $i | jq -r .sha)
        break
    fi    
done

echo '{
  "message": "'"update $OUTPUT_PDF"'",
  "committer": {
    "name": "Tectonic Action",
    "email": "tectonic-action@github.com"
  },
  "content": "'"$(base64 -w 0 $OUTPUT_PDF)"'",
  "sha": "'$SHA'"
}' > payload.json

STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" \
            -i -X PUT -H "Authorization: token $GITHUB_TOKEN" -d @payload.json \
            https://api.github.com/repos/${GITHUB_REPOSITORY}/contents/${OUTPUT_PDF})

if [ $((STATUSCODE/100)) -ne 2 ]; then
  echo "Github's API returned $STATUSCODE"
  exit 22;
fi
