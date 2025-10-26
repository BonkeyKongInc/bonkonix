let
  wallpapers = ../../../home-manager/_mixins/wallpapers;
in
{ pkgs, lib, ... }: {
  imports = [
  ];
  programs.hyprland.enable = true;

  services.gnome.gnome-keyring.enable = true;
  environment.etc."wallpapers".source = lib.mkForce wallpapers;

  networking.networkmanager.enable = true;
  networking.networkmanager.settings = {
          device = {
          "wifi.scan-rand-mac-address" = false;
        };
    };

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick = {
      enable = true;
    };
  };
  environment.etc."lightdm/slick-greeter.conf".text = lib.mkForce ''
    [Greeter]
    background=/etc/wallpapers/flux_close_ups.jpg
    theme-name=Adwaita
    icon-theme-name=Adwaita
    font-name=FiraCode 18
    cursor-theme-name=Adwaita
    cursor-theme-size=24
    draw-user-backgrounds=false
    #enable-hidpi=on
  '';
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [
    hyprpanel.hyprpanel
    hyprpaper
    hyprlock
    hypridle
  ];
