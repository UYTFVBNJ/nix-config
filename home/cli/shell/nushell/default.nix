{ config, ... }:
{
  programs.nushell = {
    enable = true;
    extraEnv =
    let
      tokenPath = config.age.secrets."github-token".path;
    in ''
      # other envs
      $env.EDITOR = "vim"
      $env.BROWSER = "firefox"
      $env.TERMINAL = "wezterm"

      # read real token at runtime
      let token = (open "${tokenPath}" | str trim)
      $env.GITHUB_TOKEN = $token
      $env.GH_TOKEN     = $token
    '';
  };
}
