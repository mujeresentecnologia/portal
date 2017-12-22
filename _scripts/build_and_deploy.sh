#! /bin/bash

set -e

function main {
  setup_env
  # clean
  # fetch_current_site
  build_and_test
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

function build_and_test {
  echo "building and testing"
  bundle exec rake test ENTORNO=$ENV_PATH
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
  git remote remove origin
  git remote add origin $DEPLOY_REPO
  git checkout gh-pages

	git config --global user.name "Travis CI"
  git config --global user.email "travis@travis-ci.org" 
	git add -A
	git status
	git commit -m "Latest site built on Travis build: $TRAVIS_BUILD_NUMBER"
  git pull -r
	git push $DEPLOY_REPO gh-pages:gh-pages
}

main
