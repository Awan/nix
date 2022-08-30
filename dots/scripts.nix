{ lib, pkgs, config, ... }:


{

  # symlink bin scripts to ~/.local/bin

  home.file.".local/bin".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dots/bin";

  # some more scripts

  home.packages = [

    (pkgs.writeShellScriptBin "cmus-tags" ''
      current_music_file="$(${pkgs.cmus}/bin/cmus-remote -C 'echo {}')"
      if [ -f "$current_music_file" ];
      then
          ${config.home.sessionVariables.TERMINAL} -e ${pkgs.mp3info}/bin/mp3info -i "$current_music_file" &
      else
          echo "Sorry, couldn't find selected track!" >&2
      fi
      '')

    (pkgs.writeShellScriptBin "mybgs" ''
      filename="$(${pkgs.coreutils}/bin/basename "$1")"
      info="$(${pkgs.imagemagick}/bin/convert "$1" -format "%[fx:int(mean*100)]" info:)"

      if (( info < 45 )); then
          destination=dark
      else
          destination=light
      fi

      install -Dvm644 "$1" "$HOME/pix/wall/$destination/$filename"
      '')
  ];

}
