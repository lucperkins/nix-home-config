# Nix configuration

This repo houses the [Home Manager](https://github.com/rycee/home-manager) configuration that I use for my macOS laptop. Here are some tools that I install and configure this way:

* Neovim
* tmux
* Git
* zsh and oh my zsh (including aliases and environment variables)
* curl
* Elixir (`mix`, `elixir`, `elixirc`, etc.)
* HTTPie
* jq
* Go
* fzf
* htop
* youtube-dl
* fd
* bat
* exa
* ripgrep
* tokei
* tree
* xsv
* Dhall

This list will surely grow over time as new packages are installed.

## Debts

This config is heavily indebted to [srid/nix-config](https://github.com/srid/nix-config).

## Usage

To use these configs yourself as a starter:

1. Install [Nix](https://nixos.org/download.html)
1. Install [Home Manager](https://github.com/rycee/home-manager)
1. `cd ~/.config`
1. `rm -rf nixpkgs`
1. `git clone https://github.com/lucperkins/nix-home-config nixpkgs`
1. `home-manager switch && source ~/.zshrc`

