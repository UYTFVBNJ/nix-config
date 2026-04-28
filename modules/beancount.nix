{
  pkgs,
  lib,
  username,
  ...
}: {
  environment.systemPackages = [
    pkgs.beancount
    pkgs.fava
  ];
}

