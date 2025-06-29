{ lib, pkgs,... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git.userEmail = lib.mkForce "patrikwerner88@hotmail.com";
  # host specific apps
  home.packages = with pkgs; [ 
    fastfetch
    reaper
    libsecret
    networkmanagerapplet 
  ];
}
