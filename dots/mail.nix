{ pkgs, config, lib, ... }: {

  # symlink mbsyncrc

  xdg.configFile."mbsync/mbsyncrc".source =
    config.lib.file.mkOutOfStoreSymlink ./mail/mbsyncrc;

  # symlink mutt recursively

  xdg.configFile."mutt" = {
    source = config.lib.file.mkOutOfStoreSymlink ./mail/mutt;
    recursive = true;
  };

  services = {
    mbsync = {
      enable = false;
      configFile = "${config.xdg.configHome}/mbsync/mbsyncrc";
      frequency = "*:0/3";
      preExec = "${pkgs.coreutils}/bin/mkdir -p %h/.local/share/email/x1c"; # to create these directories on first run on fresh install
      postExec = "${pkgs.notmuch}/bin/notmuch new";
    };
  };
  programs = {
    notmuch = {
      enable = true;
      maildir = { synchronizeFlags = true; };
      search = { excludeTags = [ "deleted" "spam" ]; };
      new = {
        tags = [ "unread" "inbox" ];
        ignore = [ ".mbsyncstate" ".uidvalidity" ];
      };
      extraConfig = {
        user = {
          "name" = "Abdullah Khabir";
          "primary_email" = "abdullah@abdullah.solutions";
          "other_email" = "abdullah@abdullah.today";
        };
        database = { "path" = ".mail/gmail"; };
      };
    };
  };
  programs.msmtp = {
    enable = true;
    extraConfig = ''
      defaults
      auth on
      tls on
      tls_starttls on
      tls_trust_file /etc/ssl/certs/ca-certificates.crt
      logfile ~/.msmtp.log
      account ak
      host smtp.gmail.com
      port 587
      eval "echo user $(age -i ~/.ak.txt -d ~/nix/secrets/workspaces_user.age)"
      from Abdullah Khabir
      passwordeval "echo $(age -i ~/.ak.txt -d ~/nix/secrets/workspaces_pass.age)"
      account default: ak
    '';
  };

  # Symlink goimapnotify.conf
  xdg.configFile."goimapnotify/goimapnotify.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./mail/goimapnotify.conf;

  # Create a systemd unit for goimapnotify
  systemd.user.services.gmail-notify = {
    Unit = {
      Description = [ "Execute scripts on IMAP mailbox changes (new/deleted/updated messages) using IDLE, golang version." ];
    };
    Service = {
      Type = [ "simple" ];
      Environment = [ "DISPLAY=wayland-1" ];
      ExecStart = [ "${pkgs.goimapnotify}/bin/goimapnotify -conf %h/.config/goimapnotify/goimapnotify.conf" ];
      Restart = [ "always" ];
      RestartSec = 30;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
