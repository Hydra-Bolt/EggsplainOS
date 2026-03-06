{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.ssh-tunnels;
in
{
  options.services.ssh-tunnels = {
    enable = mkEnableOption "Reverse SSH Tunnels";
    tunnels = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          description = mkOption {
            type = types.str;
            default = "Reverse SSH Tunnel";
          };
          remoteForward = mkOption {
            type = types.str;
            description = "The -R forwarding argument, e.g., '0.0.0.0:8893:localhost:22'";
          };
          vpsUser = mkOption {
            type = types.str;
            default = "root";
          };
          vpsHost = mkOption {
            type = types.str;
          };
          sshKeyPath = mkOption {
            type = types.path;
            default = "/home/eggsplain/.ssh/id_ed25519";
          };
          user = mkOption {
            type = types.str;
            default = "eggsplain";
          };
        };
      });
      default = { };
    };
  };

  config = mkIf cfg.enable {
    systemd.services = mapAttrs' (name: tunnel: nameValuePair "reverse-tunnel-${name}" {
      inherit (tunnel) description;
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.openssh pkgs.coreutils ];
      preStart = ''
        mkdir -p /home/${tunnel.user}/.ssh
        chmod 700 /home/${tunnel.user}/.ssh
        if [ ! -f ${tunnel.sshKeyPath} ]; then
          ssh-keygen -t ed25519 -N "" -f ${tunnel.sshKeyPath} -C "auto-generated-tunnel-key"
          chown ${tunnel.user} ${tunnel.sshKeyPath} ${tunnel.sshKeyPath}.pub
        fi
      '';
      serviceConfig = {
        ExecStart = "${pkgs.openssh}/bin/ssh -N -R ${tunnel.remoteForward} -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes -i ${tunnel.sshKeyPath} ${tunnel.vpsUser}@${tunnel.vpsHost}";
        Restart = "always";
        RestartSec = "10s";
        User = tunnel.user;
      };
    }) cfg.tunnels;
  };
}
