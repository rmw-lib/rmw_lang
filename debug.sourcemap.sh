#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

cd code
open http://127.0.0.1:2022
caddy file-server -listen 0.0.0.0:2022 -browse
