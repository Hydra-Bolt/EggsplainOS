{ config, lib, pkgs, username, ... }: {
    imports = [
        # Include the results of the hardware scan
        ./_hardware-configuration.nix

        # Mandatory
        ./../_setups/mandatory/base/default.nix
        ./../_setups/mandatory/bootloader/uefi.nix
        ./../_setups/mandatory/desktop/gnome-wayland.nix
        ./../_setups/mandatory/locale/stockholm.nix

        # Optional
        ./../_setups/optional/boot-logo
        ./../_setups/optional/blacklist-nouveau.nix
        ./../_setups/optional/docker.nix
        # ./../_setups/optional/latest-kernel.nix
        ./../_setups/optional/rustdesk.nix
        ./../_setups/optional/gpu-stabilizer.nix
        ./../_setups/optional/ssh-server.nix
        ./../_setups/optional/ssh-tunnels.nix
    ];

    # Networking
    networking.hostName = "eggsplain-subs-nv-2";

    # License acceptance required for proprietary NVIDIA driver
    nixpkgs.config.nvidia.acceptLicense = true;

    # NVIDIA Blackwell Specifics
    services.xserver.videoDrivers = [ "nvidia" ];
    
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        open = true; # Required for Blackwell
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    
    hardware.nvidia-container-toolkit.enable = true;

    # SSH Tunnels
    services.ssh-tunnels = {
        enable = true;
        tunnels = {
            prod = {
                description = "Reverse SSH Tunnel to Prod VPS (Port 8889)";
                remoteForward = "0.0.0.0:8889:localhost:22";
                vpsHost = "72.60.35.185";
                vpsUser = "root";
                user = username;
                sshKeyPath = "/home/${username}/.ssh/id_ed25519";
            };
            staging = {
                description = "Reverse SSH Tunnel to Staging VPS (Port 8889)";
                remoteForward = "0.0.0.0:8889:localhost:22";
                vpsHost = "31.97.78.33";
                vpsUser = "root";
                user = username;
                sshKeyPath = "/home/${username}/.ssh/id_ed25519";
            };
        };
    };

    # Users
    users.users."${username}" = {
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINq7hHj4OvcIIFVvs56BchBuG4UIMwOWe2HJoGvoOgti contact@eggsplain.com"
        ];
    };

    # Printing
    services.printing.enable = true;

    # Keyboard and Console
    services.xserver.xkb.layout = lib.mkForce "se";
    services.xserver.xkb.variant = lib.mkForce "";
    console.keyMap = "sv-latin1";

    # System Version
    system.stateVersion = "25.11";

    # Disable GNOME suspend to prevent lockups on idle
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
}
