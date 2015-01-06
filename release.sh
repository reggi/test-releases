#!/bin/bash

VERSION=$1
APP_NAME="Holstee"
APP_NAME_LOWERCASE=`echo $APP_NAME | tr '[:upper:]' '[:lower:]'`

export GITHUB_TOKEN=e1ee771642938433c8215a48e034173fa7b4016b
export GITHUB_USER=reggi
export GITHUB_REPO=test-releases

#LATEST_VERSION=`git log --pretty="format:%d" | head -n2 | tail -n1 | sed 's/[()]//g' | sed  's ......  '`
#LATEST_VERSION=`git for-each-ref --format='%(*committerdate:raw)%(committerdate:raw) %(refname)' | sort -n | awk '{ print $4, $3; }' | sed "refs/heads/master" | tail -r | head -n3 | tail -n1 | sed -E -l -e 's/....\/....\/(.+)/\1/'`
LATEST_VERSION=`git describe --tags`

git tag $VERSION
git push --tags

echo $LATEST_VERSION
echo $VERSION

#CHANGELOG=`git log --pretty=oneline ^$LATEST_VERSION $VERSION | sed -E -l -e 's/........................................ (.+)/* \1/'`
CHANGELOG=`git log --pretty=format:%s $LATEST_VERSION...$VERSION | sed -E -l -e 's/(.+)/* \1/'`

echo $CHANGELOG

github-release release \
  --tag $VERSION \
  --name $APP_NAME" "$VERSION \
  --description "$CHANGELOG" \

github-release upload \
  --tag $VERSION \
  --name $APP_NAME_LOWERCASE"-"$VERSION \
  --file releases/$APP_NAME_LOWERCASE"-"$VERSION.zip \
