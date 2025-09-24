#!/bin/sh

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

set -e

cleanup() {
  rm -rf "$FOLDER_NAME"
}

if [ "$#" -eq 2 ] 
then
  echo "Logging into Docker: $DOCKER_USER"
  echo "$DOCKER_PWD" | docker login --username "$DOCKER_USER" --password-stdin

  GITHUB_REPO="$1"
  DOCKER_REPO="$2"
  FOLDER_NAME=$(basename "$GITHUB_REPO")

  echo "Cloning Git repo: git@github.com:$GITHUB_REPO.git"
  git clone "https://github.com/$GITHUB_REPO"
  
  echo "cd into cloned repo folder: $FOLDER_NAME"
  cd "$FOLDER_NAME"

  echo "Building Docker image: $DOCKER_REPO"
  docker build . -t "$DOCKER_REPO"

  echo "Pushing image to Docker Hub: $DOCKER_REPO"
  docker push "$DOCKER_REPO"
  
  trap cleanup EXIT
else
  for arg in "$@" 
  do
    echo "$arg"
  done
  echo "Usage: $0 <github_user/repo_name> <dockerhub_user/repo_name>"
  exit 1
fi
