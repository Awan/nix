{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ak";
  home.homeDirectory = "/home/ak";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Install some packages  
  home.packages = [
  pkgs.htop
  pkgs.zsh
  ];

  # Some services
  services = {
      gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentryFlavor = "curses";
      };
  };
 # Some programs
  programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        enableSyntaxHighlighting = true;
        autocd = true;
        enableAutosuggestions = true;
        shellAliases = {
            rbs="sudo -i nixos-rebuild switch";
            lsa="ls -lah";
            rami="shred -fzuv $@";
            li="ls -li";
            r="ranger $@";
            m="mpv";
            ip="ip --color=auto";
            gimp="((gimp > /dev/null 2>&1)&)";
            jtl="journalctl -f";
            ggc="cd ~/git/playground/";
            px="pwd | xclip"; 
            mouse="sudo modprobe -r psmouse; sleep 3; sudo modprobe psmouse";
            anydesk="anydesk && xmodmap ~/.Xmodmap";
            zq="zathura $HOME/kit/pdf/Quran/Quran.pdf &";
            jbs="JEKYLL_ENV=production bundle exec jekyll serve";
            du="du -h";
            colorize="toilet --gay -f term $@";
            xquery="xdg-mime query filetype $1";
            c="xclip-copyfile";
            p="xclip-pastefile";
            d="xclip-cutfile";
            z="zathura $1";
            cpwd="pwd | tr -d '\n' | xsel -ib";
            info="info --vi-keys";
            tmp="mkdir /tmp/$$ ; cd /tmp/$$";
            thumbs="sxiv -atrq '$@'";
            untmp="rm -rf /tmp/$$";
            dox="cd ~/dos";
            ipp="curl ipinfo.io/ip";
            img="imgur-screenshot $@";
            mwx="mplayer -vo fbdev2 -vf scale=931:580 -geometry 978:4 -ni $1";
            ta="\tmux a -t";
            sct="termite -t 'scratchpad' &";
            sxt="xfce4-terminal -T scratchpad &";
            subupdate="git submodule foreach git pull origin master";
            ncm="ncmpcpp 2>/dev/null";
            grep="grep --color=auto";
            egrep="egrep --color=auto";
            un="$EDITOR /home/ak/lab/notes/shell/zsh";
            ipy="ipython3";
            tmux="tmux has-session -t $USER || tmux new-session -s $USER &&  tmux -2 attach-session -t $USER";
            py="python3";
            cdw="cd ~/git/dwm; ls";
             pyc="export _JAVA_AWT_WM_NONREPARENTING=1 ; $HOME/bin/pycharm/bin/pycharm.sh $1";
            cdc="cd $HOME/cfg";
            chkill="ps ux | grep '[C]hrome --type=renderer'; | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill";
            pak="cd $HOME/git/ports/ak";
            psgrep="ps aux | grep $(echo $1 | sed 's/^\(.\)/[\1]/g')";
            tkill="\tmux kill-session -a";
            vte="$EDITOR ~/.config/termite/config";
            pgs="prt-get search";
            pt="sudo prt-get";
            pgf="prt-get fsearch";
            pgi="sudo prt-get install";
            ltd="ls *(m0)"; 
            lt="ls *(.m0)";
            ltr="ls -ltr";
            lnew="ls *(.om[1,3])"; 
            lsrdir="ls -d *(/om[1])";
            lH="ls -d .*"; 
            lh="ls -lh";
            pa="sudo pkgadd";
            ytvid="youtube-dl --restrict-filenames -o '~/mus/vid/%(title)s_%(width)sx%(height)s_%(upload_date)s.%(ext)s'";
            ytaudio="youtube-dl --restrict-filenames --extract-audio -o '~/mus/%(title)s_%(width)sx%(height)s_%(upload_date)s.%(ext)s'";
            sit="cd ~/git/mysite/";
            reboot="sudo reboot";
            api="sudo apt install --yes -V";
            aps="apt search $1";
            spy="lsof -i -P +c 0 +M";
            netlist="lsof -i -P | grep LISTEN";
            apg="sudo apt purge -V";
            xq="xbps-query";
            xi="sudo xbps-install";
            xr="sudo xbps-remove";
            vx="$EDITOR ~/.Xresources";
            vg="git config -e --global";
            vmc="$EDITOR ~/.config/nvim/init.vim";
            fst="sudo $EDITOR /etc/fstab";
            mutc="$EDITOR ~/.config/mutt/muttrc";
            msc="mbsync -VXa";
            ssr="simplescreenrecorder --start-hidden --no-systray";
            nv="$EDITOR /etc/nixos/configuration.nix";
            wtc="qutebrowser -s content.headers.user_agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36' web.whatsapp.com &";
            cdm="cd ~/mus";
            xf="xfce4-terminal";
            gd="git diff";
            cD="cd ~/sys/downloads";
            ds="dirs -v | head -n 10";
            lla="ls -la";
            lc="ls | wc -l";
            chmod="chmod --preserve-root";
            vc="$EDITOR ~/.vimrc";
            g="git";
            ter="\tmux a -r -t";
            tl="\tmux ls";
            gs="git status";
            apar="sudo apt autoremove -V";
            xp="xrdb -merge ~/.Xresources";
            cdv="cd ~/dev";
            gu="git push";
            vw="$EDITOR $HOME/.config/sway/config";
            top="htop";
            ga="git add";
            cdd="cd ~/.cfg";
            q="exit";
            sm="sudo mount";
            fk="$EDITOR ~/.zsh/functions";
            plz="sudo $(fc -ln -1)";
            rfz="source $HOME/.zshrc";
            vz="$EDITOR $HOME/.zshrc";
            rr="fc -s";
            df="df -h";
            S="systemctl";
            ss="sudo systemctl";
            cdg="cd $HOME/git";
            clock="ncmpcpp -s clock";
            cm="mutt 2>/dev/null";
            vp="$EDITOR $HOME/.config/polybar/config.ini";
            cp="cp -i";
            mv="mv -i";
            mi="mid3v2";
            mnv="mpv --no-video";
            mp="mpv --loop-file";
            mq="mpv --really-quiet --speed=0.50 --loop-file";
            ms="mpv --really-quiet --shuffle";
            hr="printf $(printf '\e[$(shuf -i 91-97 -n 1);1m%%%ds\e[0m\n' $(tput cols)) | tr ' ' =";
            starwars="telnet towel.blinkenlights.nl";
            e="evince";
            sv="sudo $EDITOR";
            rf="source $HOME/.bashrc";
            a="cd $HOME/.config";
            sk="autoscript";
            alis="$EDITOR ~/.zsh/custom-alias";
            yt="cd $HOME/mus/ && youtube-viewer && cd -";
            v3="$EDITOR $HOME/.config/i3/config";
            si="sudo pacman -S --needed";
            sr="sudo pacman -R";
            srs="sudo pacman -Rs";
            srsc="sudo pacman -Rsc";
            srn="sudo pacman -Rn";
            update="sudo pacman -Syu";
            ssi="pacman -Si";
            sqi="pacman -Qi";
            sq="pacman -Qs";
            pS="pacman -Ss";
            sqii="pacman -Qii";
            sqd="pacman -Ql";
            sqr="pacman -Fl";
            sqk="pacman -Qk";
            sqo="pacman -Qo";
            sqor="pacman -F";
            sor="pacman -Qdt";
            sde="pacman -Qet";
            sC="sudo pacman -Scc";
            sdw="sudo pacman -Sw";
            sil="sudo pacman -U";
            awq="$EDITOR $HOME/.config/qtile/config.py";
            vkt="$EDITOR $HOME/.config/kitty/kitty.conf";
            awb="$EDITOR $HOME/.config/bspwm/bspwmrc";
            awh="$EDITOR $HOME/.config/herbstluftwm/autostart";
            br="$EDITOR $HOME/.config/bspwm/external_rules";
            cdb="cd $HOME/.config/bspwm";
            awx="$EDITOR $HOME/.config/sxhkd/sxhkdrc";
            rfi="i3 restart";
            x="xdg-open";
            lf="leafpad";
            cfg-cava="$EDITOR $HOME/.config/cava/config";
            lilbak="cmus-remote -k -10";
            lilfor="cmus-remote -k +10";
            bigbak="cmus-remote -k -120";
            ct="cmus-remote -u";
            bigfor="cmus-remote -k +120";
            pup="bash $HOME/.config/polybar/launch.sh";
            cdi="cd $HOME/.config/i3/";
            cdp="cd $HOME/lab/pcc";
            cdpo="cd $HOME/.config/polybar";
            ll="ls -l";
            lss="ls -lh";
            k="clear";
            wars="telnet towel.blinkenlights.nl";
            moon="curl -sL http://wttr.in/moon | head -n-4";
            mount="mount | column -t";
            scrot="import png:- | xclip -selection c -t image/png";
            null="2>&1 >/dev/null";
            sudo="sudo -i";
            v="$EDITOR";
        };
        initExtra = ''
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
            ZVM_CURSOR_STYLE_ENABLED=false
            '';
        envExtra = ''
            typeset -U path
            path=(~/.cargo/bin ~/.perl5/bin ~/.gem/ruby/2.7.0/bin ~/.local/bin ~/.local/lib ~/.pyenv/bin /usr/sbin /usr/bin/vendor_perl /sbin $path[@])
            BROWSER=$(which google-chrome-stable)
            # Set Terminal
            #TERMINAL=alacritty
            if [ -S ~/.urxvt/urxvtd-x1c ]; then
                TERMINAL=urxvtc
            fi
            TERMCMD=$TERMINAL
            if [ -d ~/git/mysite ]; then
              export SITE="$HOME/git/mysite"
              export post="$SITE/content/posts"
            fi
            if [ -d ~/.local/bin ]; then
              export mpath="$HOME/.local/bin/"
            fi
            # Set editor
            set_editor() {
              export EDITOR="$@"
              export GIT_EDITOR="$@"
              export VISUAL="$@"
              alias v="$@"
            }
            # Get editor
            get_editor()
            {
                if (( $+commands[nvim] )); then
                    set_editor $(which nvim)
                elif
                    (( $+commands[vim] )); then
                    set_editor $(which vim)
                elif (( $+commands[vi] )); then
                    set_editor $(which vi)
                fi
            }
            get_editor
            XDG_DATA_HOME=$HOME/.local/share
            XDG_CONFIG_HOME=$HOME/.config
            XDG_CACHE_HOME=$HOME/.cache
            XDG_RUNTIME_DIR=/run/user/`id -u`
            if command -v pyenv 1>/dev/null 2>&1; then
              eval "$(pyenv init -)"
            fi
            if [ "$TERM" = "linux" ]; then
                echo -en "\e]P0000000" #black
                echo -en "\e]P85e5e5e" #darkgrey
                echo -en "\e]P18a2f58" #darkred
                echo -en "\e]P9cf4f88" #red
                echo -en "\e]P2287373" #darkgreen
                echo -en "\e]PA53a6a6" #green
                echo -en "\e]P3914e89" #darkyellow
                echo -en "\e]PBbf85cc" #yellow
                echo -en "\e]P4395573" #darkblue
                echo -en "\e]PC4779b3" #blue
                echo -en "\e]P55e468c" #darkmagenta
                echo -en "\e]PD7f62b3" #magenta
                echo -en "\e]P62b7694" #darkcyan
                echo -en "\e]PE47959e" #cyan
                echo -en "\e]P7899ca1" #lightgrey
                echo -en "\e]PFc0c0c0" #white
                clear 
            fi
            export GPG_TTY=$(tty)
            export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh
            gpg-connect-agent updatestartuptty /bye >/dev/null
            export PYENV_ROOT="$HOME/.pyenv"
            export _JAVA_AWT_WM_NONREPARENTING=1
            export GIT_DISCOVERY_ACROSS_FILESYSTEM=true
                '';
        profileExtra = ''
            # Start X at login
            if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
              exec startx -- vt1 -keeptty &>/dev/null
              logout
            elif [[ $(tty) != /dev/tty1 ]]; then
              sudo loadkeys $HOME/.loadkeysrc
              tmux has-session -t $USER || tmux new-session -t $USER && tmux attach-session -t $USER
            fi
            '';
      };
  };
}
