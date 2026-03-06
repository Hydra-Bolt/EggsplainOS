{ config, pkgs, username, ... }: {
    imports = [
        ./_hardware-configuration.nix

        ./../_setups/mandatory/base
        ./../_setups/mandatory/bootloader/uefi.nix
        ./../_setups/mandatory/desktop/gnome-xorg.nix
        ./../_setups/mandatory/locale/stockholm.nix

        ./../_setups/optional/boot-logo
        ./../_setups/optional/amdgpu+blacklist-radeon.nix
        ./../_setups/optional/docker.nix
        ./../_setups/optional/firefox-simple.nix
        ./../_setups/optional/rustdesk.nix
        ./../_setups/optional/ssh-tunnels.nix
        ./../_setups/optional/dokploy.nix
        ./../_setups/optional/sudo-nopasswd.nix
        ./../_setups/optional/latest-kernel.nix
    ];

    networking.hostName = "eggsplain-amd-2";

    # SSH Tunnels
    services.ssh-tunnels = {
        enable = true;
        tunnels = {
            prod = {
                description = "Reverse SSH Tunnel to Prod VPS";
                remoteForward = "0.0.0.0:8890:localhost:22";
                vpsHost = "72.60.35.185";
            };
            staging = {
                description = "Reverse SSH Tunnel to Staging VPS";
                remoteForward = "0.0.0.0:8890:localhost:22";
                vpsHost = "31.97.78.33";
            };
        };
    };

    # Dokploy
    services.dokploy.enable = true;

    # Sudo
    security.sudo-nopasswd.enable = true;

    # System Packages
    environment.systemPackages = with pkgs; [
        vim
        wget
        git
        nodejs
        vscode
        firefox
        rustdesk
    ];

    # User Account (partially handled by base but extending with packages)
    users.users.${username} = {
        packages = with pkgs; [
            rustdesk
            vscode
            nodejs
            git
            firefox
        ];
    };

    # OCI Backend
    virtualisation.oci-containers.backend = "docker";

    # State Version
    system.stateVersion = "25.11";
}
