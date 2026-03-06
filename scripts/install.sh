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

hostname="$1"

if [ -z "$hostname" ]; then
    echo 'Please specify which host to install'
    exit 1
fi



bash ./scripts/change-password.sh

HASHED_PASSWORD="$(cat ./secrets/password)" nixos-install \
    --flake "path:.#$hostname" \
    --root /mnt
