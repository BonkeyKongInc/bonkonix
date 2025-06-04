{ ... }: {
  imports = [
  ];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  programs.niri.enable = true;
}

