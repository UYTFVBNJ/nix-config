{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/gui.nix
    ../modules/proxy.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.lighthouse = {
    isNormalUser = true;
    description = "lighthouse";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    dmenu
    waybar
    swaylock
    swayidle
    wl-clipboard
    mako
    grim
    slurp
    wf-recorder
  ];

  programs.bash.completion.enable = true;

  system.stateVersion = "23.05";
}