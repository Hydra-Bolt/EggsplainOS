{ config, lib, ... }: {
    # Enable sshd and disable some features for security reasons
    services.openssh = {
        enable = true;

        # Don't set this if you need sftp
        allowSFTP = false;

        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = lib.mkForce "no";
            StrictModes = true;
            X11Forwarding = false;

            # Specifies whether keyboard-interactive authentication is allowed
            KbdInteractiveAuthentication = false;
        };

        extraConfig = ''
            AllowAgentForwarding no
            AllowStreamLocalForwarding no
            AllowTcpForwarding yes
            AuthenticationMethods publickey
        '';
    };
}
