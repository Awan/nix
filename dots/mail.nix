{ pkgs, ... }: {
  services = {
    mbsync = {
      enable = true;
      #configFile = "${HOME}"/.mbsyncrc;
      frequency = "*:0/3";
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
        ignore = [ ];
      };
      extraConfig = {
        user = {
          "name" = "Abdullah Khabir";
          "primary_email" = "abdullah@abdullah.today";
          "other_email" = "abdullah@abdullah.solutions";
        };
        database = { "path" = ".mail"; };
      };
    };
  };
}
