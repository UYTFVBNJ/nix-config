{config, lib, pkgs, isDesktop, ...}: {
  ##################################################################################################################
  #
  # All Ryan's Home Manager Configuration
  #
  ##################################################################################################################

  imports = [
    ../../home/core.nix
    ../../home/cli
  ] ++ lib.optionals isDesktop [
    ../../home/gui
  ];

  programs.git = {
    userName = "Julian Gao";
    userEmail = "juytfvbng@gamil.com";
  };

  age.secrets."github-token" = {
    file = ../../secrets/github-token.age; 
    path = "${config.home.homeDirectory}/.local/share/agenix/github-token";
  };
  
}
