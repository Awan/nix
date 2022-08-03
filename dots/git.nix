{ pkgs, ... }:


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

  programs.git = {
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
        lg = "log --pretty=format:\%C(yellow)%h %ar %C(auto)%d %Creset %s, %Cblue%cn\ --graph --all";
        st = "stash save --include-untracked";
        m = "commit --message";
        pop = "stash pop";
        amd = "commit --amend --no-edit";
        force = "push --force-with-lease";
        dirs = "!f(){ git diff --dirstat=files,0 HEAD~1 | awk '{print $2}' | cut -d '/' -f 1 | sort | uniq ; }; f";
        tp = "rev-parse --show-toplevel";
        d = "diff";
        dc = "diff --cached";
        s = "status";
    };

  };

}
