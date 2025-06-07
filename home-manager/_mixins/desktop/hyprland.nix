{ config, pkgs, lib , ... }:
with lib.hm.gvariant;
{

  home = {
    file = {
      "${config.xdg.configHome}/hypr/hyprland.conf".text = builtins.readFile ./hyprland.conf;
      "${config.xdg.configHome}/hypr/hyprlock.conf".text = builtins.readFile ./hyprlock.conf;
      "${config.xdg.configHome}/hypr/hypridle.conf".text = builtins.readFile ./hypridle.conf;
    };
    packages = with pkgs; [
      nemo
      wofi
      waybar
      wl-clipboard-rs
    ];

  };

}
