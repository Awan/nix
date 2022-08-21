# My configuration file for NixOS

{ config, pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  hardware = {
    opengl = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        vaapiIntel
        vaapiVdpau
        libvdpau
        libvdpau-va-gl
      ];
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    video = { hidpi.enable = true; };
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
  # Add UUID of encrypted device
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/96e4c70f-101c-4ede-8d73-63f02cff3f55";
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

      systemd-boot = { enable = true; };
    };
  };

  # Timezone
  time.timeZone = "Asia/Karachi";

  # Networking and hostname

  networking = {
    hostName = "x1c";
    wireless = { enable = true; };
    useDHCP = false;
    interfaces = {
      enp0s25 = { useDHCP = true; };
      wlp3s0 = { useDHCP = true; };
    };
    # Firewall
    #         firewall.allowedTCPPorts = [ ... ];
    #         firewall.allowedUDPPorts = [ ... ];
    firewall = {
      enable = true;
      # Allow TCP ports, 8000 for mpd
      allowedTCPPorts = [ 8000 ];
      #allowedUDPPorts = [ ... ];
    };
  };

  # i18n properties
  i18n = { defaultLocale = "en_US.UTF-8"; };

  # Console setup

  console = {
    font =
      "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v28b.psf.gz";
    keyMap = "us";
  };

  # X11
  services = {
    # enable X11
    #xserver = {
    #  enable = false;
    #  layout = "us";
    #  displayManager = {
    #    sx = {
    #      enable = true;
    #    };
    #  };
    #  libinput = {
    #    enable = true;
    #    touchpad = {
    #      disableWhileTyping = true;
    #      middleEmulation = true;
    #      naturalScrolling = false;
    #      scrollMethod = "twofinger";
    #      tapping = true;
    #      tappingDragLock = true;
    #    };
    #  };
    #};
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

  # Sound system

  sound.enable = true;
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
      extraGroups =
        [ "wheel" "ak" "docker" "video" "audio" "adbusers" "vboxusers" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7X4v3Ae2dopGiL9Mp6gqM235KbhTWOzo8p6zPQVl+7 openpgp:0x8C014A49"
      ];
    };
  };

  # Some programs
  programs = {
    # make vim default editor
    vim.defaultEditor = true;
    # To control brightness, don't forget to add user to video group
    light.enable = true;
    # without sway, swaylock won't work...
    #  sway.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      autosuggestions.strategy = [ "match_prev_cmd" "completion" "history" ];
      setOptions = [
        "SHARE_HISTORY"
        "APPEND_HISTORY"
        "EXTENDED_HISTORY"
        "HIST_NO_STORE"
        "HIST_IGNORE_ALL_DUPS"
        "HIST_IGNORE_SPACE"
        "AUTO_CD"
        "EXTENDED_GLOB"
        "NOMATCH"
        "NO_BEEP"
        "TRANSIENT_RPROMPT"
        "COMPLETE_IN_WORD"
        "AUTO_PUSHD"
        "PUSHD_IGNORE_DUPS"
        "NO_CLOBBER"
        "GLOBSTARSHORT"
        "RM_STAR_WAIT"
        "INTERACTIVE_COMMENTS"
        "CORRECT_ALL"
        "AUTO_LIST"
        "AUTO_NAME_DIRS"
        "GLOB_COMPLETE"
      ];
      enableBashCompletion = true;
      histSize = 120000;
      histFile = "$HOME/.zsh_history";
    };
  };

  environment = {
    defaultPackages =
      [ pkgs.swaylock ];
  };
  # I can't live without my fonts ;-)

  fonts = {
    fontDir.enable = true;
    #fonts = with pkgs; [
    #  (nerdfonts.override {
    #    fonts = [
    #      "FiraCode"
    #      "DroidSansMono"
    #      "SourceCodePro"
    #      "Ubuntu"
    #      "Meslo"
    #      "Iosevka"
    #    ];
    #  })
    #  noto-fonts-emoji
    #  kochi-substitute
    #  meslo-lg
    #  siji
    #  unifont
    #  open-sans
    #  liberation_ttf
    #  liberation-sans-narrow
    #  ttf_bitstream_vera
    #  libertine
    #  ubuntu_font_family
    #  gentium
    #  jetbrains-mono
    #  source-code-pro
    #  dina-font
    #  tamzen
    #  proggyfonts
    #  dejavu_fonts
    #  corefonts
    #  inconsolata
    #  terminus_font
    #  mononoki
    #];
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
