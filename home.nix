{ config, pkgs, ... }:

{
  home.username = "blue";
  home.homeDirectory = "/home/blue";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    vscode
    obsidian
    anki
    qbittorrent
    neovim
    vimPlugins.LazyVim
    bun
    wget
    htop
    unzip
    tree
    btop
    fastfetch
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Dark+";
      font-size = 11;
      cursor-style = "block";
      shell-integration-features = "no-cursor";
      background-opacity = 0.95;
      background-blur-radius = 20;
      window-decoration = false; 
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = "$directory$nix_shell$git_branch$cmd_duration$character";
      add_newline = false;

      cmd_duration = {
        min_time = 2750;
        format = "[$duration]($style) ";
        style = "yellow bold";
      };

      character = {
        success_symbol = "[🌲🐦🫐](bold green)";
        error_symbol = "[🍁🦩🐞](bold red)";
      };

      nix_shell = {
        symbol = "❄️ ";
        format = "via [$symbol$state]($style) ";
        style = "bold blue";
      };

      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = "[$symbol$branch]($style) ";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "schememaster333";
        email = "schememaster333@gmail.com";
      };
      core = {
        editor = "nvim";
      };
      alias = {
        la = "log --graph --oneline --decorate --all";
        last = "log -1 HEAD";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.mpv = {
    enable = true;

    config = {
      sub-auto = "all";
      target-colorspace-hint = "no";
    };

    bindings = {
      "alt+j" = "add sub-scale +0.1";
      "alt+k" = "add sub-scale -0.1";
    };
  };

  programs.tmux = {
    enable = true;

    extraConfig = ''
      # hi there

      set-option -g default-shell ${pkgs.fish}/bin/fish

      # This ensures images are cleared when you switch panes
      set -g visual-activity off
      # Allow programs to bypass tmux and talk to Ghostty directly
      set -g allow-passthrough on

      # Ensure tmux identifies as a modern terminal
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ',xterm-ghostty:RGBA'

      set -g prefix C-a
      unbind C-b
      bind C-a send-prefix

      set -g history-limit 10000
      set -g mouse on
      set -s escape-time 0

      set -g base-index 1
      setw -g pane-base-index 1
      setw -g automatic-rename on

      set -g status-style bg=#171717,fg=white
      set -g status-left '#[fg=#2563eb,bold]   '
      setw -g window-status-current-style bg=#171717,fg=#2563eb,bold
      setw -g window-status-style bg=default,fg=white
      set -g status-right-length 100
      set -g status-right '#[fg=#059669]Only advance, stop at nothing to advance #[fg=yellow]%Y-%m-%d #[fg=#9333ea]%H:%M'

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      bind r source-file ~/.tmux.conf \; display "Config Reloaded!"

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
    '';
  };

  programs.zathura = {
    enable = true;
  };

  programs.ranger = {
    enable = true;
    package = pkgs.ranger.override { 
      python3Packages = pkgs.python3Packages; 
    };
    extraPackages = with pkgs; [
      python3Packages.pillow
    ];
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
  };

}
