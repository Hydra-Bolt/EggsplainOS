{ lib, pkgs, ... }: {
    boot = {
        # Enable plymouth
        plymouth = {
            enable = true;

            # Use one of the default themes
            theme = "spinfinity";

            # Or, install and use additional ones
            # theme = "rings";
            # themePackages = with pkgs; [
            #     # By default we would install all themes
            #     (adi1090x-plymouth-themes.override {
            #         selected_themes = [ "rings" ];
            #     })
            # ];

            # Image needs to be PNG
            # Not all themes support images
            logo = ./_logo.png;

            extraConfig = ''
                UseFirmwareBackground=false
            '';
        };

        # Plymouth should work without systemd initrd
        # But systemd initrd does allow it to start a little sooner and prompt for passwords graphically
        initrd.systemd.enable = true;

        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
        ];

        # Hide the OS choice for bootloaders
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = lib.mkDefault 0;
    };
}
