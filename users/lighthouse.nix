{ config, pkgs, ... }:

{
  home.username = "lighthouse";
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/lighthouse" else "/home/lighthouse";
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}