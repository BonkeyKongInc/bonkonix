{ lib, pkgs, ... }:
with lib.hm.gvariant;
{
  imports = [ ];
  dconf.settings = { };
  programs.git.userEmail = "patrik.werner@airolit.com";
  home = {
    packages = with pkgs; [
      microsoft-edge
      qgroundcontrol
      mission-planner
      mavproxy
      mediamtx
      powertop
      kdePackages.filelight
      lsof
      v4l-utils
      netcat
      traceroute
      opencode
    ];
  };
}
