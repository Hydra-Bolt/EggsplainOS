# To check blacklisted modules: `cat /etc/modprobe.d/nixos.conf`



{ config, ... }: {
    boot.blacklistedKernelModules = [
        "radeon"
    ];
}
