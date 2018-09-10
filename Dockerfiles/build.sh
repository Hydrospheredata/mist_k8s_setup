#!/bin/sh

SRC_DIR="mist"
if [ ! -d $SRC_DIR ]; then
  echo "Checkout and bulding mist"
  git clone git@github.com:Hydrospheredata/mist.git mist
  cd mist
  sbt basicStage
  cd ..
fi

ORG=$1
NAME=$2
TAG=$3

if [ -z $ORG ]; then
  echo "It's required to provide organization name for docker image"
  exit 1
fi

if [ -z $NAME ]; then
  echo "It's required to provide image name for docker image"
  exit 1
fi

if [ -z $TAG ]; then
  echo "It's required to provide tag for docker image"
  exit 1
fi

echo "Building image: $ORG/$NAME:$TAG"
docker build -t "$ORG/$NAME:$TAG" . -f Dockerfile_mist
