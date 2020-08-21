# tmux settings

{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "b";

    # Replaces ~/.tmux.conf
    extraConfig = ''
      set-option -g mouse on
      set-option -g default-shell ''${SHELL}

      set -g mode-keys emacs
      set -g status-keys emacs

      bind Escape copy-mode

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5

      bind N previous-window
    '';
  };
}
