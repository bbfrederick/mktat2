#!/bin/bash

VERSION=latest

docker pull --platform linux/amd64 fredericklab/tat2:${VERSION}
docker run \
    -it fredericklab/tat2:${VERSION} \
    bash
