{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      enableSyntaxHighlighting = false;
      autocd = true;
      enableAutosuggestions = true;

      initExtra = ''
        #PS1='[1;32m %n at %m  %~ >>> [0m'
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      '';

      envExtra = ''
        typeset -U path
        path=(~/.cargo/bin ~/go/bin ~/.perl5/bin ~/.gem/ruby/2.7.0/bin ~/.local/bin ~/.local/lib ~/.pyenv/bin /usr/sbin /usr/bin/vendor_perl /sbin $path[@])
        BROWSER=$(which google-chrome-stable)
        # Set Terminal
        TERMINAL=alacritty
        #if [ -S ~/.urxvt/urxvtd-x1c ]; then
        #    TERMINAL=urxvtc
        #fi
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
        export SXHKD_SHELL=$(which dash)
        #export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh
        #gpg-connect-agent updatestartuptty /bye >/dev/null
        #${pkgs.keychain}/bin/keychain $HOME/.ssh/id_ed25519 >/dev/null 2>&1
        #[[ -f ~/.keychain/$HOST-sh ]] && source ~/.keychain/$HOST-sh
        export PYENV_ROOT="$HOME/.pyenv"
        export _JAVA_AWT_WM_NONREPARENTING=1
        export GIT_DISCOVERY_ACROSS_FILESYSTEM=true
      '';

      profileExtra = ''
        # Start river at login
        if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          #exec startx -- vt1 -keeptty &>/dev/null
          #Hyprland > /tmp/hypr-$USER.log 2>&1
          sway 

          #sx
          logout
        elif [[ $(tty) != /dev/tty1 ]]; then
          #sudo loadkeys $HOME/.loadkeysrc
          tmux has-session -t $USER || tmux new-session -t $USER && tmux attach-session -t $USER
        fi
      '';

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "$ZDOTDIR/.zsh_history";
        save = 100000;
        share = true;
        size = 100000;
      };

      initExtraFirst = ''
        bindkey -v
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
      '';

      completionInit = ''
        zle -C hist-complete complete-word _generic
        zmodload -i zsh/complist
        zstyle ':completion:*' rehash true
        bindkey -M menuselect 'h' vi-backward-char
        bindkey -M menuselect 'j' vi-down-line-or-history
        bindkey -M menuselect 'k' vi-up-line-or-history
        bindkey -M menuselect 'l' vi-forward-char
        bindkey -v '^?' backward-delete-char
        bindkey '^X^X' hist-complete
        setopt EXTENDED_GLOB
        setopt NOMATCH
        setopt NO_BEEP
        setopt AUTO_PUSHD
        setopt PUSHD_IGNORE_DUPS
        setopt no_clobber
        setopt globstarshort
        setopt rm_star_wait
        setopt correct_all
        unsetopt always_to_end
        unsetopt menu_complete
        setopt glob_complete
        setopt COMPLETE_IN_WORD
        setopt auto_param_slash
        setopt auto_name_dirs
        setopt auto_list
        zstyle ':completion:*' menu select=1
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*:parameters'  list-colors '=*=32'
        zstyle ':completion:*:commands' list-colors '=*=1;34'
        zstyle ':completion:*:builtins' list-colors '=*=1;38;5;142'
        zstyle ':completion:*:aliases' list-colors '=*=2;38;5;128'
        zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'
        zstyle ':completion:*:options' list-colors '=^(-- *)=34'
        zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
        zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'
        zstyle ':completion:*:messages' format $'\e[01;35m -- %d -- \e[00;00m'zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
        zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d -- \e[00;00m'
        zstyle ':completion:*:corrections' format $'\e[01;33m -- %d -- \e[00;00m'
        zstyle ':completion:*:default' select-prompt $'\e[01;35m -- Match %M    %P -- \e[00;00m'
        zstyle ':completion:*' verbose yes
        bindkey -M menuselect '^@' accept-and-infer-next-history
        zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompdump"
        zstyle ':completion::*:-tilde-:*:*' group-order named-directories users
        zstyle ':completion::*:ssh:*:*' tag-order "users hosts"
        zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
        zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
        zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'
        zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'
        zstyle ':completion:*' list-dirs-first true
        zstyle :compinstall filename '~/.zshrc'
        zstyle ':completion:hist-complete:*' completer _history
        autoload -Uz compinit && compinit
      '';

      plugins = [
        {
          name = "ak-prompt";
          file = "zsh-history-substring-search.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "Awan";
            repo = "zsh-nix";
            rev = "06ab11b35807b8cfca16b9d6f3b70779e119bbbd";
            sha256 = "0l54lb0h22wawgh8srzlxd0mh4fkwhld5ld277c65wfmdpxhk42p";
          };
        }
        {
          name = "ak-prompt";
          file = "functions.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "Awan";
            repo = "zsh-nix";
            rev = "06ab11b35807b8cfca16b9d6f3b70779e119bbbd";
            sha256 = "0l54lb0h22wawgh8srzlxd0mh4fkwhld5ld277c65wfmdpxhk42p";
          };
        }
        {
          name = "ak-prompt";
          file = "aliases";
          src = pkgs.fetchFromGitHub {
            owner = "Awan";
            repo = "zsh-nix";
            rev = "06ab11b35807b8cfca16b9d6f3b70779e119bbbd";
            sha256 = "0l54lb0h22wawgh8srzlxd0mh4fkwhld5ld277c65wfmdpxhk42p";
          };
        }
        {
          name = "ak-prompt";
          file = "prompt.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "Awan";
            repo = "zsh-nix";
            rev = "06ab11b35807b8cfca16b9d6f3b70779e119bbbd";
            sha256 = "0l54lb0h22wawgh8srzlxd0mh4fkwhld5ld277c65wfmdpxhk42p";
          };
        }
      ];
    };
  };
}
