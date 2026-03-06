# To check blacklisted modules: `cat /etc/modprobe.d/nixos.conf`



{ config, ... }: {
    # boot.extraModprobeConfig = ''
    #     blacklist nouveau
    #     options nouveau modeset=0
    # '';

    boot.blacklistedKernelModules = [
        "nouveau"
    ];
}
