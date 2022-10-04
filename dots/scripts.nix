{ lib, pkgs, config, ... }:

{

  # symlink bin scripts to ~/.local/bin

  home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix/dots/bin";

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
    (pkgs.writeShellScriptBin "mkvid" ''
      output="$1"
      ${pkgs.wf-recorder}/bin/wf-recorder -f $output -c h264_vaapi -d /dev/dri/renderD128 -a -t -F hwupload,scale_vaapi=format=nv12
    '')
    # gimme a dir and I'll show you the pics... Hit M to mark them and get em into stdout/file...
    (pkgs.writeShellScriptBin "pics" ''
      dir="$1"
      [[ -z "$dir" ]] && echo "Please enter a directory name!" && exit 1
      images_checking()
      {
        ${pkgs.findutils}/bin/find "$dir" -type f \( -iname '*.jpg' \)\
        -o \( -iname '*.jpeg' \) -o \( -iname '*.png' \)\
        -o \( -iname '*.gif' \)
      }
      view_images()
      {
        ${pkgs.sxiv}/bin/sxiv -iota -N 'scratchpad' 2>/dev/null

      }

      images_checking | view_images
    '')
    (pkgs.writeShellScriptBin "encme" ''
      files="$1"
      recipient="$HOME/.ssh/id_ed25519.pub"
      ${pkgs.age}/bin/age -R $recipient $files > $files.age
      '')
  ];
}
