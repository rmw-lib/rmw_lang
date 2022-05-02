#!/usr/bin/env zsh

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

./_dev.sh src/简体中文/命令行.coffee code/rmw -o code/js
