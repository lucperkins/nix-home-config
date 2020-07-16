{ config, lib, pkgs, ... }:

let
  # Import other Nix files
  baseImports = [
    ./git.nix
    ./neovim.nix
    ./shell.nix
    ./tmux.nix
    ./vscode.nix
  ];

  # Handly shell command to view the dependency tree of Nix packages
  depends = pkgs.writeScriptBin "depends" ''
    dep=$1
    nix-store --query --requisites $(which $dep)
  '';
in {
  # Allow non-free (as in beer) packages
  nixpkgs.config.allowUnfree = true;

  # Enable Home Manager
  programs.home-manager.enable = true;

  home.username = "lucperkins";
  home.homeDirectory = "/Users/lucperkins";
  home.stateVersion = "20.09";

  # Pull in other config files
  imports = baseImports;

  # Miscellaneous packages (in alphabetical order)
  home.packages = with pkgs; [
    adoptopenjdk-bin # Java
    antora # AsciiDoc static site generator
    bash # /bin/bash
    bat # cat replacement written in Rust
    bazelisk # Polyglot build tool from Google
    buildpack # Cloud Native buildpacks
    cargo-edit # Easy Rust dependency management
    cargo-graph # Rust dependency graphs
    consul # Service discovery et al
    crystal # Like Ruby but faster and with types
    curl # An old classic
    depends # Defined above
    dhall # Exotic, Nix-like configuration language
    direnv # Per-directory environment variables
    doctl # DigitalOcean CLI tool
    elixir # OTP with cool syntax
    erlang # OTP with weird syntax
    exa # ls replacement written in Rust
    fd # find replacement written in Rust
    fzf # Fuzzy finder
    gitAndTools.delta # Print Git diffs
    gitAndTools.gh # Official GitHub CLI tool
    go # Pretty okay language
    graphviz # dot
    htop # Resource monitoring
    httpie # Like curl but more user friendly
    hugo # Best static site generator ever
    jq # JSON parsing for the CLI
    just # Intriguing new make replacement
    kubectl # Kubernetes CLI tool
    kubectx # kubectl context switching
    kubernetes-helm # Kubernetes package manager
    lorri # nix-env for your projects
    lua5 # My second-favorite language from Brazil
    mdcat # Markdown converter/reader for the CLI
    minikube # Local Kubernetes
    niv # Nix dependency management
    nodejs # node and npm
    nomad # Lightweight scheduler
    nushell # Experimental shell
    packer # HashiCorp tool for building machine images
    prometheus # Monitoring system
    protobuf # Protocol Buffers
    python3 # Have you upgraded yet???
    python38Packages.pip # pip installer
    ripgrep # grep replacement written in Rust
    ruby # An old classic
    rustup # Rust dev environment management
    sd # Fancy sed replacement
    shards # Package management tool for the Crystal language
    skaffold # Local Kubernetes dev tool
    skim # High-powered fuzzy finder written in Rust
    spotify-tui # Spotify interface for the CLI
    starship # Fancy shell that works with zsh
    tealdeer # tldr for various shell tools
    terraform # Declarative infrastructure management
    tilt # Fast-paced Kubernetes development
    tokei # Handy tool to see lines of code by language
    tree # Should be included in macOS but it's not
    vault # Secret management
    watchexec # Fileystem watcher/executor useful for speedy development
    wget # File getter
    wrangler # CloudFlare Workers CLI tool
    xsv # CSV file parsing utility
    yarn # Node.js package manager
    youtube-dl # Download videos
  ];
}
