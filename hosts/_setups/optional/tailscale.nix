{ ... }: {
  # =========================================================
  # TAILSCALE
  # =========================================================
  services.tailscale.enable = true;

  # =========================================================
  # FIREWALL
  # =========================================================
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedUDPPorts = [ 41641 ];

  # =========================================================
  # RUNTIME COMPATIBILITY
  # =========================================================
  programs.nix-ld.enable = true;
}
