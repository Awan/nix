{ pkgs, config, ... }:

###############################################################
#                                                             #
# In the name of Allah, the most Gracious, the most Merciful. #
#                                                             #
#  ▓▓▓▓▓▓▓▓▓▓                                                 #
# ░▓ Author ▓ Abdullah <https://abdullah.today>               #
# ░▓▓▓▓▓▓▓▓▓▓                                                 #
# ░░░░░░░░░░                                                  #
#                                                             #
# ░█▀▀░▀█▀░▀█▀░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀                        #
# ░█░█░░█░░░█░░█░░░█░█░█░█░█▀▀░░█░░█░█                        #
# ░▀▀▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀                        #
#                                                             #
###############################################################

{

  xdg.configFile."git/allowed_signers" .source =
    config.lib.file.mkOutOfStoreSymlink ./git/allowed_signers;

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Abdullah Khabir";
    userEmail = "abdullah@abdullah.solutions";
    aliases = {
      last = "log -1 HEAD";
      bD = "branch -D";
      bm = "branch -m";
      co = "checkout";
      cob = "checkout -b";
      cp = "cherry-pick";
      cc = "cherry-pick --continue";
      cm = "switch -";
      b = "branch";
      c = "commit";
      ca = "commit -a";
      lg =
        "log --pretty=format:%C(yellow)%h %ar %C(auto)%d %Creset %s, %Cblue%cn --graph --all";
      st = "stash save --include-untracked";
      m = "commit --message";
      pop = "stash pop";
      amd = "commit --amend --no-edit";
      force = "push --force-with-lease";
      dirs =
        "!f(){ git diff --dirstat=files,0 HEAD~1 | awk '{print $2}' | cut -d '/' -f 1 | sort | uniq ; }; f";
      tp = "rev-parse --show-toplevel";
      d = "diff";
      dc = "diff --cached";
      s = "status";
    };

    delta = {
      #enable = true;
      options = {
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };

    diff-so-fancy = {
      #enable = true;
      changeHunkIndicators = true;
      markEmptyLines = true;
      rulerWidth = 3;
      stripLeadingSymbols = true;
      useUnicodeRuler = true;
    };

    difftastic = {
      enable = true;
      background = "dark";
      color = "auto";
      display = "side-by-side-show-both";
    };

    ignores = [
      "*.bak"
      "*.tmp"
      ".vscode"
      "~/bin/*"
      "vim/.vim/undodir/*"
      "vim/.vim/view/*"
      "!vim/.vim/undodir/.heygitkeepme"
      "!vim/.vim/view/.heygitkeepme"
      "mpv/.config/mpv/watch_later/*"
      "!mpv/.config/mpv/watch_later/.heygitkeepme"
      "[._]*.s[a-v][a-z]"
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"
      "Session.vim"
      ".netrwhist"
      "*~"
      "[._]*.un~"
      "*.rbc"
      ".env"
      "*.sql"
      "*.sqlite"
      "*.log"
      ".pry_history.rb"
      ".yardoc/"
      "*~"
      ".directory"
      ".Trash-*"
      "[._]*.s[a-w][a-z]"
      "[._]s[a-w][a-z]"
      "*.un~"
      ".netrwhist"
      "__pycache__/"
      "*.py[cod]"
      "*$py.class"
      "*.so"
      ".Python"
      "env/"
      "build/"
      "develop-eggs/"
      "dist/"
      "downloads/"
      "eggs/"
      ".eggs/"
      "lib/"
      "lib64/"
      "parts/"
      "sdist/"
      "var/"
      "*.egg-info/"
      ".installed.cfg"
      "*.egg"
      "*.manifest"
      "*.spec"
      "pip-log.txt"
      "pip-delete-this-directory.txt"
      "htmlcov/"
      ".tox/"
      ".coverage"
      ".coverage.*"
      ".cache"
      "nosetests.xml"
      "coverage.xml"
      "*,cover"
      "*.mo"
      "*.pot"
      "*.log"
      "docs/_build/"
      "target/"
      "#Pkgfile"
      "#.footprint"
      "#.md5sum"
      "#.signature"
      "fonts/.local/share/fonts/.uuid"
      "fonts/.local/share/fonts/fonts.dir"
      "systemd/.config/systemd/user/default.target.wants/*"
      "systemd/.config/systemd/user/sockets.target.wants/*"
      "ipython/.ipython/profile_default/db/"
    ];

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5+9bzx03s4Yg0o96hZTaRHqEzhWD6jT/aYgNKFbhwZ Abdullah Khabir";
      signByDefault = true;
    };

    extraConfig = {
      push = {
        default = "current";
        followTags = true;
      };
      tag = { forceSignAnnotated = true; };
      core = {
        autocrlf = "input";
        safecrlf = true;
        editor = "$EDITOR";
        symlinks = true;
        excludesfile = "~/.config/git/ignore";
        whitespace =
          "trailing-space,-space-before-tab,indent-with-non-tab,cr-at-eol";
        commentchar = "auto";
        preloadindex = true;
        notesRef = "refs/notes/commits";
        quotepath = true;
      };
      help = { autocorrect = 1; };
      credential = { helper = "cache"; };
      sendemail = {
        smtpEncryption = "tls";
        smtpServer = "smtp.yandex.com";
        smtpUser = "abdullah@abdullah.today";
        smtpServerPort = 587;
      };
      log = { abbrevCommit = true; };
      tag = { sort = "version:refname"; };
      pull = { rebase = true; };
      status = {
        branch = true;
        showStash = true;
        submodulesummary = true;
        showUntrackedFiles = "all";
        relativePaths = true;
      };
      rebase = {
        autoStash = true;
        instructionFormat = "%s [%an]";
      };
      sequence = { editor = "interactive-rebase-tool"; };
      merge = {
        tool = "$EDITOR";
        conflictstyle = "diff3";
      };
      github = { user = "Awan"; };
      gitlab = { user = "Abdullah"; };
      notabug = { user = "Abdullah"; };
      init = { defaultBranch = "main"; };
      advice = {
        addignoredfile = true;
        waitingForEditor = true;
      };
      gpg = {
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      };
    };
  };
}
