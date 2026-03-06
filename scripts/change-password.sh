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

read -s -p 'Password: ' PASSWORD
echo ''
read -s -p 'Repeat Password: ' REPEAT_PASSWORD
echo ''

if [ -z "$PASSWORD" ]; then
    echo 'No password set'
    exit 1
fi

if [ "$PASSWORD" != "$REPEAT_PASSWORD" ]; then
    echo 'Passwords do not match'
    exit 1
fi

if ! [ -d ./secrets ]; then
    mkdir ./secrets
    chmod 755 ./secrets
fi



echo "$(mkpasswd --method=scrypt "$PASSWORD")" > ./secrets/password
chmod 600 ./secrets/password
