#!/bin/sh

# Based on script from https://github.com/rancher/os/issues/706

DOCKER_PLUGINS=/etc/docker/plugins

if [ -z $@ ]; then
    if [ ! -d $DOCKER_PLUGINS ]; then
        mkdir -p $DOCKER_PLUGINS
    fi
    echo "unix:///var/run/convoy/convoy.sock" > $DOCKER_PLUGINS/convoy.spec

    if [ ! -d $DOCKER_VOLUMES ]; then
        mkdir -p $DOCKER_VOLUMES
    fi
    CMD="daemon --drivers vfs --driver-opts vfs.path=$DOCKER_VOLUMES"
else
    CMD=$@
fi

exec /usr/bin/convoy $CMD
