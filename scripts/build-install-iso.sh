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



# For flakes
nix run nixpkgs#nixos-generators -- \
    --format install-iso \
    --flake ./ \
    --out-link ./result

# For old-style configuration
# nix run nixpkgs#nixos-generators -- \
#     --format install-iso \
#     --configuration ./hosts/eggsplain-1/default.nix \
#     --out-link ./result
