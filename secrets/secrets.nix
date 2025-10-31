let
  # host keys (or user keys). You can also do "github:ryantm" style.
  mars  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcwSV9lKdLwRMBHq6ue3CxE0NsS/2D85YScjGb4t3Zk root@mars";
  moon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILMPoVHasAuJwe2KS7k8Ddcvar+eb9D6oW5kvfa+iv4l root@moon";
in {
  "github-token.age".publicKeys = [ mars moon ];
  "mihomo-config.age".publicKeys = [ mars moon ];
}
