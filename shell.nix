# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let
  # Set all shell aliases programatically
  shellAliases = {
    # Aliases for commonly used tools
    hm = "humioctl";
    grep = "grep --color=auto";
    circleci = "circleci-cli";
    just = "just --no-dotenv";
    diff = "diff --color=auto";
    iex = "iex --dot-iex ~/.iex.exs";
    cat = "bat";
    we = "watchexec";
    find = "fd";
    cloc = "tokei";
    l = "exa";
    ll = "ls -lh";
    ls = "exa";
    dk = "docker";
    k = "kubectl";
    dc = "docker-compose";
    bazel = "bazelisk";
    md = "mdcat";
    mk = "minikube";
    start-docker = "docker-machine start default";
    tf = "terraform";

    # Reload zsh
    szsh = "source ~/.zshrc";

    # Reload home manager and zsh
    reload = "home-manager switch && source ~/.zshrc";

    # Nix garbage collection
    garbage = "nix-collect-garbage -d && docker image prune --force";

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

      # Autocomplete for various utilities
      source <(helm completion zsh)
      source <(kubectl completion zsh)
      source <(doctl completion zsh)
      source <(minikube completion zsh)
      source <(gh completion --shell zsh)
      rustup completions zsh > ~/.zfunc/_rustup
      source <(cue completion zsh)
      source <(npm completion zsh)

      # direnv setup
      eval "$(direnv hook zsh)"

      # Start up Docker daemon if not running
      if [ $(docker-machine status default) != "Running" ]; then
        docker-machine start default
      fi

      # Docker env
      eval "$(docker-machine env default)"

      # Load asdf
      . ~/.asdf/asdf.sh

      # direnv hook
      eval "$(direnv hook zsh)"
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
