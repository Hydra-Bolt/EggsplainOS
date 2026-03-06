{ config, pkgs, username, ... }: {
    imports = [
        ./_hardware-configuration.nix

        ./../_setups/mandatory/base
        ./../_setups/mandatory/bootloader/uefi.nix
        ./../_setups/mandatory/desktop/gnome-xorg.nix
        ./../_setups/mandatory/locale/english.nix

        ./../_setups/optional/boot-logo
        # ./../_setups/optional/home-manager
        # ./../_setups/optional/home-manager/build-iso/cd-dvd.nix
        ./../_setups/optional/auto-login.nix
        ./../_setups/optional/amdgpu+blacklist-radeon.nix
        ./../_setups/optional/docker.nix
        ./../_setups/optional/firefox-simple.nix
        ./../_setups/optional/rustdesk.nix
    ];

    networking.hostName = "eggsplain-amd-2";

    services.teamviewer.enable = true;

    # This defaults to podman
    virtualisation.oci-containers.backend = "docker";

    virtualisation.oci-containers.containers = {};

    environment.systemPackages = with pkgs; [
        teamviewer
        anydesk
        vscode
    ];
}
