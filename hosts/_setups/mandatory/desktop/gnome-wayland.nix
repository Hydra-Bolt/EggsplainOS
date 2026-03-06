# References:
#   - <https://nixos.wiki/wiki/GNOME>



{ pkgs, ... }: {
    imports = [
        ./_sets/base.nix
    ];

    services.xserver = {
        desktopManager.gnome.enable = true;
        displayManager.gdm = {
            enable = true;
            wayland = true;
        };
    };

    # Disable sleep mode
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;

    # Enable GNOME Keyring daemon, a service designed to take care of the
    #   user's security credentials, such as user names and passwords
    services.gnome.gnome-keyring.enable = true;

    # Disable file indexing
    services.gnome = {
        localsearch.enable = false;
        tinysparql.enable = false;
    };

    # Enable `dconf` (only `gsettings`, not `dconf-editor`)
    programs.dconf.enable = true;

    # A list of packages which provide `dconf` profiles and databases in `/etc/dconf`
    programs.dconf.packages = with pkgs; [
        # ERROR: Doesn't have dconf settings in its store dir
        # nautilus
    ];

    services.udev.packages = with pkgs; [
        # Ensure `gnome-settings-daemon` udev rules are enabled (`gsettings`)
        gnome-settings-daemon

        # Running ancient applications that rely on GConf
        # Long ago, in the GNOME 2 era, applications used GConf service to store
        #   configuration
        # This has been deprecated for many years but some applications
        #   were abandoned before they managed to upgrade to a newer
        #   dconf system
        # gnome2.GConf
    ];

    environment.systemPackages = with pkgs; [
        # Many applications rely heavily on having an icon theme available,
        #   GNOME’s Adwaita is a good choice but most recent icon themes
        #   should work as well
        adwaita-icon-theme
        papirus-icon-theme

        mission-center              # Resource monitor
    ];

    # Exclude default gnome packages
    environment.gnome.excludePackages = with pkgs; [
        gnome-connections
        gnome-photos
        gnome-text-editor   # Gnome's new text editor
        gnome-tour
        simple-scan
        gedit           # Gnome's old text editor
        atomix          # Puzzle game
        cheese          # Webcam tool
        epiphany        # Web browser
        evince          # Document viewer
        geary           # Email reader
        gnome-characters
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-software
        # gnome-terminal
        gnome-weather
        hitori          # Sudoku game
        iagno           # Go game
        tali            # Poker game
        totem           # Video player
   ];
}
