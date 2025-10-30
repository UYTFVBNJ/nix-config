let
  # host keys (or user keys). You can also do "github:ryantm" style.
  mars  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcwSV9lKdLwRMBHq6ue3CxE0NsS/2D85YScjGb4t3Zk root@mars";

in {
  "github-token.age".publicKeys = [ mars ];
}
