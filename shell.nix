{ config, lib, pkgs, ... }:

let
  shellAliases = {
    l = "exa";
    ll = "ls -lh";
    ls = "exa";
    cat = "bat";
    dk = "docker";
    k = "kubectl";
    szsh = "source $HOME/.zshrc";
  };
in {
  home.packages = with pkgs; [
    bat
    exa
  ];

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;

    sessionVariables = {
      PATH = "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH";
      EDITOR = "nvim";
      GOPATH = "$HOME/go";
    };

    initExtra = ''
      source ~/.zshrc
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "muse";
    };
  };
}