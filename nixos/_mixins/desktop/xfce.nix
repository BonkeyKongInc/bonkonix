let
  wallpapers = ../../../home-manager/_mixins/wallpapers;
in
{ pkgs, lib, ... }: {
  imports = [
  ];
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  environment.etc."wallpapers".source = lib.mkForce wallpapers;
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
}
