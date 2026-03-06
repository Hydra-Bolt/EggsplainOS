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



# Build using the native builder
# nix build ".#nixosConfigurations.$(hostname).config.system.build.isoImage"

# Build using nixos-generators
# For flakes
nix run nixpkgs#nixos-generators -- \
    --format iso \
    --flake ./ \
    --out-link ./result

# For old-style configuration
# nix run nixpkgs#nixos-generators -- \
#     --format iso \
#     --configuration ./hosts/eggsplain-1/default.nix \
#     --out-link ./result
