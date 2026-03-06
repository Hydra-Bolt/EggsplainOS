#!/usr/bin/env bash



###############
#### Setup ####
set -eu -o pipefail



###############
#### Logic ####
if [ "$(id -u)" != 0 ]; then
    echo 'Run this script as root'
    exit 1
fi



nix-collect-garbage --delete-old
