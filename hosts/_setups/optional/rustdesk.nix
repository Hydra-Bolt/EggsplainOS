# Sources:
#   - <https://www.reddit.com/r/rustdesk/comments/1jhn2pa/comment/mjbjrcv/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button>



{ pkgs, ... }: {
    services.rustdesk-server = {
        enable = true;
        openFirewall = true;
    };

    # Run rustdesk at startup
    systemd.services."rustdesk" = {
        enable = true;
        path = with pkgs; [
            pkgs.rustdesk
            procps

            # This doesn't work since the version of sudo that will then be in the
            #   path, won't have the setuid bit set
            # sudo
        ];
        description = "RustDesk";
        requires = [ "network.target" ];
        after= [ "systemd-user-sessions.service" ];
        script = ''
            export PATH=/run/wrappers/bin:$PATH
            ${pkgs.rustdesk}/bin/rustdesk --service
        '';
        serviceConfig = {
            ExecStop = "${pkgs.procps}/pkill -f 'rustdesk --'";
            PIDFile = "/run/rustdesk.pid";
            KillMode = "mixed";
            TimeoutStopSec = "30";
            User = "root";
            LimitNOFILE = "100000";
        };
        wantedBy = [ "multi-user.target" ];
    };

    environment.systemPackages = with pkgs; [
        rustdesk
    ];
}
