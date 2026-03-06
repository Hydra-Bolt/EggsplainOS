#!/usr/bin/env bash



###############
#### Setup ####
set -eu -o pipefail

cd "$(dirname "$BASH_SOURCE")"
cd ..



###############
#### Logic ####
if [ "$(id -u)" != 0 ]; then
    echo 'Run this script as root'
    exit 1
fi

if ! [ -r ./secrets/password ]; then
    echo 'No password file'
    exit 1
fi



nix flake update

nixos-rebuild switch \
    --impure \
    --flake "path:.#$(hostname)" \
    --show-trace
