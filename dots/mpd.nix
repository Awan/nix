{ pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = "~/mus";
    network = { listenAddress = "any"; port = 6600; startWhenNeeded = true; };
    extraConfig = ''
      restore_paused "no"
      log_level "default"
      playlist_directory "~/mus/playlists"
      log_file "syslog"
      pid_file "/tmp/mpd.pid"
      #state_file "~/.config/mpd/state"
      #sticker_file "~/.config/mpd/sticker.sql"
      max_output_buffer_size "100000"
      save_absolute_paths_in_playlists "yes"
      #metadata_to_use "artist,album,title,track,name,genra,date,composer,performer,disc"
      auto_update "yes"
      auto_update_depth "5"
      follow_outside_symlinks "yes"
      follow_inside_symlinks "yes"
      zeroconf_enabled "yes"
      zeroconf_name "AK media"
      volume_normalization "yes"
      filesystem_charset "UTF-8"
      input {
        plugin "curl"
      }
      audio_output {
        type "httpd"
        name "AK media"
        encoder "vorbis"
        port "8000"
        quality "7.0"
        format "44100:16:1"
        always_on "yes"
        tags "yes"
        max_clients "0"
      }
      audio_output {
        type "pulse"
        name "AK pulse"
        mixer_type "software"
      }
      audio_output {
        type "pipewire"
        name "AK pipewire"
        mixer_type "software"
      }
      audio_output {
        type "fifo"
        name "AK visualizer"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
      '';
  };
}
