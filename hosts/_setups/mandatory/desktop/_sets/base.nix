{ pkgs, ... }: {
    # Install `mesa` and provides Vulkan for supported hardware
    hardware.graphics.enable = true;

    # Mount, trash, and other functionalities
    services.gvfs.enable = true;

    # services.libinput = {
    #     enable = true;
    #     touchpad = {
    #         accelProfile = "adaptive";
    #         accelSpeed = "-0.4";
    #         horizontalScrolling = true;
    #         naturalScrolling = false;
    #         scrollMethod = "twofinger";
    #         tapping = true;
    #         tappingDragLock = false;
    #     };
    # };

    environment.systemPackages = with pkgs; [
        xdg-utils       # For opening default programs when clicking links and other such things
    ];

    # Set default applications
    xdg.mime.defaultApplications = {
        "application/json" = "micro.desktop";
        "application/sql" = "micro.desktop";
        "application/xml" = "micro.desktop";
        "text/*" = "micro.desktop";
    };
}
