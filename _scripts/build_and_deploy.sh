#! /bin/bash

set -e

function main {
  setup_env
  clean
  fetch_current_site
  build
  test_html
  test_spec
  deploy
}

function setup_env {
  ENV_PATH="home"
  if [ "$TRAVIS_BRANCH" == "develop" ]; then
    ENV_PATH="staging-env"
  fi
  DEPLOY_REPO="https://${GH_TOKEN}@github.com/mujeresentecnologia/${ENV_PATH}.git"
}

function clean { 
	echo "cleaning _site folder"
	bundle exec rake clean
}

function fetch_current_site {
	echo "getting latest site"
	git clone $DEPLOY_REPO _site 
  cd _site
  git fetch origin gh-pages
  git checkout gh-pages
  cd ..
}

function build {
  echo "building"
  bundle exec rake build_page ENTORNO=$ENV_PATH
}

function test_html {
  echo "testing html"
  bundle exec rake test_html ENTORNO=$ENV_PATH
}

function test_spec {
  echo "testing spec"
  bundle exec rake test_spec ENTORNO=$ENV_PATH
}

function deploy {
  echo "deploying changes"

  if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
     echo "Finished! (we dont deploy pull requests anywhere, if you need to deploy on staging or prod you should merge this code into develop or master, respectively)"
      exit 0
  fi

  if [ "$TRAVIS_BRANCH" != "master" ] && [ "$TRAVIS_BRANCH" != "develop" ]; then
      echo "Finished! (we only publish the master and develop branches, if you need to deploy on staging or prod you should merge this code into develop or master, respectively)"
      exit 0
  fi

	cd _site
	git config --global user.name "Travis CI"
  git config --global user.email "travis@travis-ci.org"
	git add -A
	git status
	git commit -m "Latest site built on Travis build # $TRAVIS_BUILD_NUMBER; Generated from commit https://github.com/mujeresentecnologia/portal/commit/$TRAVIS_COMMIT"
	git push $DEPLOY_REPO gh-pages:gh-pages
}

main
