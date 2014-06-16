#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
rsync -avP ../devel/ ./
sed -i 's/debian:experimental/ubuntu:trusty/g' Dockerfile
sed -i 's!http://http.debian.net/debian sid main!http://archive.ubuntu.com/ubuntu/ trusty main!g' Dockerfile
