#! /bin/bash

set -e

function main {
  setup_env
  clean
  get_current_site
	build_site
  test_html
  deploy
}

function setup_env {
  CONFIG_FILES="_config.yml"
  ENV_PATH="home"
  if [ "$TRAVIS_BRANCH" == "develop" ]; then
    CONFIG_FILES="_config.yml,_config-staging.yml"
    ENV_PATH="staging-env"
  fi
  DEPLOY_REPO="https://${GH_TOKEN}@github.com/mujeresentecnologia/${ENV_PATH}.git"
}

function clean { 
	echo "cleaning _site folder"
	if [ -d "_site" ]; then rm -Rf _site; fi 
}

function get_current_site { 
	echo "getting latest site"
	git clone $DEPLOY_REPO _site 
  cd _site
  git fetch origin gh-pages
  git checkout gh-pages
  cd ..
}

function build_site { 
	echo "building site"
	bundle exec jekyll build --config $CONFIG_FILES
}

function test_html {
  bundle exec rake test
}

function deploy {
  echo "deploying changes"

  if [ -z "$TRAVIS_PULL_REQUEST" ]; then
     echo "except don't publish site for pull requests"
      exit 0
  fi

  if [ "$TRAVIS_BRANCH" != "master" ] && [ "$TRAVIS_BRANCH" != "develop" ]; then
      echo "we should only publish the master or develop branch. Stopping here."
      exit 0
  fi

	cd _site
	git config --global user.name "Travis CI"
  git config --global user.email "travis@travis-ci.org" 
	git add -A
	git status
	git commit -m "Latest site built on Travis build: $TRAVIS_BUILD_NUMBER"
	git push $DEPLOY_REPO gh-pages:gh-pages
}

main