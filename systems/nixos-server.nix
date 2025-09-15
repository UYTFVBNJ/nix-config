{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/server.nix
    ../modules/proxy.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos-server";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.gh = {
    isNormalUser = true;
    description = "gh";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.fail2ban.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  environment.systemPackages = with pkgs; [
    ufw
    fail2ban
    logrotate
    rsync
    screen
  ];

  programs.bash.completion.enable = true;

  system.stateVersion = "25.05";
}