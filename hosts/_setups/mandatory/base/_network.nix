{ lib, ... }: {
    # Pick only one of the below networking options:
    #   - Enables wireless support via `wpa_supplicant`
    # networking.wireless.enable = true;
    #   - Easiest to use and most distros use this by default (`nmcli`)
    networking.networkmanager.enable = true;

    # Make sure wpa_supplicant isn't enabled (building iso image errors out if this isn't set)
    networking.wireless.enable = lib.mkForce false;

    # `ssh` server
    # `services.sshd` is an alias to this
    # services.openssh.enable = lib.mkDefault false;

    # `ssh` client
    programs.ssh = {
        # Whether to start the OpenSSH agent when you log in
        # OpenSSH agent remembers private keys for you so that you
        #   don't have to type in passphrases every time you make an
        #   SSH connection
        # Use `ssh-add` to add a key to the agent
        startAgent = false;

        # How long to keep the private keys in memory
        # Use null to keep them forever
        agentTimeout = "1h";

        forwardX11 = false;
    };

    # Enable the firewall
    networking.firewall.enable = true;
}
