{ pkgs, ... }: {
    # Install Chrome
    environment.systemPackages = [ pkgs.google-chrome ];

    # Wayland for Chromium-family apps
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
}
