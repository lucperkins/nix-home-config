# Git settings

{ config, lib, pkgs, ... }:

let
  vscode = pkgs.vscode;
in {
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Luc Perkins";
    userEmail = "lucperkins@gmail.com";

    # Replaces ~/.gitignore
    ignores = [
      ".DS_Store"
      ".idea/"
      "*.swp"
      "built-in-stubs.jar"
      "dumb.rdb"
      ".elixir_ls/"
    ];

    # Replaces aliases in ~/.gitconfig
    aliases = {
      bd = "branch -D";
      br = "branch";
      cam = "commit -am";
      co = "checkout";
      cob = "checkout -b";
      ci = "commit";
      cm = "commit -m";
      cp = "commit -p";
      d = "diff";
      dco = "commit -s --amend";
      s = "status";
      pr = "pull --rebase";
      st = "status";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      whoops = "reset --hard";
      wipe = "commit -s";
    };

    # Global Git config
    extraConfig = {
      core = {
        editor = "vim";
        pager = "delta --dark";
        whitespace = "trailing-space,space-before-tab";
      };

      protocol.keybase.allow = "always";
      credential.helper = "osxkeychain";
      pull.rebase = "false";
    };
  };
}
