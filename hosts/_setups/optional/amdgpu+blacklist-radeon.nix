# Source:
#   - <https://wiki.nixos.org/wiki/AMD_GPU>



{ config, lib, pkgs, ... }: {
    imports = [
        ./blacklist-radeon.nix
    ];

    services.xserver.videoDrivers = [ "amdgpu" ];

    # Whether to enable AMDVLK Vulkan driver
    hardware.amdgpu.amdvlk.enable = lib.mkDefault true;

    # Add amdgpu kernel modules manually
    boot = {
        # To check loaded modules: `cat /etc/modules-load.d/nixos.conf`
        kernelModules = [
            "amdgpu"
        ];

        # Force support of vulkan (by default support is disabled and kernel will switch to `radeon` module)
        kernelParams = [
            # For Southern Islands (SI i.e. GCN 1) cards
            "radeon.si_support=0"
            "amdgpu.si_support=1"

            # For Sea Islands (CIK i.e. GCN 2) cards
            "radeon.cik_support=0"
            "amdgpu.cik_support=1"
        ];
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            mesa                        # Open source 3D graphics library
            rocmPackages.clr.icd        # ROCm OpenCL runtime (ICD loader)
        ];
    };

    # ROCm compute stack — needed for /dev/kfd access from Docker containers
    hardware.amdgpu.opencl.enable = true;

    environment.systemPackages = with pkgs; [
        mesa                            # Open source 3D graphics library
        rocmPackages.rocm-runtime       # HSA/ROCm userspace runtime (/dev/kfd)
        rocmPackages.rocm-smi-lib       # GPU monitoring (rocm-smi CLI)
    ];
}
