{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    # ... Other options ...
    extraConfig = {
      # this is the same helper you tried to run by hand
      credential.helper = ''
        !f() {
          echo "username=x-access-token"
          echo "password=$GH_TOKEN"
        }; f
      '';
    };
  };
}
