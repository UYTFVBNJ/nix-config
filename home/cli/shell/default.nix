{config, ...}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./nushell
    ./common.nix
    ./starship.nix
  ];

  # add environment variables
  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = cache + "/less/history";
    LESSKEY = c + "/less/lesskey";
    WINEPREFIX = d + "/wine";

    # set default applications
    EDITOR = "vim";
    BROWSER = "firefox";
    TERMINAL = "wezterm";

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";

    # GH TOKEN
    # GITHUB_TOKEN = config.age.secrets."github-token".path;
    # GH_TOKEN     = config.age.secrets."github-token".path;
  };

  home.shellAliases = {
    k = "kubectl";
  };
}
