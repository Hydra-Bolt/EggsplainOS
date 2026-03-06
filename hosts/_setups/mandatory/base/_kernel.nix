{ ... }: {
    # Whether to prevent replacing the running kernel image
    security.protectKernelImage = true;

    # Disable kernel module loading once the system is fully initialised
    # Module loading is disabled until the next reboot
    security.lockKernelModules = false;

    # Whether to allow SMT/hyperthreading
    # Disabling SMT means that only physical CPU cores will be usable at
    #   runtime, potentially at significant performance cost
    # The primary motivation for disabling SMT is to mitigate the risk of
    #   leaking data between threads running on the same CPU core (due
    #   to e.g., shared caches
    security.allowSimultaneousMultithreading = true;

    # This option allows you to override the Linux kernel used by NixOS
    # Since things like external kernel module packages are tied to the
    #   kernel you're using, it also overrides those
    # boot.kernelPackages = pkgs.linuxPackages;
}
