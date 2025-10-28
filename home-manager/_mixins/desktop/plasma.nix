{ lib, pkgs, ... }:
with lib.hm.gvariant;
{
  gtk = { };
  services.kdeconnect.enable = true;

  home = {
    packages = with pkgs; [
      xclip
    ];
  };
}
