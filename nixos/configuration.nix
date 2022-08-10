# My configuration file for NixOS

{ config, pkgs, lib, ... }:

{
    imports =
    [ # Include hardware results
    ./hardware-configuration.nix
    #./wayland-overlay.nix
    ];


    #hardware.opengl = {
    #  extraPackages = with pkgs; [
    #  intel-media-driver
    #  vaapiIntel
    #  vaapiVdpau
    #  libvdpau-va-gl
    #  ];
    #};
    hardware = {
      opengl = {
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          vaapiVdpau
          libvdpau
          libvdpau-va-gl
        ];
      };
      video = {
        hidpi.enable = true;
      };
    };

# Power management
    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

#  Allow non-free packages

    nixpkgs.config.allowUnfree = true;

# Add SSD options

    fileSystems."/" =
# Root filesystem
    {
        options = [ "noatime" "nodiratime" "discard" ];
    };

    fileSystems."/home" =
# /home fileSystems
    {
        options = [ "noatime" "nodiratime" "discard" ];
    };

# LUKS
# Add UUID of your encrypted device
    boot.initrd.luks.devices.luksroot =
    {
        device = "/dev/disk/by-uuid/0TyHfC-BFTA-2Fzo-F4V0-X6qk-l6YV-vAgFJR";
        allowDiscards = true;
        preLVM = true;
    };

# Flakes
    nix = {
        package = pkgs.nixFlakes;
        extraOptions = ''
            experimental-features = nix-command flakes
            '';
        settings.auto-optimise-store = true;
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
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
        font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v28b.psf.gz";
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
            libinput = {
              enable = true;
              touchpad = {
                disableWhileTyping = true;
                middleEmulation = true;
                naturalScrolling = false;
                scrollMethod = "twofinger";
                tapping = true;
                tappingDragLock = true;
              };
            };
        };
        openssh = {
            enable = true;
            permitRootLogin = "no";
            passwordAuthentication = false;
        };
# Remap End/Home to Metaleft/Esc
        udev = {
            extraHwdb = ''
              evdev:name:AT Translated Set 2 keyboard:*
               KEYBOARD_KEY_cf=leftmeta
               KEYBOARD_KEY_c7=esc
               '';
        };
    };

    #environment.interactiveShellInit = ''
    #  if [[ "$VTE_VERSION" > 3405 ]]; then
    #    source "${pkgs.vte}/etc/profile.d/vte.sh"
    #  fi
    #'';


# Sound system

    sound.enable = true;
    #hardware.pulseaudio.enable = true;
    #nixpkgs.config.pulseaudio = true;
# Using pipewire for sound system
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };


# User management

    users = {
        users.ak = {
            isNormalUser = true;
            shell = pkgs.zsh;
            extraGroups = [
            "wheel" "ak" "docker" "video" "audio" "adbusers" "vboxusers"
            ];
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7X4v3Ae2dopGiL9Mp6gqM235KbhTWOzo8p6zPQVl+7 openpgp:0x8C014A49"
            ];
            #packages = with pkgs; [
#    (polybar.override { mpdSupport = true; pulseSupport = true; })
#            polybarFull
#            firefox
#            qutebrowser
#            anydesk
#            alacritty
#            w3m
#            git
#            opera
#            xclip
#            xsel
#            efibootmgr
#            docker
#            terraform
#            awscli2
#            rofi
#            pamixer
#            zsh-powerlevel10k
#            jq
#            android-tools
#            adb-sync
#            gist
#            cloud-init
#            xss-lock
#            i3lock-fancy-rapid
#            i3lock
#]
        };
    };

# Some python packages
    #environment.systemPackages = [
    #let {
    #    myPythonPackages = pythonPackages: with pythonPackages;
    #[
    #requests pip
    #];
    #in with pkgs; [
    # (python3.withPackages myPythonPackages)
    # curl vim dash bc openssl physlock tmux file dnsutils whois coreutils killall binutils lsof usbutils fbida zathura openvpn
    #];

# Some programs
    programs = {
        #gnupg.agent = {
        #    enable = true;
        #    enableSSHSupport = true;
        #    pinentryFlavor = "curses";
        #};
        #sway = {
        #enable = true;
        #};
# Default Editor is vim
        vim.defaultEditor = true;
# Enable light and add user to video group for brightness control
        #light = {
        #    enable = true;
        #};
# I have android as well :-)
        #adb = {
        #    enable = false;
        #};
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
            "FiraCode" "DroidSansMono" "SourceCodePro" "Ubuntu" "Meslo" "Iosevka"
            ];
            })
            noto-fonts-emoji
            kochi-substitute
            meslo-lg
            siji
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
        #virtualbox = {
        #  guest.enable = true;
        #  guest.x11 = true;
        #  host.enable = true;
          #host.enableExtensionPack = true;
          #host.enableHardening = true;
        #};
    };




# https://nixos.org/nixos/options.html
    system.autoUpgrade.enable = true;
    system.autoUpgrade.allowReboot = true;
    system.stateVersion = "22.05";

}
