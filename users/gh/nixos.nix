{pkgs, ...}: 
{
  ##################################################################################################################
  #
  # NixOS Configuration
  #
  ##################################################################################################################

  users.users.gh = {
    # gh's authorizedKeys
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.nushell;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFICD+f6OtSPrPfA8q0nLUvtdd8oxE0RTr79Vmdvhkh7 juytfvbng@gmail.com"
    ];
    hashedPassword = "$6$GHCrtVBjRySIEVtW$QZy34LOwbz80CzjUPVkPxEdhhdlYwwrLvJxB0tmdDoctZq93HUw69nNoyfylF8tZwVwUHSrm2juWyR1Iv6P4q.";
  };
}
