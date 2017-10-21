#!/bin/bash

function docker_build_base {
    if [ -z "$RESTRICT" -o "$RESTRICT" = "$1" ]; then
        echo "Build base container $1"
        cd $1
        docker build --no-cache $DOCKER_OPTS -t $1:latest -t bergamotmonitoring/$1:latest .
        docker push bergamotmonitoring/$1:latest
        cd .
    else
        echo "Skipping build of $1"
    fi
}

function docker_build_util {
    if [ -z "$RESTRICT" -o "$RESTRICT" = "$1" ]; then
        echo "Building util container $1"
        cd $1
        docker build --no-cache $DOCKER_OPTS -t $1:latest -t bergamotmonitoring/$1:latest .
        docker push bergamotmonitoring/$1:latest
        cd ..
    else
        echo "Skipping build of $1"
    fi
}

function docker_build_app {
    if [ -z "$RESTRICT" -o "$RESTRICT" = "$1" ]; then
        echo "Building application container $1 version $BERGAMOT_VERSION"
        cd $1
        docker build --no-cache $DOCKER_OPTS --build-arg bergamot_version=$BERGAMOT_VERSION -t $1:$BERGAMOT_VERSION -t bergamotmonitoring/$1:$BERGAMOT_VERSION .
        docker push bergamotmonitoring/$1:$BERGAMOT_VERSION
        cd ..
    else
        echo "Skipping build of $1"
    fi
}

# Version to build
export BERGAMOT_VERSION=${1:-2.0.0}
echo "Building Docker images for Bergamot ${BERGAMOT_VERSION}"

# Only build one image
export RESTRICT=$2

# Build the base image
docker_build_base bergamot-base

# Build our support images
#docker_build_util bergamot-postgresql
#docker_build_util bergamot-rabbitmq

# Build the CLI
#docker_build_app bergamot-cli

# Build the UI
docker_build_app bergamot-ui
docker_build_app bergamot-ui-nginx
docker_build_app bergamot-ui-nginx-https

# Build the agent manager
docker_build_app bergamot-agent-manager

# Build the notifiers
docker_build_app bergamot-notifier-email
docker_build_app bergamot-notifier-sms
docker_build_app bergamot-notifier-webhook
docker_build_app bergamot-notifier-slack

# Build the workers
docker_build_app bergamot-worker-agent
docker_build_app bergamot-worker-dummy
docker_build_app bergamot-worker-http
docker_build_app bergamot-worker-jdbc
docker_build_app bergamot-worker-jmx
docker_build_app bergamot-worker-nagios
docker_build_app bergamot-worker-snmp
docker_build_app bergamot-worker-ssh
