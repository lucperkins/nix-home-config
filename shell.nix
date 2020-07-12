{ config, lib, pkgs, ... }:

let
  shellAliases = {
    we = "watchexec";
    find = "fd";
    cloc = "tokei";
    l = "exa";
    ll = "ls -lh";
    ls = "exa";
    dk = "docker";
    k = "kubectl";
    dc = "docker-compose";
    szsh = "source $HOME/.zshrc";
    reload = "home-manager switch && source ~/.zshrc";
    garbage = "nix-collect-garbage";
    installed = "nix-env --query --installed";
  };
in {
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fish = {
    inherit shellAliases;
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

      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys
      if [ -e ~/.env ]; then
        source ~/.env
      fi

      # Start up Starship shell
      eval "$(starship init zsh)"

      # kubectl autocomplete
      source <(kubectl completion zsh)

      # direnv setup
      eval "$(direnv hook zsh)"
    '';

    #oh-my-zsh = {
    #  enable = true;
    #  plugins = [
    #    "docker"
    #    "docker-compose"
    #    "dotenv"
    #    "git"
    #    "sudo"
    #  ];
    #  theme = "muse";
    #};
  };
}
