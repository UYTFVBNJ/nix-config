{ config, ... }:
{
  programs.nushell = {
    enable = true;
    extraEnv = ''
      $env.EDITOR = "vim"
      $env.BROWSER = "firefox"
      $env.TERMINAL = "wezterm"
      $env.GITHUB_TOKEN = "${config.age.secrets."github-token".path}"
      $env.GH_TOKEN     = "${config.age.secrets."github-token".path}"
    '';
  };
}
