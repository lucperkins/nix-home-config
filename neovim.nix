# Neovim settings

{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # Sets alias vim=nvim
    vimAlias = true;

    # Neovim plugins
    plugins = with pkgs.vimPlugins; [
      ctrlp
      editorconfig-vim
      gruvbox
      nerdtree
      tabular
      vim-elixir
      vim-nix
      vim-markdown
    ];
  };
}