{ lib, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git = {
    programs.git.userEmail = lib.mkForce "patrikwerner88@hotmail.com";
  };
}
