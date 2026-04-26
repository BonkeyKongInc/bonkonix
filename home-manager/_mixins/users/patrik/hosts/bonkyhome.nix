{ lib, pkgs,... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git.settings.user.email = lib.mkForce "patrikwerner88@hotmail.com";
  # host specific apps
  home.packages = with pkgs; [ 
    fastfetch
    reaper
    libsecret
    networkmanagerapplet 
    betaflight-configurator
    musescore
    nextcloud-client
    #kicad
    ultrastardx
    traceroute
    dig
    openssl
  ];
}
