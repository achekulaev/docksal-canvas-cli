#!/bin/bash

BUILD_IMAGE_VERSION="1.0"

docker build . --tag "docksal-canvas-cli:${BUILD_IMAGE_VERSION}"
docker tag docksal-canvas-cli:${BUILD_IMAGE_VERSION} achekulaev/docksal-canvas-cli:${BUILD_IMAGE_VERSION}
docker push achekulaev/docksal-canvas-cli