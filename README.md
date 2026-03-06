# File Structure

How to read the file structure.

Files starting with `_`, for example `_audio.nix` and `_kernel.nix` are files that can only be imported in files located in the same directory.

Files that don't start `_` can be imported from outside their directory.

You can think of this as private and public markers for files.

# Usage

You can use the bash scripts in the `scripts` directory.

```
$ cd [project directory]
# bash ./scripts/[task you want to do]
```

# Installation

### Option 1 - Installing from official NixOS ISO

- Format bootable USB with whatever tool you prefer
- Boot into USB
- Clone this repository anywhere
- Open a terminal in that directory
- Setup partitions:
    - Run `sudo bash ./scripts/setup-partitions-ext4-nvme.sh -d /dev/nvme[...]` in order to setup partitions on an NVMe device
    - Or run `sudo bash ./scripts/setup-partitions-ext4.sh -d /dev/sd[...]` for HDD or SSD
- Copy configuration: `cp -r . /mnt/etc/nixos`
- `cd /mnt/etc/nixos`
- Choose hostname to install (available hosts are listed inside the `hosts` directory, excluding `_setups`)
- Install: `sudo bash ./scripts/install.sh [hostname you picked]`:
    - Before the installation begins the install script will prompt you to setup a password for the user
    - You can ignore the password prompt at the end of the installation
- Shutdown
- Take out USB
- Power on

### Option 2 - Installing custom NixOS ISO

- Boot into USB
- Open a terminal
- `cd ~/NixOS`
- Setup partitions:
    - Run `sudo bash ./scripts/setup-partitions-ext4-nvme.sh -d /dev/nvme[...]` in order to setup partitions on an NVMe device
    - Or run `sudo bash ./scripts/setup-partitions-ext4.sh -d /dev/sd[...]` for HDD or SSD
- Copy configuration: `cp -rL . /mnt/etc/nixos` (Notice the `-L` flag. This is because the configs are symlinked to a location inside `/nix/store`)
- `cd /mnt/etc/nixos`
- Choose hostname to install (available hosts are listed inside the `hosts` directory, excluding `_setups`)
- Install: `sudo bash ./scripts/install.sh [hostname you picked]`:
    - Before the installation begins the install script will prompt you to setup a password for the user
    - You can ignore the password prompt at the end of the installation
- Shutdown
- Take out USB
- Power on

# Building Custom ISO

- Choose a hostname from `hosts` directory (excluding `_setups`)
- Set hostname: `sudo hostname [hostname you picked]`
- Temporary enable home-manager:
    - Go inside chosen host and open `default.nix`
    - Import `./../_setups/optional/home-manager`
- Temporary enable boot-iso nix config:
    - Go inside chosen host and open `default.nix`
    - Import `./../_setups/optional/home-manager/build-iso/cd-dvd.nix`
- Should look something like this:
```
{ config, pkgs, username, ... }: {
    imports = [
        ./_hardware-configuration.nix

        ./../_setups/mandatory/base
        ./../_setups/mandatory/bootloader/uefi.nix
        ./../_setups/mandatory/desktop/gnome.nix
        ./../_setups/mandatory/locale/english.nix

        ######### Added lines ###########
        ./../_setups/optional/home-manager
        ./../_setups/optional/home-manager/build-iso/cd-dvd.nix
        #################################

        # ...
    ];

    # ...
}
```
- Run `sudo bash ./scripts/build-iso.sh` to build the ISO file:
    - The output will be in a `result` directory at the root of this project
    - The ISO file should be located here: `[project root]/result/iso/nixos-minimal-[...].iso`
- Use whatever tool you want to format your USB with this ISO
