{ config, pkgs, lib, ... }:
with lib.hm.gvariant;
{

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "eurosign:e" "caps:ctrl_modifier" ];
      sources = [ (mkTuple [ "xkb" "rip" ]) ];
    };
  };
  # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

  home = {
    file = {
      "${config.xdg.configHome}/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
    };
    packages = with pkgs; [
      nemo
      wofi
      waybar
      wl-clipboard-rs
      hyprpanel.hyprpanel
      #    hyprpanel
    ];
  };
}
