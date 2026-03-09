{ inputs, system, ... }: {
  boot.kernelPackages = inputs.nixpkgs-unstable.legacyPackages.${system}.linuxPackages_latest;
}
