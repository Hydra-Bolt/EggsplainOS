{ lib, pkgs, username, ... }: {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Some programs need SUID wrappers, can be configured further or are
    #   started in user sessions
    # programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # Required by `nixos-rebuild` (since 2022-10)
    programs.git = {
        enable = true;
        package = pkgs.git;
        config = {
            init = {
                defaultBranch = "main";
            };
            alias = {
                lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
                lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
                lg3 = "log --decorate --oneline --graph --all --date=short --pretty=format:'%C(auto)%d%Creset %C(auto)%h%Creset - %C(cyan)%an%Creset %Cgreen(%ad)%Creset : %s'";
            };
            user = {
                name = "${username}";
            };
        };
    };

    # Sources:
    #   - <https://blog.nobbz.dev/2023-02-27-nixos-flakes-command-not-found/>
    #   - <https://github.com/NixOS/nixpkgs/issues/171054>
    #   - <https://discourse.nixos.org/t/how-to-specify-programs-sqlite-for-command-not-found-from-flakes/22722/15>
    #   - <https://github.com/wamserma/flake-programs-sqlite>
    programs.command-not-found.enable = false;

    # Polkit is used for controlling system-wide privileges
    # It provides an organized way for non-privileged processes to communicate
    #   with privileged ones
    # In contrast to `sudo`, it does not grant root permission to an entire
    #   process, but rather allows a finer level of control of centralized
    #   system policy
    security.polkit.enable = true;

    # Disable default packages
    environment.defaultPackages = lib.mkForce [];

    # List packages installed in system profile
    # To search, run the following command: `$ nix search ...`
    environment.systemPackages = with pkgs; [
        bc              # GNU software calculator (useful for scripting in bash)
        cryptsetup      # Manage, edit and create encrypted devices
        curl            # A command line tool for transferring files with URL syntax
        ffmpeg          # Multimedia editing tool
        file            # File analyzer using magic numbers
        fzf             # General-purpose command-line fuzzy finder [go]
        git-dive        # TUI for git to explore one file's history [rust]
        gitui           # TUI for git [rust]
        imagemagick     # Image editing tool
        killall         # Kill all instances of process
        lf              # Terminal file manager [go]
        lsof            # List processes that use a file (or socket)
        micro           # Terminal text editor [go]
        ncdu            # ncdu - NCurses Disk Usage
        neofetch        # Print info about PC
        nix-tree        # Interactively browse a Nix store paths dependencies
        nvd             # Nix/NixOS package version diff tool [python]
        pciutils        # Manage PCI devices (`lspci`, `setpci`)
        pv              # Terminal progress bar for file operations
        rsync           # A fast, versatile, remote (and local) file-copying tool
        sd              # Intuitive find & replace CLI (sed alternative) [rust]
        trash-cli       # Trash manager [python]
        tree            # Print dir tree structure
        vulnix          # Nix(OS) vulnerability scanner [python]
        wget            # Tool for retrieving files using HTTP, HTTPS, and FTP

        # Clipboard access for X11 (from console) and Wayland
        wl-clipboard        # Command-line copy/paste utilities for Wayland
        wl-clipboard-x11    # A wrapper to use `wl-clipboard` as a drop-in replacement for X11 clipboard tools
        xclip               # Tool to access the X clipboard from a console application

        # Monitoring tools
        bmon        # Network usage
        btop        # Nice TUI for IO, CPU, RAM and network usage
        dig         # Domain name server
        fatrace     # Report system-wide file access events
        htop        # IO, CPU, RAM usage
        iotop       # IO usage
        nethogs     # A small "net top" tool, grouping bandwidth by process
        nettools    # A set of tools for controlling the network subsystem in Linux
        sysstat     # A collection of performance monitoring tools for Linux (such as `sar`, `iostat` and `pidstat`)

        # Archive utilities
        p7zip       # 7zip
        unrar       # rar
        zip unzip   # zip

        # Dev tools for appimages (set of functions for running, extracting and wrapping appimage files)
        # Warning:
        #   - Unstable API, may be subject to backwards-incompatible changes in the future)
        # appimageTools

        appimage-run    # Only run appimages

        # Filesystem
        btrfs-progs     # btrfs
        dosfstools      # fat16, fat32
        e2fsprogs       # ext2, ext3, ext4
        exfatprogs      # exfat
        ntfsprogs       # ntfs
        xfsprogs        # xfs
    ];

    environment.sessionVariables = {
        # Set default terminal text editor
        EDITOR = "micro";
        VISUAL = "micro";

        # Set default terminal pager
        PAGER = "less";
    };
}
