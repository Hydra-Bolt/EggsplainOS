{ ... }: {
    # This file is a placeholder and should be updated with the output of `nixos-generate-config`
    imports = [];
    boot.initrd.availableKernelModules = [ ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    fileSystems."/" = { device = "/dev/placeholder"; fsType = "ext4"; };
}
