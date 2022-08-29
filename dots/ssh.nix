{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/%r@%h:%p";
    controlPersist = "30m";
    serverAliveInterval = 60;
    extraConfig = ''
      HostKeyAlgorithms ssh-ed25519,ecdsa-sha2-nistp256,ssh-rsa
    '';
  };
}
