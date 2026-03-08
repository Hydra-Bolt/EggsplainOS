{ config, lib, username, ... }: {
    # Define a user account
    # Don't forget to set a password with `passwd`
    users = {
        users."${username}" = {
            isNormalUser = true;
            description = username;
            extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
            homeMode = "700";

            # If true, the user's shell will be set to `users.defaultUserShell`
            useDefaultShell = false;

            # Whether to create the home directory and ensure ownership as well
            #   as permissions to match the user
            createHome = true;

            # Specifies the hashed password for the user
            # The options `hashedPassword`, `password` and `passwordFile` controls
            #   what password is set for the user
            # `hashedPassword` overrides both `password` and `passwordFile`
            # `password` overrides `passwordFile`
            # If none of these three options are set, no password is assigned to
            #   the user, and the user will not be able to do password logins
            # If the option `users.mutableUsers` is `true`, the password defined
            #   in one of the three options will only be set when the user is
            #   created for the first time
            # After that, you are free to change the password with the ordinary
            #   user management commands
            # If `users.mutableUsers` is `false`, you cannot change user passwords,
            #   they will always be set according to the password options
            # To generate a hashed password run `mkpasswd`
            # If set to an empty string (`""`), this user will be able to log in
            #   without being asked for a password (but not via remote services
            #   such as SSH, or indirectly via `su` or `sudo`)
            # This should only be used for e.g. bootable live systems
            # NOTES:
            #   - This is different from setting an empty password, which can
            #       be achieved using `users.users.<name?>.password`
            # If set to `null` (default) this user will not be able to log in using
            #   a password (i.e. via login command)
            hashedPassword = lib.mkDefault (lib.strings.fileContents (toString ../../../../secrets/password));
        };

        # If set to `true`, you are free to add new users and groups to the system
        #   with the ordinary `useradd` and `groupadd` commands
        # On system activation, the existing contents of the `/etc/passwd` and
        #   `/etc/group` files will be merged with the contents generated from the
        #   `users.users` and `users.groups` options
        # The initial password for a user will be set according to `users.users`,
        #   but existing passwords will not be changed
        # If set to `false`, the contents of the user and group files will simply
        #   be replaced on system activation
        # This also holds for the user passwords, all changed passwords will be
        #   reset according to the `users.users` configuration on activation
        mutableUsers = false;
    };
}
