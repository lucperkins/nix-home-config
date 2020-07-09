{ config, lib, pkgs, ... }:

let
  baseImports = [
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./tmux.nix
  ];
in {
  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
  home.username = "lucasperkins";
  home.homeDirectory = "/Users/lucasperkins";
  home.stateVersion = "20.09";

  imports = baseImports;

  home.packages = with pkgs; [
    adoptopenjdk-bin
    bazel
    crystal
    curl
    dhall
    direnv
    elixir
    erlang
    fd
    fzf
    gitAndTools.gh
    go
    htop
    httpie
    hugo
    jq
    minikube
    nodejs
    packer
    python3
    ripgrep
    ruby
    rustup
    shards
    terraform
    tokei
    tree
    xsv
    yarn
    youtube-dl
  ];
}
