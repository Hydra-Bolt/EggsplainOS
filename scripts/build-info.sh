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

nix build \
    --out-link ./cache/result \
    "path:.#nixosConfigurations.$(hostname).config.system.build.toplevel"

echo 'Searching for changes...'
nvd diff /run/current-system ./cache/result

echo 'Searching for vulnerabilities... '
vulnix ./cache/result
