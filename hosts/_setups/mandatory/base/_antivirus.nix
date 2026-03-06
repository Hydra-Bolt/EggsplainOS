{ ... }: {
    # Enable the ClamAV service and keep the database up to date
    services.clamav = {
        # Don't enable the daemon, it only consumes memory and
        #   doesn't do anything
        daemon.enable = false;

        updater = {
            enable = true;

            # How often freshclam is invoked
            interval = "weekly";
        };
    };
}
