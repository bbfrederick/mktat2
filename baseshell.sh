#!/bin/bash

DATADIR=/Users/frederic/code/rapidtide/rapidtide/data/examples

VERSION=latest

docker pull --platform linux/amd64 fredericklab/neurodockerbase:${VERSION}
docker run \
    -it fredericklab/neurodockerbase:${VERSION} \
    bash
