{ config, lib, pkgs, ... }:
with lib.hm.gvariant;
{

  home= { 
    file = {
      "${config.xdg.configHome}/rofi/config.rasi".text    = builtins.readFile ./hyprland/config.rasi;
    };
    packages = with pkgs; [
      xclip
      rofi
    ];
  };
  services.picom = {
    enable = true;
    settings = {
      corner-radius = 8;
      opacity-rule = [
        "80:focused && class_g = 'kitty'"
        "50:!focused && class_g = 'kitty'"
        "90:class_g = 'firefox'"
        "90:class_g = 'URxvt'"
        "50:class_g = 'Xfce4-panel'"

      ];
      blur-method = "dual_kawase";
      blur-strength = 3;
      blur-background = true;
      blur-background-frame = true;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
      
      shadow = true;
      shadow-radius = 12;
      shadow-offset-x = -15;
      shadow-offset-y = -15;
      backend = "glx";
      vsync = true;

      #      blur = {
      #        method = "dual_kawase";
      #        strength = 7;
      #
        #        background = true;
        #        background-frame = true;
        #
        ## Exclude certain windows from blur
        #        background-exclude = [
        #          "window_type = 'dock'"
        #          "window_type = 'desktop'"
        #        ];

      #      };
    };
  };
}
