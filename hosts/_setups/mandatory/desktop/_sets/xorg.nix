{ pkgs, ... }: {
    # Enable the X11 windowing system
    services.xserver = {
        enable = true;
        autorun = true;
        desktopManager.xterm.enable = false;
        displayManager.startx.enable = true;
    };

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };

    # Which X11 packages to exclude from the default environment
    services.xserver.excludePackages = [
        pkgs.xterm
    ];
}
