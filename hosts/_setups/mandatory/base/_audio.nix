{ config, username, ... }: {
    users.users."${username}".extraGroups = [ "audio" ];

    # Enable sound with pulseaudio
    services.pulseaudio.enable = false;

    # Whether to enable the RealtimeKit system service, which hands out realtime
    #   scheduling priority to user processes on demand
    # For example, the PulseAudio server uses this to acquire realtime priority
    # Enable only if pulseaudio is enabled, otherwise it's not worth it:
    #   - <https://askubuntu.com/a/672634>
    #   - <https://www.reddit.com/r/archlinux/comments/1cl5h2e/do_most_desktops_want_xdgdesktopportal_and_rtkit/>
    security.rtkit.enable = false;

    # Enable sound with pipewire
    services.pipewire = {
        enable = true;

        # If true, a system-wide PipeWire service and socket is enabled allowing
        #   all users in the "pipewire" group to use it simultaneously
        # If false, then user units are used instead, restricting access to
        #   only one user
        # Enabling system-wide PipeWire is however not recommended and disabled
        #   by default according to <https://github.com/PipeWire/pipewire/blob/master/NEWS>
        systemWide = false;

        # Whether to use PipeWire as the primary sound server
        # Enabled by default if `config.services.pipewire.alsa.enable || config.services.pipewire.jack.enable || config.services.pipewire.pulse.enable`
        audio.enable = true;

        # Enable support for applications that use alsa
        alsa.enable = true;
        alsa.support32Bit = true;

        # Enable support for applications that use pulseaudio
        pulse.enable = true;

        # If you want to use JACK applications, set this to true
        jack.enable = true;

        # Use the example session manager (no others are packaged yet so this is
        #   enabled by default, no need to redefine it in your config for now)
        # media-session.enable = true;

        # A modular session / policy manager for PipeWire
        # Replacement for media-session
        # wireplumber.enable = true;
    };
}
