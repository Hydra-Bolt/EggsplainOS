#!/usr/bin/env bash



###############
#### Setup ####
set -eu -o pipefail
shopt -s dotglob nullglob globstar



##############
### Logic ####
verbose=0
encrypt=false
device=''

while :; do
    case "$1" in
        -h|-\?|--help)
            echo '-h, -?, --help        - Display this help message'
            echo '-v, --verbose         - Increase verbosity'
            echo '-e, --encrypt         - Encrypt primary partition'
            echo '-d, --device          - Storage device to use'
            exit 0
            ;;
        -v|--verbose)
            verbose="$((verbose + 1))"
            ;;
        -e|--encrypt)
            encrypt=true
            ;;
        -d|--device)
            device="$(realpath -m "$2")"
            ;;
        --)
            # End of all options
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)
            # Default case
            # No more options, so break out of the loop
            break
    esac
    shift
done



echo "The following device will be used: '$device'"
echo ''
if [[ "$encrypt" == true ]]; then
    echo 'Primary partition will be encrypted'
    echo ''
fi
read -p 'Continue? (Y/N): ' confirm && [[ "${confirm}" == [yY] || "${confirm}" == [yY][eE][sS] ]] || exit 1



if [ "$(id -u)" != 0 ]; then
    echo 'Run this script as root'
    exit 1
fi



echo "Formatting `$device`..."
parted "$device" -- mklabel gpt



echo 'Creating boot partition...'
parted "$device" -- mkpart ESP fat32 1MiB 1GiB
parted "$device" -- set 1 boot on
mkfs.vfat "$device"1



echo 'Creating primary partition (`nixos`)...'
parted "$device" -- mkpart nixos 1GiB 100%

if [[ "$encrypt" == true ]]; then
    echo 'Encrypting `nixos` partition...'
    cryptsetup luksFormat "$device"2

    echo 'Openning `nixos` partition as `nixos-decrypted`...'
    cryptsetup luksOpen "$device"2 nixos-decrypted
fi



if [[ "$encrypt" == true ]]; then
    echo 'Formatting `nixos-decrypted` as ext4...'
    mkfs.ext4 /dev/mapper/nixos-decrypted
else
    echo "Formatting `${device}2` as ext4..."
    mkfs.ext4 "$device"2
fi



if [[ "$encrypt" == true ]]; then
    echo 'Mounting `nixos-decrypted`'
    mount /dev/mapper/nixos-decrypted /mnt
else
    echo "Mounting `${device}2`"
    mount "$device"2 /mnt
fi



echo "Mounting partition 'boot'..."
mkdir /mnt/boot
mount "$device"1 /mnt/boot



echo 'Generating nixos configs...'
nixos-generate-config --root /mnt



echo 'Done'
echo ''
echo "Copy nixos configs in '/mnt/etc/nixos' and run the install script (the install script must be run from /mnt/etc/nixos dir)"
