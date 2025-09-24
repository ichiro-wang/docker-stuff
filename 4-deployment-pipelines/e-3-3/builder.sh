#!/bin/sh

RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

set -e

if [ "$#" -eq 2 ] 
then
  GITHUB_REPO="$1"
  DOCKER_REPO="$2"

  echo "${CYAN}Cloning Git repo: git@github.com:$GITHUB_REPO.git${NC}"
  git clone "git@github.com:$GITHUB_REPO.git"
  
  FOLDER_NAME=$(basename "$GITHUB_REPO")
  echo "${CYAN}cd into cloned repo folder: $FOLDER_NAME${NC}"
  cd "$FOLDER_NAME"

  echo "${CYAN}Building Docker image: $DOCKER_REPO${NC}"
  docker build . -t "$DOCKER_REPO"

  echo "${CYAN}Pushing image to Docker Hub: $DOCKER_REPO${NC}"
  docker push "$DOCKER_REPO"
else
  echo "${RED}Usage: $0 <github_user/repo_name> <dockerhub_user/repo_name>${NC}"
  exit 1
fi
