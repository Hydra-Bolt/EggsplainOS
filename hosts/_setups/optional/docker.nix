{ pkgs, ... }: {
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
        dive            # A tool for exploring each layer in a docker image [go]
        docker-compose
    ];
}
