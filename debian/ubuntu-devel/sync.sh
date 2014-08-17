#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
rsync -avP ../devel/ ./
# TODO swap this for :devel (https://github.com/docker/stackbrew/pull/165)
sed -i 's/debian:experimental/ubuntu-debootstrap:utopic/g' Dockerfile
