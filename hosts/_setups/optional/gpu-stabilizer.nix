{ config, pkgs, ... }: {
  systemd.services.gpu-stabilizer = {
    description = "Apply GPU Stability Limits for Bad Riser";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
    };

    path = [ config.hardware.nvidia.package ];

    script = ''
      # Limit GPU power draw to 60W for the known-bad riser in this host.
      # Higher power limits were observed to cause PCIe errors / instability on this hardware,
      # so 60W is an empirically determined safe upper bound. Adjust only if the riser / GPU
      # configuration changes and new stability testing is performed.
      nvidia-smi -pl 60

      # Lock the GPU graphics clock to 900 MHz to avoid transient boost clocks that can
      # trigger riser-related instability. This value was chosen as a conservative ceiling
      # that keeps the system stable under load on this particular "Bad Riser" setup.
      nvidia-smi -lgc 900
    '';
  };
}
