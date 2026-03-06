{ config, lib, pkgs, ... }: {
    imports = [
        ./blacklist-nouveau.nix
    ];

    # Nvidia license agreement
    nixpkgs.config.nvidia.acceptLicense = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    # Add nvidia kernel modules manually
    boot = {
        # To check loaded modules: `cat /etc/modules-load.d/nixos.conf`
        kernelModules = [
            "nvidia"
            "nvidiafb"
            "nvidia_drm"
            "nvidia_modeset"
            "nvidia_uvm"
        ];

        kernelParams = [
            "nvidia_drm.fbdev=1"
            "nvidia_drm.modeset=1"
            # "nvidia.NVreg_CheckPCIConfigSpace=0"
            # "nvidia.NVreg_EnablePCIeGen3=1"
            # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
            # "nvidia.NVreg_UsePageAttributeTable=1"
        ];
        extraModprobeConfig = ''
            options nvidia-drm fbdev=1 modeset=1
        '';
        extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];
    };

    hardware.nvidia = {
        # Optionally, you may need to select the appropriate driver version for your specific GPU
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        # Nvidia power management
        # Experimental, and can cause sleep/suspend to fail
        # Enable this if there are graphical corruption issues or application crashes after waking
        #   up from sleep. This fixes it by saving the entire VRAM memory to `/tmp/` instead
        #   of just the bare essentials
        powerManagement = {
            enable = false;

            # Fine-grained power management
            # Turns off GPU when not in use
            # Experimental and only works on modern Nvidia GPUs (Turing or newer)
            finegrained = false;
        };

        # Modesetting is required
        # Enabling this and using version 545 or newer of the proprietary NVIDIA
        #   driver causes it to provide its own framebuffer device, which can
        #   cause wayland compositors to work when they otherwise wouldn’t
        modesetting.enable = lib.versionAtLeast config.hardware.nvidia.package.version "535";

        # Use the Nvidia open source kernel module (not to be confused with the
        #   independent third-party "nouveau" open source driver)
        # Support is limited to the Turing and later architectures
        # Full list of supported GPUs is at:
        #   - https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Do not disable this unless your GPU is unsupported or if you have a good reason to
        open = lib.versionOlder config.hardware.nvidia.package.version "516";

        # Enable the Nvidia settings menu, accessible via `nvidia-settings`
        nvidiaSettings = true;
    };

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            egl-wayland
            glxinfo                     # Test utilities for OpenGL
            libdrm                      # Direct Rendering Manager library and headers
            libGL
            libglvnd                    # The GL Vendor-Neutral Dispatch library
            libva                       # An implementation for VA-API (Video Acceleration API)
            libva-utils                 # A collection of utilities and examples for VA-API
            libvdpau                    # Library to use the Video Decode and Presentation API for Unix (VDPAU)
            libvdpau-va-gl              # VDPAU driver with OpenGL/VAAPI backend
            mesa                        # Open source 3D graphics library
            nvidia-vaapi-driver         # A VA-API implementation using NVIDIA's NVDEC
            nvitop
            nvtopPackages.full
            vaapiVdpau                  # VDPAU driver for the VA-API library
            vdpauinfo                   # Tool to query VDPAU abilities of the system
            vulkan-extension-layer      # Layers providing Vulkan features when native support is unavailable
            vulkan-loader               # LunarG Vulkan loader
            vulkan-tools                # Khronos official Vulkan Tools and Utilities
            vulkan-tools-lunarg         # LunarG Vulkan Tools and Utilities
            vulkan-validation-layers    # Official Vulkan validation layers
            wgpu-utils
        ];
    };

    environment.systemPackages = with pkgs; [
        egl-wayland
        glxinfo                     # Test utilities for OpenGL
        libdrm                      # Direct Rendering Manager library and headers
        libGL
        libglvnd                    # The GL Vendor-Neutral Dispatch library
        libva                       # An implementation for VA-API (Video Acceleration API)
        libva-utils                 # A collection of utilities and examples for VA-API
        libvdpau                    # Library to use the Video Decode and Presentation API for Unix (VDPAU)
        libvdpau-va-gl              # VDPAU driver with OpenGL/VAAPI backend
        mesa                        # Open source 3D graphics library
        nvidia-vaapi-driver         # A VA-API implementation using NVIDIA's NVDEC
        nvitop
        nvtopPackages.full
        vaapiVdpau                  # VDPAU driver for the VA-API library
        vdpauinfo                   # Tool to query VDPAU abilities of the system
        vulkan-extension-layer      # Layers providing Vulkan features when native support is unavailable
        vulkan-loader               # LunarG Vulkan loader
        vulkan-tools                # Khronos official Vulkan Tools and Utilities
        vulkan-tools-lunarg         # LunarG Vulkan Tools and Utilities
        vulkan-validation-layers    # Official Vulkan validation layers
        wgpu-utils
    ];
}
