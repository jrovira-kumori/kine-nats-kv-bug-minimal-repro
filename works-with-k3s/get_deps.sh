#!/usr/bin/env bash

GUM="/tmp/gum"
if ! [ -f "$GUM" ]; then
    id=$(docker create -q charmcli/gum:v0.13)
    docker cp -q $id:/usr/local/bin/gum $GUM
    docker rm -v $id >/dev/null
fi

