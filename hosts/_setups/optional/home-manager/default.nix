# Some useful links:
#   - <https://discourse.nixos.org/t/error-the-option-home-does-not-exist-definition-values/62030>



# { config, pkgs, username, ... }:
#     let
#         home-manager = builtins.fetchTarball {
#             url = "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
#             sha256 = "sha256-vykpJ1xsdkv0j8WOVXrRFHUAdp9NXHpxdnn1F4pYgSw=";
#         };
#     in
#         {
#             imports = [
#                 (import "${home-manager}/nixos")
#             ];
#
#             home-manager.users."${username}" = {
#                 # The home.stateVersion option does not have a default and must be set
#                 home.stateVersion = "18.09";
#             };
#         }

{ config, pkgs, self, username, ... }: {
    # imports = [
    #     (import "${self.inputs.home-manager}/nixos")
    # ];
    imports = [
        self.inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
    };

    home-manager.users."${username}" = {
        # The "home.stateVersion" option does not have a default and must be set
        # home.stateVersion = "25.05";
        home.stateVersion = config.system.nixos.release;

        home.username = "${username}";
        home.homeDirectory = "/home/${username}";

        # Make home-manager CLI available in "PATH"
        home.packages = [
            pkgs.home-manager
        ];

        # programs.home-manager.enable = true;
    };
}
