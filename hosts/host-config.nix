{ lib, config, ... }:
{
  options.machine.isDesktop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether this host has a graphical desktop environment.";
  };
}