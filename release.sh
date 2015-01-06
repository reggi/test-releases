#!/bin/bash

VERSION=$1
APP_NAME=WheatPaste
APP_NAME_LOWERCASE= $APP_NAME | tr '[:upper:]' '[:lower:]'
export GITHUB_TOKEN=e1ee771642938433c8215a48e034173fa7b4016b
export GITHUB_USER=reggi
export GITHUB_REPO=test-releases

git tag $VERSION
git push --tags

github-release release \
  --tag $VERSION \
  --name $APP_NAME $VERSION \
  --description Enancements \

github-release upload \
  --tag $VERSION \
  --name $APP_NAME_LOWERCASE_$VERSION.zip \
  --file releases/$APP_NAME_LOWERCASE_$VERSION.zip \
