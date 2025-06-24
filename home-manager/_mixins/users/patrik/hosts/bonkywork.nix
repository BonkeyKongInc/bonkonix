{ lib, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git.userEmail = "patrik.werner@airolit.com";
}
