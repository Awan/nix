# My configuration file for NixOS

{ config, pkgs, lib, ... }:

{
    imports =
    [ # Include hardware results
    ./hardware-configuration.nix
    ];

# Power management 
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

#  Allow non-free packages

    nixpkgs.config.allowUnfree = true;

# Add SSD options

    fileSystems."/" =
# Root filesystem
    {
        options = [ "noatime" "nodiratime" ];
    };

    fileSystems."/home" =
# /home fileSystems
    {
        options = [ "noatime" "nodiratime" ];
    };

# LUKS
# Add UUID of your encrypted device
    boot.initrd.luks.devices.luksroot =
    {
        device = "/dev/disk/by-uuid/5d121b1b-dada-43f9-92c2-13af222a4f2d";
        allowDiscards = true;
        preLVM = true;
    };

# Bootloader

# Kernel params
    boot = {
        kernelParams =
        [ "splash" "ipv6.disable=1" "nmi_watchdog=0" "consoleblank=60" ];
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            efi.canTouchEfiVariables = true;

# Using systemd-boot

            systemd-boot = {
                enable = true;
            };
        };
    };


# Timezone
    time.timeZone = "Asia/Karachi";

# Networking and hostname

    networking = {
        hostName = "x1c";
        wireless = {
            enable = true;
        };
        useDHCP = false;
        interfaces = {
            enp0s25 = {
                useDHCP = true;
            };
            wlp3s0 = {
                useDHCP = true;
            };
        };
# Firewall
#         firewall.allowedTCPPorts = [ ... ];
#         firewall.allowedUDPPorts = [ ... ];
        firewall.enable = true;
    };

# i18n properties
    i18n = {
        defaultLocale = "en_US.UTF-8";
    };

# Console setup

    console = {
        font = "${pkgs.tamzen}/share/consolefonts/TamzenForPowerline10x20.psf";
        keyMap = "us";
    };

# X11
    services = {
# enable X11
        xserver = {
            enable = true;
            layout = "us";
            displayManager.startx.enable = true;
            windowManager.bspwm.enable = true;
            libinput.enable = true;
        };
        openssh = {
            enable = true;
            permitRootLogin = "no";
            passwordAuthentication = false;
        };
    };

# Sound system

    sound.enable = true;
    hardware.pulseaudio.enable = true;
    nixpkgs.config.pulseaudio = true;

# User management

    users = {
        users.ak = {
            isNormalUser = true;
            shell = pkgs.zsh;
            extraGroups = [
            "wheel" "ak" "docker" "video" "audio"
            ];
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7X4v3Ae2dopGiL9Mp6gqM235KbhTWOzo8p6zPQVl+7 openpgp:0x8C014A49"
            ];
            packages = with pkgs; [
            mpd
	    ncmpcpp
	    mpc-cli
	    sxhkd
	    picom
	    rofi
    	    feh
	    dunst
	    elinks
	    mplayer
	    mpv
	    ffmpeg
	    ffmpegthumbnailer
	    msmtp
	    notmuch
#	    (polybar.override { mpdSupport = true; pulseSupport = true; })
#            polybarFull
#            firefox
#            qutebrowser
#            anydesk
	    ranger
	    redshift
	    screenkey
	    hugo
	    urlview
	    xorg.xev
	    xorg.xwininfo
	    xorg.xdpyinfo
	    xorg.xev
	    xorg.xkill
	    xorg.xmodmap
	    xlsfonts
	    youtube-dl
	    youtube-viewer
	    sxiv
	    libnotify
	    weechat
	    ueberzug
	    simplescreenrecorder
	    zsh-autosuggestions
	    zsh-powerlevel10k
	    unclutter
#	    alacritty
	    tmux
	    tmate
	    xdotool
	    mutt
	    google-chrome
	    pass
	    zsh
	    git
	    htop
	    neofetch
	    pavucontrol
#	    tdesktop
	    isync
	    ponymix
	    stow
	    cmus
	    imagemagick
	    nodejs
	    powerline
	    powerline-fonts
	    w3m
	    opera
	    xclip
	    xsel
	    rxvt-unicode
	    slop
	    lemonbar
	    efibootmgr
	    docker
	    terraform
	    awscli2
	    rofi
            pamixer
            zsh-powerlevel10k
            jq
            android-tools
	    adb-sync
	    gist
	    cloud-init
	    xss-lock
	    i3lock-fancy-rapid
	    i3lock
            ];
        };
    };

# Some python packages
    
    environment.systemPackages = let
        myPythonPackages = pythonPackages: with pythonPackages;
    [
    requests pip
    ];
    in with pkgs; [
    (python3.withPackages myPythonPackages)
    curl vim dash bc openssl stow physlock tmux file nix-index dnsutils whois coreutils killall binutils lsof usbutils fbida zathura openvpn
    ];

# Some programs 
    programs = {
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
            pinentryFlavor = "curses";
        };
# Default Editor is vim
        vim.defaultEditor = true;
# Enable light and add user to video group for brightness control
        light = {
            enable = true;
        };
# I have android as well :-)
        adb = {
            enable = false;
        };
# Enable zsh autocompletion
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            autosuggestions.strategy = [ "match_prev_cmd" "completion" "history" ];
            setOptions = [
            "SHARE_HISTORY" "APPEND_HISTORY" "EXTENDED_HISTORY" "HIST_NO_STORE" "HIST_IGNORE_ALL_DUPS" "HIST_IGNORE_SPACE" "AUTO_CD" "EXTENDED_GLOB" "NOMATCH" "NO_BEEP" "TRANSIENT_RPROMPT" "COMPLETE_IN_WORD" "AUTO_PUSHD" "PUSHD_IGNORE_DUPS" "NO_CLOBBER" "GLOBSTARSHORT" "RM_STAR_WAIT" "INTERACTIVE_COMMENTS" "CORRECT_ALL" "AUTO_LIST" "AUTO_NAME_DIRS" "GLOB_COMPLETE" 
            ];
            enableBashCompletion = true;
            histSize = 120000;
            histFile = "$HOME/.zsh_history";
        };
# Enable xss-lock
#        xss-lock = {
#            enable = true;
#            lockerCommand = "${pkgs.i3lock-fancy-rapid}/bin/i3lock-fancy-rapid 5 3";
#        };
    };

# I can't live without my fonts ;-)

    fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
            (nerdfonts.override { fonts = [
            "FiraCode" "DroidSansMono" "SourceCodePro" "Ubuntu"
            ];
            })
            noto-fonts-emoji
            unifont
            open-sans
            liberation_ttf
            liberation-sans-narrow
            ttf_bitstream_vera
            libertine
            ubuntu_font_family
            font-awesome
            gentium
            jetbrains-mono
            source-code-pro
            dina-font
            tamzen
            proggyfonts
            dejavu_fonts
            corefonts
            inconsolata
            terminus_font
            mononoki
        ];
    };

# Security related things

# No password for wheel users

    security = {
        sudo = {
            enable = true;
            wheelNeedsPassword = false;
        };
    };

# Virtualisation 

    virtualisation = {
        docker = {
            enable = true;
            autoPrune.enable = true;
            enableOnBoot = false;
        };
    };



# https://nixos.org/nixos/options.html
    system.stateVersion = "22.05";

}
