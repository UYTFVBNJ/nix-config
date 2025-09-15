{ config, pkgs, ... }:

{
  home.username = "gh";
  home.homeDirectory = "/home/gh";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}