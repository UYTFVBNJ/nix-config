{ config, pkgs, ... }:

{
  imports = [ ../modules/macos.nix ];

  users.users.lighthouse = {
    home = "/Users/lighthouse";
    shell = pkgs.bash;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];
    
    brews = [
      "mas"
    ];
    
    casks = [
      "font-jetbrains-mono"
      "raycast"
      "rectangle"
      "stats"
      "the-unarchiver"
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      tilesize = 48;
    };
    
    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    
    NSGlobalDomain = {
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}