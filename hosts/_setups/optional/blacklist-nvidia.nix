# To check blacklisted modules: `cat /etc/modprobe.d/nixos.conf`



{ config, ... }: {
    boot.blacklistedKernelModules = [
        "nvidia"
        "nvidiafb"
        "nvidia_drm"
        "nvidia_modeset"
        "nvidia_uvm"
    ];
}
