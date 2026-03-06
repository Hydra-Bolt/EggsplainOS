{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.dokploy;
in
{
  options.services.dokploy = {
    enable = mkEnableOption "Dokploy directory management";
    user = mkOption {
      type = types.str;
      default = "eggsplain";
    };
    group = mkOption {
      type = types.str;
      default = "users";
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /etc/dokploy 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/logs 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/compose 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/applications 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/traefik 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/ssh 0700 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/monitoring 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/registry 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/schedules 0755 ${cfg.user} ${cfg.group} -"
      "d /etc/dokploy/volume-backups 0755 ${cfg.user} ${cfg.group} -"
    ];
  };
}
