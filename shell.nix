# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let
  # Set all shell aliases programatically
  shellAliases = {
    # Invoke global just commands
    ".j" = "just --justfile ~/.justfile --working-directory ~";

    # Aliases for commonly used tools
    we = "watchexec";
    find = "fd";
    cloc = "tokei";
    j = "just";
    l = "exa";
    ll = "ls -lh";
    ls = "exa";
    dk = "docker";
    k = "kubectl";
    dc = "docker-compose";
    bazel = "bazelisk";
    md = "mdcat";

    # Reload zsh
    szsh = "source ~/.zshrc";

    # Reload home manager and zsh
    reload = "home-manager switch && source ~/.zshrc";

    # Nix garbage collection
    garbage = "nix-collect-garbage";

    # See which Nix packages are installed
    installed = "nix-env --query --installed";
  };
in {
  # Fancy filesystem navigator
  programs.broot = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  # fish shell settings
  programs.fish = {
    inherit shellAliases;
    enable = true;
  };

  # zsh settings
  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;

    # Called whenever zsh is initialized
    initExtra = ''
      # Nix setup (environment variables, etc.)
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh;
        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      fi

      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys to Git
      if [ -e ~/.env ]; then
        source ~/.env
      fi

      # Start up Starship shell
      eval "$(starship init zsh)"

      # kubectl autocomplete
      source <(kubectl completion zsh)

      # direnv setup
      eval "$(direnv hook zsh)"

      # Load global justfile
      alias .j='just --justfile ~/.justfile --working-directory ~'
    '';

    # Disable oh my zsh in favor of Starship shell
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
