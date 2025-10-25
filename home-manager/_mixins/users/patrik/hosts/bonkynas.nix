{ lib, pkgs, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git = {
    userEmail = lib.mkForce "patrikwerner88@hotmail.com";
  };
  home.packages = with pkgs; [ 
    transmission_4
    ddrescue
  ];
}
