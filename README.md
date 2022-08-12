![wayland](https://user-images.githubusercontent.com/42554663/182757863-fee0c31c-6a2c-4804-82a9-61c096783476.png)

![x1c running NixOS](https://user-images.githubusercontent.com/42554663/181168480-c05092dd-5914-4f80-954b-f459e7317800.png)

[![asciicast](https://asciinema.org/a/513631.svg)](https://asciinema.org/a/513631)

## NixOS dotfiles with Home-Manager

# Installation

- After partitioning, formatting and mounting the filesystems, run:

    ```shell
    # Just to be sure, that /etc/nixos is created...
    nixos-generate-config --root /mnt
    ```

- Clone this repository, edit `nixos/configuration.nix` and `nixos/hardware-configuration.nix`... Replace `UUID` with hardware new UUIDs, push changes. If you're not [me](https://abdullah.today/about), you can't push changes. So just use that clone after editing those files:

    ```shell
    cd cloned_repo_path
    nixos-install --impure --flake .#x1c
    ```

    `x1c` is my hostname. So if you want to change it, don't forget to replace it three places:

    - 1  in `nixos/configuration.nix`
    - 2  in `flake.nix`
    - 3  when invoking `nixos-install`

- After installation, install `home-manager` and then give it this flake to copy dotfiles.

    ```shell
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz
    nix-channel --update
    nix-shell '<home-manager>' -A install
    home-manager switch --flake github:Awan/nix#ak
    ```
