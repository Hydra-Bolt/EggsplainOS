{ ... }: {
    boot.loader = {
        systemd-boot = {
            enable = true;

            # Whether to allow editing the kernel command-line before boot
            # It is recommended to set this to false, as it allows gaining root access by
            #   passing init=/bin/sh as a kernel parameter
            # However, it is enabled by default for backwards compatibility
            editor = false;
        };

        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
    };
}
