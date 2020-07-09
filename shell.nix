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
    reload = "home-manager switch && szsh";
    garbage = "nix-collect-garbage";
  };
in {
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
    enableCompletion = true;
    history.extended = true;

    initExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh;
        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      fi # added by Nix installer

      # Load environment variables; this approach allows me to not commit secrets
      # like API keys and such
      if [ -e ~/.env ]; then
        source ~/.env
      fi

      eval "$(starship init zsh)"
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
