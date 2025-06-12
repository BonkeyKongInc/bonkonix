{ lib, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git.userEmail = "patrik.werner@airolit.com";
  home.packages = with pkgs; [ 
      microsoft-edge
      scrcpy
      gcc-arm-embedded-9
      prusa-slicer
      gimp
      qucs-s
      wkhtmltopdf
      teams
  ];
}
