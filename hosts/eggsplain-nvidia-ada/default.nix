{ config, lib, pkgs, username, ... }: {
    imports = [
        ./_hardware-configuration.nix

        ./../_setups/mandatory/base
        ./../_setups/mandatory/bootloader/uefi.nix
        ./../_setups/mandatory/desktop/gnome-xorg.nix
        ./../_setups/mandatory/locale/english.nix

        ./../_setups/optional/boot-logo
        ./../_setups/optional/nvidia+blacklist-nouveau.nix
        ./../_setups/optional/docker.nix
        ./../_setups/optional/ssh-server.nix
        ./../_setups/optional/ssh-tunnels.nix
        ./../_setups/optional/gpu-stabilizer.nix
        ./../_setups/optional/firefox-simple.nix
        ./../_setups/optional/rustdesk.nix
        ./../_setups/optional/sudo-nopasswd.nix
    ];

    networking.hostName = "eggsplain-nvidia-ada";

    # Nvidia Container Toolkit
    hardware.nvidia-container-toolkit.enable = true;

    # Keyboard and Console
    services.xserver.xkb.layout = lib.mkForce "se";
    services.xserver.xkb.variant = lib.mkForce "";
    console.keyMap = "sv-latin1";

    # SSH Tunnels
    services.ssh-tunnels = {
        enable = true;
        tunnels = {
            prod = {
                description = "Reverse SSH Tunnel to Prod VPS";
                remoteForward = "0.0.0.0:8892:localhost:22";
                vpsHost = "72.60.35.185";
            };
            staging = {
                description = "Reverse SSH Tunnel to Staging VPS";
                remoteForward = "0.0.0.0:8892:localhost:22";
                vpsHost = "31.97.78.33";
            };
        };
    };

    # Sudo
    security.sudo-nopasswd.enable = true;

    # OCI Backend (defaults to podman in some setups)
    virtualisation.oci-containers.backend = "docker";

    # State Version
    system.stateVersion = "25.11";
}
