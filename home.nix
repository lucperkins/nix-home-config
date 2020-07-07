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
    curl
    dhall
    direnv
    elixir
    fd
    fzf
    gitAndTools.gh
    go
    httpie
    jq
    ripgrep
    tokei
    tree
    xsv
    youtube-dl
  ];
}
