{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
    neofetch
    nmap
    tcpdump
    iftop
    iotop
    lsof
    strace
  ];

  programs.bash.bashrcExtra = ''
    # Server-specific aliases
    alias ll='ls -la'
    alias la='ls -A'
    alias l='ls -CF'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias df='df -h'
    alias free='free -h'
    alias ps='ps aux'
  '';
}