{ pkgs, ... }: {
    virtualisation.podman = {
        enable = true;

        # Create a `docker` alias for Podman, to use it as a drop-in replacement
        dockerCompat = true;

        # Make the Podman and Docker compatibility API available over the network
        #   with TLS client certificate authentication
        # This allows Docker clients to connect with the equivalents of the Docker
        #   CLI `-H` and `--tls*` family of options
        networkSocket.enable = false;
        networkSocket.server = "ghostunnel";

        # Make the Podman socket available in place of the Docker socket, so Docker
        #   tools can find the Podman socket
        dockerSocket.enable = true;

        # Required for containers under `podman-compose` to be able to talk to each other
        defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs;
    # let
    #     old-pkgs = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz") {};
    #     podman-compose-v1-0-6 = old-pkgs.podman-compose;
    # in [
    [
        dive                    # A tool for exploring each layer in a docker image [go]
        podman-compose
        # podman-compose-v1-0-6
        podman-tui
        pods                    # Frontend for podman [rust]
    ];
}
