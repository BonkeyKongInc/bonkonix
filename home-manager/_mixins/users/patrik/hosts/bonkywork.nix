{ lib, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git = {
    enable = true;
    programs.git.userEmail = "patrik.werner@airolit.com";
  };
}
