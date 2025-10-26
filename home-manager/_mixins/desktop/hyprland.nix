{ config, pkgs, lib, ... }:
with lib.hm.gvariant;
{

  home = {
    file = {
      "${config.xdg.configHome}/hypr/hyprland.conf".text = builtins.readFile ./hyprland/hyprland.conf;
      "${config.xdg.configHome}/hypr/hyprlock.conf".text = builtins.readFile ./hyprland/hyprlock.conf;
      "${config.xdg.configHome}/hypr/hypridle.conf".text = builtins.readFile ./hyprland/hypridle.conf;
      "${config.xdg.configHome}/rofi/config.rasi".text = builtins.readFile ./hyprland/config.rasi;
    };
    packages = with pkgs; [
      nemo
      sysmenu
      rofi-wayland
      waybar
      wl-clipboard-rs
    ];

  };

}
