{
    description = "NixOS System Configuration";

    inputs = {
        # Sources:
        #   - <https://discourse.nixos.org/t/recommendations-for-use-of-flakes-input-follows/17413/5>
        # Use `nix flake metadata` to monitor inputs and what they follow

        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        # nix-alien = {
        #     url = "github:thiagokokada/nix-alien";
        #     inputs.nixpkgs.follows = "nixpkgs";
        # };
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            username = "eggsplain";
        in
            {
                nixosConfigurations = {
                    eggsplain =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain
                                ];
                            };

                    eggsplain-amd-1 =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-amd-1
                                ];
                            };

                    eggsplain-amd-2 =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-amd-2
                                ];
                            };

                    eggsplain-nvidia-1 =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-nvidia-1
                                ];
                            };

                    eggsplain-nvidia-2 =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-nvidia-2
                                ];
                            };

                    eggsplain-substorm-amd =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-substorm-amd
                                ];
                            };

                    eggsplain-substorm-nvidia =
                        let
                            system = "x86_64-linux";
                        in
                            nixpkgs.lib.nixosSystem {
                                inherit system;
                                specialArgs = { inherit inputs self system username; };
                                modules = [
                                    ./hosts/eggsplain-substorm-nvidia
                                ];
                            };
                };
            };
}
