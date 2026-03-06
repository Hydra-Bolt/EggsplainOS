# Source:
#   - <https://askubuntu.com/questions/5417/how-to-get-the-gpu-info>
# Check video drivers:
#   - `lspci | grep ' VGA ' | cut -d" " -f 1 | xargs -i lspci -v -s {}`
# Check active GPU drivers:
#   - `glxinfo | grep -e OpenGL.vendor -e OpenGL.renderer`



{ config, pkgs, ... }: {
    imports = [
        ./blacklist-nvidia.nix
    ];

    services.xserver.videoDrivers = [ "nouveau" ];

    # Add Nouveau kernel modules manually
    boot = {
        # To check loaded modules: `cat /etc/modules-load.d/nixos.conf`
        kernelModules = [ "nouveau" ];
    };

    hardware.graphics = {
        enable = true;
        # enable32Bit = true;
        extraPackages = with pkgs; [
            # Packages needed for Nouveau acceleration
            # Mesa for OpenGL
            mesa
        ];
    };
}
