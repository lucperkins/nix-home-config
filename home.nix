{ config, lib, ... }:

let
  nigpkgsRev = "nixpkgs-unstable";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${nigpkgsRev}.tar.gz") {};

  # Import other Nix files
  imports = [
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


  git-hash = pkgs.writeScriptBin "git-hash" ''
    nix-prefetch-url --unpack https://github.com/$1/$2/archive/$3.tar.gz
  '';

  wo = pkgs.writeScriptBin "wo" ''
    readlink $(which $1)
  '';

  run = pkgs.writeScriptBin "run" ''
    nix-shell --pure --run "$@"
  '';

  hugoLocal = pkgs.callPackage ./hugo.nix {
    hugoVersion = "0.74.3";
    sha = "0rikr4yrjvmrv8smvr8jdbcjqwf61y369wn875iywrj63pyr74r9";
    vendorSha = "031k8bvca1pb1naw922vg5h95gnwp76dii1cjcs0b1qj93isdibk";
  };

  scripts = [
    depends
    git-hash
    run
    wo
  ];

  pythonPackages = with pkgs.python38Packages; [
    bpython
    openapi-spec-validator
    pip
    requests
    setuptools
  ];

  rubyPackages = with pkgs.rubyPackages_2_7; [
    jekyll
    jekyll-watch
    pry
    rails
  ];

  gitTools = with pkgs.gitAndTools; [
    delta
    diff-so-fancy
    git-codeowners
    gitflow
    gh
  ];

in {
  inherit imports;

  # Allow non-free (as in beer) packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  home = {
    username = "lucperkins";
    homeDirectory = "/Users/lucperkins";
    stateVersion = "20.09";
  };

  # Golang
  programs.go.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

  # Miscellaneous packages (in alphabetical order)
  home.packages = with pkgs; [
    adoptopenjdk-bin # Java
    ansible # Deployment done right
    antora # AsciiDoc static site generator
    autoconf # Broadly used tool, no clue what it does
    awscli # Amazon Web Services CLI
    bash # /bin/bash
    bat # cat replacement written in Rust
    bazelisk # Polyglot build tool from Google
    buildpack # Cloud Native buildpacks
    buildkit # Fancy Docker
    cachix # Nix build cache
    cargo-edit # Easy Rust dependency management
    cargo-graph # Rust dependency graphs
    cargo-watch # Watch a Rust project and execute custom commands upon change
    circleci-cli # Run CirleCI locally
    conftest
    consul # Service discovery et al
    #crystal # Like Ruby but faster and with types
    cue # Experimental configuration language
    curl # An old classic
    dhall # Exotic, Nix-like configuration language
    direnv # Per-directory environment variables
    doctl # DigitalOcean CLI tool
    docker # World's #1 container tool
    docker-compose # Local multi-container Docker environments
    docker-machine # Docker daemon for macOS
    elixir # OTP with cool syntax
    erlang # OTP with weird syntax
    exa # ls replacement written in Rust
    fd # find replacement written in Rust
    fluxctl # GitOps operator
    fzf # Fuzzy finder
    google-cloud-sdk # Google Cloud Platform CLI
    graphviz # dot
    gnupg # gpg
    gradle
    heroku
    htop # Resource monitoring
    httpie # Like curl but more user friendly
    hugoLocal # Best static site generator ever
    humioctl # Humio logging CLI tool
    jq # JSON parsing for the CLI
    jsonnet # Easy config language
    just # Intriguing new make replacement
    kind # Easy Kubernetes installation
    kompose
    kotlin
    kubectl # Kubernetes CLI tool
    kubectx # kubectl context switching
    kubernetes-helm # Kubernetes package manager
    kustomize
    lorri # Easy Nix shell
    lua5 # My second-favorite language from Brazil
    mdcat # Markdown converter/reader for the CLI
    minikube # Local Kubernetes
    ngrok # Expose local HTTP stuff publicly
    niv # Nix dependency management
    nix-serve
    nixos-generators
    nodejs # node and npm
    nomad # Lightweight scheduler
    nushell # Experimental shell
    packer # HashiCorp tool for building machine images
    pinentry_mac # Necessary for GPG
    podman # Docker alternative
    pre-commit # Pre-commit CI hook tool
    #prometheus # Monitoring system
    protobuf # Protocol Buffers
    prow
    pulumi-bin # Infrastructure as code
    python3 # Have you upgraded yet???
    rebar3 # Erlang build
    ripgrep # grep replacement written in Rust
    ruby_2_7 # An old classic
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
    vagrant # Virtualization made easy
    vault # Secret management
    vgo2nix # Package Go modules projects
    vscode # My fav text editor if I'm being honest
    wasmer
    wget
    watchexec # Fileystem watcher/executor useful for speedy development
    wrangler # CloudFlare Workers CLI tool
    xsv # CSV file parsing utility
    yarn # Node.js package manager
    youtube-dl # Download videos
    zola # Static site generator written in Rust
  ] ++ gitTools ++ pythonPackages ++ rubyPackages ++ scripts;
}
