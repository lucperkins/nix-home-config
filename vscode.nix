# Visual Studio Code settings

{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.colorTheme" = "GitHub Dark";
    };

    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
    ];
  };
}