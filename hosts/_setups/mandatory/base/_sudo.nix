{ ... }: {
    security.sudo.enable = true;

    # Allow sudo only for the members of the `wheel` group
    security.sudo.execWheelOnly = true;
}
