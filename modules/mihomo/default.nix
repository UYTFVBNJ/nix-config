{
  pkgs,
  lib,
  ...
}: {
  services = {
    
    mihomo = {
      enable = true;
      tunMode = true;
      configFile = ./config.yaml;
    };
  };
}
