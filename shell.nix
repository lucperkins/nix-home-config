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
    reload = "home-manager switch";
  };
in {
  home.packages = with pkgs; [
    bat
    exa
  ];

  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;

    initExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
      . ~/.nix-profile/etc/profile.d/nix.sh;
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      fi # added by Nix installer

      # Load environment variables
      source ~/.env
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "docker-compose"
        "dotenv"
        "git"
        "sudo"
      ];
      theme = "muse";
    };
  };
}
