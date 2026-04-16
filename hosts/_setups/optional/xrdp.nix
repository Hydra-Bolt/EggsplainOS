{ pkgs, ... }: {
    # Enable XRDP Server for Guacamole Connection
    services.xrdp.enable = true;
    services.xrdp.defaultWindowManager = "gnome-session";
    services.xrdp.openFirewall = true;
}
