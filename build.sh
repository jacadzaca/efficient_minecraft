#!/bin/bash
docker build --rm -t efficient-minecraft $(dirname $BASH_SOURCE) && docker run --name mc --rm efficient-minecraft