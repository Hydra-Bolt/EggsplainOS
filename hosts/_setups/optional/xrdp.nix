{ pkgs, ... }: {
    # Enable XRDP Server for Guacamole Connection
    services.xrdp.enable = true;
    services.xrdp.defaultWindowManager = ''
        if [ -z "$LANG" ]; then
            export LANG="en_US.UTF-8"
        fi
        
        exec dbus-run-session gnome-session
    '';
    services.xrdp.openFirewall = true;
}
