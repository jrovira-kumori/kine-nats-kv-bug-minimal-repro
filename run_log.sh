#!/usr/bin/env bash
cd $(dirname "$0")
NAME=${NAME:-kind}

echo ""
set -x
while true; do
    CONTAINER_ID=$(docker exec $NAME-control-plane crictl ps -q --image a2336270923ab)
    docker exec $NAME-control-plane crictl logs -f $CONTAINER_ID
    sleep 1
done