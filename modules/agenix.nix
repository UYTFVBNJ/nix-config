{
  pkgs,
  lib,
  username,
  ...
}: {
    age.secrets."github-token" = {
    file = ../secrets/github-token.age;  # path in your repo
    owner = "gh";                       # your user
    group = "users";
    mode = "0400";
    # optional: choose exact path
    # path = "/home/gh/.config/github/token";
  };
}