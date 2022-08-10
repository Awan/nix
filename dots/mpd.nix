{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    dataDir = "$XDG_DATA_HOME/mpd";
    dbFile = "\${dataDir}/tag_cache";
    musicDirectory = "$HOME/mus";
    network = { listenAddress = "any"; port = 6600; startWhenNeeded = true };
    playlistDirectory = "\${musicDirectory}/playlists";
    extraConfig = ''
      restore_paused = no
      log_level = "default"
      '';
  };
}
