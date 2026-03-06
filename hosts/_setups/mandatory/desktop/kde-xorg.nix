# References:
#   - <https://nixos.wiki/wiki/KDE>



{ pkgs, ... }: {
    imports = [
        ./_sets/base.nix
        ./_sets/xorg.nix
    ];

    services = {
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = false;
        desktopManager.plasma6.enable = true;
    };

    # Disable sleep mode
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;

    # If GTK themes are not applied in Wayland applications
    programs.dconf.enable = true;

    # List of default KDE packages to exclude
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
        elisa                           # Audio player
        gwenview                        # Image viewer
        kate                            # Advanced text editor
        khelpcenter
        kwrited                         # Simple text editor
        okular                          # Document viewer
        oxygen                          # Old theme
        plasma-browser-integration      # Browser extension
    ];
}
