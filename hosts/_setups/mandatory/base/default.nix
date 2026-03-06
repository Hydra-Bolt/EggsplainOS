{ config, inputs, lib, pkgs, ... }: {
    imports = [
        ./_audio.nix
        ./_kernel.nix
        ./_network.nix
        ./_packages.nix
        ./_shell.nix
        ./_sudo.nix
        ./_users.nix
    ];

    hardware = {
        # Update CPU microcodes
        cpu = {
            intel.updateMicrocode = lib.mkDefault (pkgs.stdenv.hostPlatform.isx86_64 || pkgs.stdenv.hostPlatform.isi686);
            amd.updateMicrocode = lib.mkDefault (pkgs.stdenv.hostPlatform.isx86_64 || pkgs.stdenv.hostPlatform.isi686);
        };

        # Whether to enable all firmware regardless of license
        enableAllFirmware = true;
    };

    boot = {
        # Whether to mount a tmpfs on `/tmp` during boot
        tmp.useTmpfs = false;

        # Whether to delete all files in `/tmp` during boot
        tmp.cleanOnBoot = true;

        # If set, NixOS will enforce the immutability of the Nix store by making
        #   `/nix/store` a read-only bind mount
        # Nix will automatically make the store writable when needed
        readOnlyNixStore = true;
    };

    # Set time
    time = {
        timeZone = "Europe/Stockholm";
        hardwareClockInLocalTime = false;
    };

    nix = {
        # Automatic garbage collector
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };

        # If set, Nix will perform builds in a sandboxed environment that it will
        #   set up automatically for each build
        # This prevents impurities in builds by disallowing access to dependencies
        #   outside of the Nix store by using network and mount namespaces in a
        #   chroot environment
        settings.sandbox = true;

        # Enable experimental features
        # This appends text to `nix.conf` file (`/etc/nix/nix.conf`)
        extraOptions = "experimental-features = nix-command flakes";

        # Turn on automatic optimisation for newer derivations (save space via
        #   hardlinking store files)
        settings.auto-optimise-store = false;

        # Sources:
        #   - <https://discourse.nixos.org/t/do-flakes-also-set-the-system-channel/19798>
        #   - <https://ayats.org/blog/channels-to-flakes>
        #   - <https://github.com/NobbZ/nixos-config/blob/0dc416d1e89b1d1b2390ce3e33726710c4856f11/nixos/modules/flake.nix#L29>
        #   - <https://github.com/pbek/nixcfg/commit/7cddcb47054b351a484c4959dcf162f9c5c6a2fe>
        #   - <https://www.reddit.com/r/NixOS/comments/14uc96n/question_when_using_flakes_can_i_remove_all/>
        # Make all flake inputs available as channels
        registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
        nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    };

    # This value determines the NixOS release from which the default
    #   settings for stateful data (like file locations and database versions
    #   on your system) were taken, or in other words, `stateVersion` is used by
    #   nixos for state whose default changed throughout different versions,
    #   e.g. a database directory now being in `/var/db` instead of `/var/lib/db`
    # There are breaking changes from `stateVersion` to `stateVersion`
    # A bump of `stateVersion` potentially can't be reverted (requires manual
    #   intervention)
    # Before changing this value read the documentation for this option:
    #   - man configuration.nix
    #   - <https://nixos.org/nixos/options.html>
    #   - <https://nixos.wiki/wiki/Nix_channels>
    #   - <https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion>
    #   - <https://discourse.nixos.org/t/when-should-i-change-system-stateversion/1433/10>
    # When can I update `stateVersion`:
    #   - When you have read all release notes starting from your `stateVersion`
    #   - When you have verified all instances of `stateVersion` in the code in
    #       `<nixpkgs/nixos>`
    #   - When you have made all manual interventions as required by the changes
    #       previously inventoried
    # The recommended way is to leave it alone and never change (consider a full
    #   reinstall instead, once in 10 years or so)
    # system.stateVersion = "24.11";
    system.stateVersion = lib.mkDefault config.system.nixos.release;
}
