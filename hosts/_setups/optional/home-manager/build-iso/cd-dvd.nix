{ modulesPath, username, ... }: {
    # This enables a periodically executed systemd service named `nixos-upgrade.service`
    imports = [
        (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")

        # Provide an initial copy of the NixOS channel so that the user
        #   doesn't need to run "nix-channel --update" first
        (modulesPath + "/installer/cd-dvd/channel.nix")
    ];

    # Disable password
    users.users."${username}".hashedPassword = "";

    # Include NixOS configuration
    home-manager.users."${username}".home.file.NixOS = {
        recursive = true;
        source = ../../../../..;
    };
}
