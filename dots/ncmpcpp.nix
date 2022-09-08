{ pkgs, config, ... }:

{
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "d";
        command = "delete_playlist_items";
      }
      {
        key = "ctrl-u";
        command = "page_up";
      }
      {
        key = "ctrl-d";
        command = "page_down";
      }
      {
        key = "2";
        command = "show_playlist";
      }
      {
        key = "1";
        command = "show_browser";
      }
      {
        key = "H";
        command = "jump_to_browser";
      }
      {
        key = "y";
        command = "toggle_single";
      }
      {
        key = "n";
        command = "next_found_item";
      }
      {
        key = "N";
        command = "previous_found_item";
      }
      {
        key = "g";
        command = "move_home";
      }
      {
        key = "h";
        command = "previous_column";
      }
      {
        key = "l";
        command = "next_column";
      }
      {
        key = "O";
        command = "show_lyrics";
      }
      {
        key = "A";
        command = "add_selected_items";
      }
      {
        key = "G";
        command = "move_end";
      }
      {
        key = "q";
        command = "quit";
      }
    ];
    mpdMusicDir = "${config.home.homeDirectory}/mus";
    settings = {
      user_interface = "alternative";
      mpd_host = "localhost";
      mpd_port = 6600;
      ncmpcpp_directory = "~/.config/ncmpcpp";
      lyrics_directory = "~/mus/lyrics";
      progressbar_look = "─╼";
      song_library_format = "{%t - }{%a}|{%f}";
      song_status_format = "{(%l) }{%a - }{%t}|{%f}";
      song_columns_list_format = "(35)[red]{t} (15)[magenta]{b} (50)[cyan]{a}";
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "AK visualizer";
      visualizer_in_stereo = "yes";
      visualizer_color = "41, 83, 119, 155, 185, 215, 209, 203, 197, 161";
      visualizer_look = "●┃";
      startup_screen = "playlist";
      playlist_show_remaining_time = "yes";
      playlist_shorten_total_times = "yes";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";
      playlist_show_mpd_host = "no";
      playlist_separate_albums = "yes";
      startup_slave_screen_focus = "no";
      jump_to_now_playing_song_at_start = "yes";
      enable_window_title = "no";
      header_visibility = "no";
      titles_visibility = "no";
      message_delay_time = 1;
      statusbar_visibility = "yes";
      colors_enabled = "yes";
      cyclic_scrolling = "no";
      space_add_mode = "add_remove";
      clock_display_seconds = "yes";
      display_remaining_time = "no";
      external_editor = "\${EDITOR}";
      use_console_editor = "yes";
    };
  };
}
