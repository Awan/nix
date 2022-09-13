{ config, ... }:

# My gpg setup

{

  services.gpg-agent = {
    enable = false;
    enableSshSupport = true;
    defaultCacheTtl = 1800;
    pinentryFlavor = "curses";
    sshKeys = [
      "B570891D89AD89E1D8B616867BA5505A39EB137C"
      "922D5C7DD8FCDC9D9449D58A5E8CC3EACC877833"
      "34F2A9992560BEF76CBD6C1E90F70E4A719633D9"
      "54CCE66B4542AB56EAF6FCD07F7F4A64D6AA9548"
    ];
  };
}
