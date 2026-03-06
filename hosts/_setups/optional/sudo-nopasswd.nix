{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.security.sudo-nopasswd;
in
{
  options.security.sudo-nopasswd = {
    enable = mkEnableOption "Passwordless sudo for specific users";
    users = mkOption {
      type = types.listOf types.str;
      default = [ "eggsplain" ];
      description = "List of users who can use sudo without a password.";
    };
  };

  config = mkIf cfg.enable {
    security.sudo.extraRules = [{
      users = cfg.users;
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }];
  };
}
