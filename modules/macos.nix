{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
    wezterm
    raycast
    rectangle
    stats
    the-unarchiver
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
          macos_window_background_blur = 70,
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

  programs.bash.bashrcExtra = ''
    # macOS-specific aliases
    alias ls='ls -G'
    alias ll='ls -laG'
    alias brewup='brew update && brew upgrade && brew cleanup'
  '';
}