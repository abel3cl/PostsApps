#!/bin/bash
export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH"
TRAVIS_COMMIT_MESSAGE=`git log -n 1 --format=%B`
TRAVIS_LAST_COMMIT_MESSAGE=$(git log --pretty=%B -n 1 $TRAVIS_COMMIT)
BUILD_APP=$(git log --pretty=%B -n 1 $TRAVIS_COMMIT | grep -i '\#build\')

echo "Current branch: ${BRANCH}"
echo "Pull Request?: ${TRAVIS_PULL_REQUEST}"
echo "Travis Event Type: ${TRAVIS_EVENT_TYPE}"
echo "Travis commit message: ${TRAVIS_COMMIT_MESSAGE}"

bundle exec fastlane ios test
