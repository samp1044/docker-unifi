#!/bin/sh

DOCKERFILE="$1"
CONTEXT="$2"

docker build --no-cache --pull -t unifi -f "$DOCKERFILE" "$CONTEXT"
