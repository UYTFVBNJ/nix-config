{
  pkgs,
  lib,
  ...
}: {
  services = {
    
    mihomo = {
      enable = true;
      tunMode = true;
      configFile = "/etc/mihomo/config.yaml";
    };
  };
}
