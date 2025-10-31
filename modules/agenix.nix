{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  age.secrets."github-token" = {
    file = ../secrets/github-token.age;  # path in your repo
    owner = "${username}";                       # your user
    group = "users";
    mode = "0400";
    # optional: choose exact path
    path = "${config.users.users.${username}.home}/.local/share/agenix/github-token";
  };
  age.secrets."mihomo-config" = {

    file = ../secrets/mihomo-config.age;
    owner = "root";
    group = "root";
    mode = "0400";
    path = "/etc/mihomo/config.yaml";
  };
}