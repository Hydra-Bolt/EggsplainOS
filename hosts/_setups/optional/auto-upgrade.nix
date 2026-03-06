{ ... }: {
    # This enables a periodically executed systemd service named `nixos-upgrade.service`
    system.autoUpgrade = {
        enable = true;

        # If `allowReboot` is `false`, it runs `nixos-rebuild switch --upgrade`
        #   to upgrade NixOS to the latest version in the current channel
        # If `allowReboot` is `true`, then the system will automatically reboot if
        #   the new generation contains a different kernel, initrd or kernel modules
        allowReboot = false;

        # How often or when upgrade occurs
        dates = "weekly";

        # You can also specify a channel explicitly, otherwise the
        #   current/default channel is selected
        # You can see the current/default channel with `nix-channel --list`,
        #   the current/default one is named `nixos`
        # channel = "https://nixos.org/channels/nixos-unstable";

        # The Flake URI of the NixOS configuration to build
        # Disables the option system.autoUpgrade.channel
        # flake = "";
    };
}
