#!/bin/bash

function docker_build_base {
    if [ -z "$RESTRICT" -o "$RESTRICT" = "$1" ]; then
        echo "Build base container $1"
        cd $1
        docker build -t $1:latest -t bergamotmonitoring/$1:latest .
        docker push bergamotmonitoring/$1:latest
        cd .
    else
        echo "Skipping build of $1"
    fi
}

function docker_build_app {
    if [ -z "$RESTRICT" -o "$RESTRICT" = "$1" ]; then
        echo "Building application container $1 version $HCR_VERSION"
        cd $1
        docker build --build-arg hcr_version=$HCR_VERSION -t $1:$HCR_VERSION -t bergamotmonitoring/$1:$HCR_VERSION .
        docker push bergamotmonitoring/$1:$HCR_VERSION
        cd ..
    else
        echo "Skipping build of $1"
    fi
}

# Version to build
export HCR_VERSION=${1:-0.0.3}
echo "Building Docker images for HCR ${HCR_VERSION}"

# Only build one image
export RESTRICT=$2

# Build the base image
docker_build_base bergamot-base

# Build HCR
docker_build_app hcr
