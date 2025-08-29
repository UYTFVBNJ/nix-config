{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vim
    neovim
    tmux
    curl
    wget
    git
    htop
    tree
    ripgrep
    fd
    bat
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig = ''
      set -g mouse on
      set -g default-terminal "screen-256color"
      
      # Enable scrolling with mouse wheel
      set -g terminal-overrides 'xterm*:smcup@:rmcup@'
      
      # Vi-style scrolling
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      
      # Pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Increase scrollback buffer
      set -g history-limit 10000
    '';
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    '';
  };

  programs.git = {
    enable = true;
    userName = "lighthouse";
    userEmail = "user@example.com";
  };

  home.activation = {
    installSDKMAN = config.lib.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.sdkman" ]; then
        $DRY_RUN_CMD curl -s "https://get.sdkman.io" | bash
      fi
    '';
    
    installNVM = config.lib.dag.entryAfter ["writeBoundary"] ''
      if [ ! -d "$HOME/.nvm" ]; then
        $DRY_RUN_CMD curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
      fi
    '';
  };
}