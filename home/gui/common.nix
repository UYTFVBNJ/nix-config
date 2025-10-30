{
  lib,
  pkgs,
  catppuccin-bat,
  pkgsUnstable,
  ...
}: {
  home.packages = (with pkgs; [

    # misc
    libnotify
    wineWowPackages.wayland
    xdg-utils


    # productivity
    # obsidian

    

    # IDE
    insomnia
    vscode

    # cloud native


    # db related
    dbeaver-bin
  ]) ++ (with pkgsUnstable; [

  ]);

  
  services = {
    # auto mount usb drives
    udiskie.enable = true;
  };
}
