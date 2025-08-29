{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
    wezterm
    firefox
    spotify
    discord
    vscode
    bottles
    wine
    winetricks
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local config = {
          font_size = 20,
          color_scheme = "Modus-Vivendi",
          use_fancy_tab_bar = false,
          hide_tab_bar_if_only_one_tab = true,
          window_decorations = "RESIZE",
          show_new_tab_button_in_tab_bar = false,
          window_background_opacity = 0.9,
          text_background_opacity = 0.9,
          adjust_window_size_when_changing_font_size = false,
          window_padding = {
              left = 20,
              right = 20,
              top = 20,
              bottom = 5
          },
          initial_cols = 130,
          initial_rows = 28
      }
      return config
    '';
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "dmenu_run";
      
      keybindings = {
        "Mod4+Return" = "exec wezterm";
        "Mod4+d" = "exec dmenu_run";
        "Mod4+Shift+q" = "kill";
        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+e" = "exit";
        
        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";
        
        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";
        
        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        
        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
      };
      
      bars = [{
        position = "top";
        statusCommand = "while date +'%Y-%m-%d %I:%M:%S %p'; do sleep 1; done";
      }];
    };
  };
}