{ pkgs, ... }:

{
  xsession = {
    enable = true;
    #pointerCursor = { name = "ul_angle"; };
    windowManager = {
      #command = "bspwm -c $HOME/.config/bspwm/bspwmrc";
      #bspwm = {
      #  enable = true;
      startupPrograms = [
        "sxhkd -c ~/.config/sxhkd/sxhkdrc"
        "mako"
        "xset s 30 30"
        "xsetroot -cursor_name ul_angle"
        "xss-lock -n ~/.local/bin/dim_screen -- ~/.local/bin/locker"
        "$HOME/.local/bin/mypanel"
      ];
    };
  };
}
