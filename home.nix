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
    bash
    bat
    bazel
    crystal
    curl
    dhall
    direnv
    elixir
    erlang
    exa
    fd
    fzf
    gitAndTools.delta
    gitAndTools.gh
    go
    htop
    httpie
    hugo
    jq
    kubectl
    kubectx
    linkerd
    minikube
    nodejs
    packer
    python3
    python38Packages.pip
    ripgrep
    ruby
    rustup
    shards
    skaffold
    starship
    terraform
    tilt
    tokei
    tree
    xsv
    yarn
    youtube-dl
  ];
}
