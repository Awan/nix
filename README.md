![wayland](https://user-images.githubusercontent.com/42554663/182757863-fee0c31c-6a2c-4804-82a9-61c096783476.png)

![x1c running NixOS](https://user-images.githubusercontent.com/42554663/181168480-c05092dd-5914-4f80-954b-f459e7317800.png)

## NixOS dotfiles with Home-Manager

# Installation

- After partitioning, formatting and mounting the filesystems, run:

    ```shell
    nixos-generate-config --root /mnt
    nix --experimental-features develop "nix-command flakes"
    nixos-install --flake .#x1c
    ```

- To apply dotfiles, run:

    ```shell
    home-manager switch --flake .#ak@x1c
    ```
