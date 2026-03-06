{ config, pkgs, username, ... }: {
    # Set default shell
    users.users."${username}".shell = pkgs.bashInteractive;

    # Enable and configure bash
    programs.bash = {
        # Keep this disabled because it doesn't work with tools like `lf` or `micro`
        undistractMe = {
            enable = false;
            playSound = true;

            # Number of seconds it would take for a command to be considered long-running
            timeout = 10;
        };
        completion.enable = true;
    };
}
